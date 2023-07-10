//same for commercial building, housevilla, pending project,

import 'package:flutter/material.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../services/model/ads_models.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import 'details_row.dart';
import '../../../widgets_refactored/icon_button.dart';

class BottomDetailsSheet extends StatelessWidget {
  const BottomDetailsSheet({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    this.adsModel,
  });

  final double screenWidth;
  final double screenHeight;
  final AdsModel? adsModel;

  @override
  Widget build(BuildContext context) {
    final primaryDetails = adsModel!.categoryInfo['primary_details'];
    final moreInfo = adsModel!.categoryInfo['more_info'];
    return DraggableScrollableSheet(
      initialChildSize: .3,
      minChildSize: .3,
      maxChildSize: .8,
      builder: (BuildContext context, ScrollController scrollController) {
        return ListView.builder(
          itemCount: 1,
          controller: scrollController,
          itemBuilder: (context, index) {
            return Container(
              width: screenWidth,
              height: screenHeight * .8,
              decoration: BoxDecoration(
                color: bottomSheetcolor.withOpacity(.96),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(kpadding15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(adsModel!.adsTitle,
                              // "Modern Restaurant aluva",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        kWidth5,
                        const Icon(
                          Icons.favorite_border_outlined,
                          color: kWhiteColor,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: kWhiteColor,
                        ),
                        kWidth5,
                        Text(
                          adsModel!.categoryInfo["ads_address"],
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                    kHeight10,
                    DashedLineGenerator(
                        width: screenWidth, color: kDottedBorder),
                    kHeight10,
                    DetailsRow(
                      details: primaryDetails,
                    ),
                    kHeight10,
                    DashedLineGenerator(
                        width: screenWidth, color: kDottedBorder),
                    kHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "₹",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 19),
                            children: [
                              TextSpan(
                                text: " 98000",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 28),
                              ),
                              TextSpan(
                                text: "/-",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        kWidth10,
                        IconWithButtonBottom(
                          onpressed: () {},
                          iconData: Icons.rocket_launch_outlined,
                          text: "Chat Now",
                          radius: 10,
                          size: const Size(180, 50),
                        )
                      ],
                    ),
                    kHeight20,
                    DashedLineGenerator(
                        width: screenWidth, color: kPrimaryColor),
                    kHeight10,
                    DetailsRow(
                      details: moreInfo,
                    ),
                    kHeight10,
                    DashedLineGenerator(
                        width: screenWidth, color: kPrimaryColor),
                    kHeight10,
                    Text(
                      'Description',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    Expanded(
                      child: Text(
                        adsModel!.description,
                        // 'Kalyan Gateway is our new upcoming luxury apartment project in Trivandrum. Located at NH Bypass, in close proximity to the IT Technopark and the upcoming Lulu Mall, these 2 and 3 BHK luxury flats are ideal for the increasing young and vibrant crowd in the city.',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 13,
                                  color: const Color(0XFF878181),
                                ),
                      ),
                    ),
                    DashedLineGenerator(
                        width: screenWidth, color: kPrimaryColor),
                    kHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: adsModel!.categoryInfo['more_info']
                                ['Landmark'],
                            //"Near PRS Hospital",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontSize: 13,
                                    color: const Color(0XFF878181)),
                            children: [
                              TextSpan(
                                // ignore: prefer_interpolation_to_compose_strings
                                text: '\n' +
                                    adsModel!.categoryInfo['more_info']
                                        ['Website'],
                                //"\nwww.calletic.com",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 19),
                              ),
                            ],
                          ),
                        ),
                        kWidth15,
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              opacity: 0.3,
                              image: AssetImage('assets/images/dummy/Room.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 13),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Floor',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 10, color: kWhiteColor),
                                  children: [
                                    TextSpan(
                                      text: '\nPlan',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            fontSize: 10,
                                          ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              opacity: 0.4,
                              image:
                                  AssetImage('assets/images/dummy/lands.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Land',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 10, color: kWhiteColor),
                                  children: [
                                    TextSpan(
                                      text: '\nSketch',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(fontSize: 10),
                                    ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                    kHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconWithButtonBottom(
                          onpressed: () {
                            launch("tel://8893917626");
                          },
                          text: "Give a Call",
                          iconData: Icons.phone,
                          radius: 100,
                          size: const Size(100, 51),
                        ),
                        IconWithButtonBottom(
                          background: Colors.green,
                          onpressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(
                                        Icons.phone,
                                        color: kPrimaryColor,
                                      ),
                                      title: const Text(
                                        'Phone Messenger',
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                      onTap: () {
                                        const phoneNumber = '8893917626';
                                        const message =
                                            'Your message goes here';

                                        const url =
                                            'sms:$phoneNumber?body=$message';

                                        launch(url);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        Icons.message,
                                        color: kPrimaryColor,
                                      ),
                                      title: const Text(
                                        'WhatsApp Messenger',
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                      onTap: () {
                                        const phoneNumber = '8893917626';
                                        const message =
                                            'Your message goes here';

                                        const url =
                                            'whatsapp://send?phone=$phoneNumber&text=$message';
                                        launch(url);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          text: "Message Me",
                          iconData: Icons.message,
                          radius: 100,
                          size: const Size(100, 51),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
