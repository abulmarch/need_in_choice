import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:need_in_choice/services/model/ads_models.dart';
import 'package:need_in_choice/views/pages/home_page/widgets.dart/advertisement_card_widget.dart';

import '../../../../services/repositories/repository_urls.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import 'edit_button.dart';

class Adtiles extends StatelessWidget {
  final AdsModel adsData;
  const Adtiles({
    super.key,
    required this.adsData,
  });

  @override
  Widget build(BuildContext context) {
    List imageList = adsData.images;
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: imageList.isNotEmpty
                      ? Image.network(
                          '$imageUrlEndpoint${imageList[0]}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            kNoAdImage,
                            fit: BoxFit.cover,
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
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      'Active',
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
                              color: kPrimaryColor.withOpacity(.42)),
                      children: [
                        TextSpan(
                            text: "\ncurrently live",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 9))
                      ]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            kWidth5,
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
                  const Text(
                    '-------------------------',
                    style: TextStyle(height: 0.7, color: kDottedBorder),
                  ),
                  kHeight10,
                  Row(
                    children: [
                      viewItem(
                        context,
                        icon: Icons.remove_red_eye_outlined,
                        text: 'Views',
                        count: 15,
                      ),
                      kWidth10,
                      viewItem(
                        context,
                        icon: Icons.favorite,
                        text: 'Likes',
                        count: 15,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          EditButton(
                            boxcolor: kadBox,
                            height: 23,
                            width: 71,
                            text: "Edit Ad",
                            textcolor: kPrimaryColor,
                            ontap: () {
                              log(adsData.categoryInfo['ads_levels']['route'].toString());
                              log(adsData.categoryInfo.toString());
                              Navigator.pushNamed(context, adsData.categoryInfo['ads_levels']['route'],arguments: adsData.id);
                            },
                          ),
                          const VerticalDivider(
                            color: kDarkGreyColor,
                            thickness: 5,
                            width: 10,
                            indent: 20,
                            endIndent: 0,
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
