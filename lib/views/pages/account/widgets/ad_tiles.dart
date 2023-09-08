import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/services/model/ads_models.dart';
import '../../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../../config/theme/screen_size.dart';
import '../../../../services/repositories/repository_urls.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import 'edit_button.dart';

class Adtiles extends StatelessWidget {
  final AdsModel adsData;
  const Adtiles({
    super.key,
    required this.adsData,
  });

  @override
  Widget build(BuildContext context) {
    final width = ScreenSize.size.width;
    List imageList = adsData.images;

    //  DateTime creationDate = DateTime.parse(adsData.createdDate);
    //  DateTime expirationDate = creationDate.add(const Duration(days: 30));

    DateTime expirationDate = DateTime.parse(adsData.expiratedDate);
    bool isExpired = expirationDate.isBefore(DateTime.now());
   

    return Card(
      color: kadBox,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        height: 138,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            kWidth5,
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: imageList.isNotEmpty
                        ? ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(kpadding10)),
                            child: Image.network(
                              '$imageUrlEndpoint${imageList[0]}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                kNoAdImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(kpadding10)),
                            child: Image.asset(
                              kNoAdImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  kHeight5,
                  Container(
                    height: 20,
                    width: 80,
                    decoration: BoxDecoration(
                      color: isExpired ? Colors.red : kPrimaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        isExpired ? 'Expired' : 'Active',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 10),
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "The Ad is",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontSize: 9,
                                color: isExpired
                                    ? Colors.red.withOpacity(.42)
                                    : kPrimaryColor.withOpacity(.42)),
                        children: [
                          TextSpan(
                              text: isExpired
                                  ? "\ncurrently expired"
                                  : "\ncurrently live",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontSize: 9,
                                      color: isExpired
                                          ? Colors.red
                                          : kPrimaryColor))
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            kWidth20,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adsData.adsTitle,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: const Color(0xff606060),
                        ),
                  ),
                  kHeight5,
                  SizedBox(
                    width: width * .5,
                    child: const MySeparator(color: kDottedBorder),
                  ),
                  kHeight10,
                  Row(
                    children: [
                      viewItem(
                        context,
                        icon: Icons.remove_red_eye_outlined,
                        text: 'Views',
                        count: 0,
                      ),
                      kWidth5,
                      const SizedBox(
                        height: 15,
                        child: VerticalDivider(
                          color: kLightGreyColor,
                          thickness: 1,
                          width: 1,
                        ),
                      ),
                      kWidth5,
                      viewItem(
                        context,
                        icon: Icons.favorite,
                        text: 'Likes',
                        count: 0,
                      ),
                    ],
                  ),
                  kHeight10,
                  Container(
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          EditButton(
                            boxcolor: kadBox,
                            height: 23,
                            width: 71,
                            text: isExpired ? "Renew" : "Edit Ad",
                            textcolor: isExpired
                                ? kDarkGreyColor.withOpacity(.8)
                                : kPrimaryColor,
                            ontap: () {
                              BlocProvider.of<AdCreateOrUpdateBloc>(context)
                                  .add(SwitchToInitialStateEvent());
                              Navigator.pushNamed(context, adsData.routeName,
                                  arguments: adsData.id);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              color: kLightGreyColor,
                              thickness: 1,
                              width: 1,
                            ),
                          ),
                          EditButton(
                            boxcolor: kPrimaryColor,
                            height: 23,
                            width: 100,
                            text: "Mark as Sold",
                            textcolor: kWhiteColor,
                            ontap: () {},
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            kWidth5,
          ],
        ),
      ),
    );
  }

  Row viewItem(BuildContext context,
      {IconData? icon, String? text, int? count}) {
    return Row(
      children: [
        Icon(
          icon,
          color: kDottedBorder,
          size: 20,
        ),
        kWidth5,
        Text(
          '$text : $count',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: 9, color: kDottedBorder),
        ),
      ],
    );
  }
}
