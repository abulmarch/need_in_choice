import 'package:flutter/material.dart';
import 'package:extended_text/extended_text.dart'
    show ExtendedText, TextOverflowWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets_refactored/icon_button.dart';
import '../../../widgets_refactored/image_upload_doted_circle.dart' show OtherAdsImagePreviewBox;
import '../../ad_detail/widgets/details_row.dart';

class AdPreviewBottomSheetRealEstate extends StatelessWidget {
  const AdPreviewBottomSheetRealEstate({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    final adData = BlocProvider.of<AdCreateOrUpdateBloc>(context).adCreateOrUpdateModel;
    return Container(
      width: screenWidth,
      height: screenHeight * 0.6,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )                  
      ),
      clipBehavior: Clip.hardEdge,
      child: DraggableScrollableSheet(
        initialChildSize: .3,
        minChildSize: .3,
        maxChildSize: 1,
        builder: (BuildContext context, ScrollController scrollController) {
          // return _existingListView(scrollController);
          return ListView.builder(
            itemCount: 1,
            controller: scrollController,
            itemBuilder: (context, index) {
              return Container(
                width: screenWidth,
                height: screenHeight * .76,
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          kWidth5,
                          Text(
                            adData.adsTitle,
                              // "Modern Restaurant aluva",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge),
                          const Spacer(),
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
                            adData.adsAddress,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                      kHeight5,
                      SizedBox(
                        width: screenWidth * .9,
                        child: const MySeparator(color: kDottedBorder),
                      ),
                      kHeight5,
                      DetailsRow(
                        details: adData.primaryData,
                      ),
                      kHeight10,
                      SizedBox(
                        width: screenWidth * .9,
                        child: const MySeparator(color: kDottedBorder),
                      ),
                      kHeight5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
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
                                      text: " 9800",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 28),
                                    ),
                                    TextSpan(
                                      text: "/",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 18),
                                    ),
                                    TextSpan(
                                      text: "prebid",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kBlackColor),
                                child: Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "₹ 98000 - ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 11),
                                      children: [
                                        TextSpan(
                                          text: "15 Jan - 20 Dec ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          kWidth20,
                          IconWithButton(
                            onpressed: () {},
                            iconData: Icons.rocket_launch_outlined,
                            text: "Chat Now",
                            radius: 10,
                            size: const Size(150, 50),
                          )
                        ],
                      ),
                      kHeight10,
                      SizedBox(
                        width: screenWidth * .9,
                        child: const MySeparator(color: kSecondaryColor),
                      ),
                      kHeight5,
                      DetailsRow(
                        details: adData.moreInfoData,
                      ),
                      kHeight10,
                      SizedBox(
                        width: screenWidth * .9,
                        child: const MySeparator(color: kSecondaryColor),
                      ),
                      kHeight5,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '  Description',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: ExtendedText(
                              'Kalyan Gateway is our new upcoming luxury apartment pro Technopark and the Kalyan Gateway is our new upcoming Kalyan Gateway echnopark and the Kalyan Gateway is our new upcoming Kalyan Gateway is our new upcoming luxury apartment pro Technopark and the up luxury apartment pro Technopark',
                              style: const TextStyle(
                                color: Color(0XFF878181),
                              ),
                              maxLines: 3,
                              overflowWidget: TextOverflowWidget(
                                child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Description',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      color: kPrimaryColor),
                                            ),
                                            content: Text(
                                              'Kalyan Gateway is our new upcoming luxury apartment project in Trivandrum. Located at NH Bypass, in close proximity to the IT Technopark and the upcoming Lulu Mall, these 2 and 3 BHK luxury flats are ideal for the increasing young and vibrant crowd in the city.',

                                              // adsModel.description,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                    fontSize: 13,
                                                    color:
                                                        const Color(0XFF878181),
                                                  ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      '... Read More',
                                      style: TextStyle(
                                          fontSize: 15, color: kPrimaryColor),
                                    )),
                              ), //Text('... Read More'),
                            ),
                          ),
                        ],
                      ),
                      kHeight10,
                      SizedBox(
                        width: screenWidth * .9,
                        child: const MySeparator(color: kDottedBorder),
                      ),
                      kHeight10,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text:"Near PRS Hospital",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        fontSize: 13,
                                        color: const Color(0XFF878181)),
                                children: [
                                  TextSpan(
                                    text:"\nwww.calletic.com",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            kWidth20,
                            const OtherAdsImagePreviewBox(
                              documentTypeName: 'Floor Plan',
                            defaultImage: 'assets/images/dummy/Room.jpg',
                            ),
                            const OtherAdsImagePreviewBox(
                              documentTypeName: 'Land Sketch',
                              defaultImage: 'assets/images/dummy/lands.jpg',
                            ),
                            // Container(
                            //   height: 50,
                            //   width: 50,
                            //   decoration: BoxDecoration(
                            //     image: const DecorationImage(
                            //       opacity: 0.3,
                            //       image: AssetImage(
                            //           'assets/images/dummy/Room.jpg'),
                            //       fit: BoxFit.cover,
                            //     ),
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(top: 13),
                            //     child: RichText(
                            //         textAlign: TextAlign.center,
                            //         text: TextSpan(
                            //           text: 'Floor',
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .titleLarge!
                            //               .copyWith(
                            //                   fontSize: 10, color: kWhiteColor),
                            //           children: [
                            //             TextSpan(
                            //               text: '\nPlan',
                            //               style: Theme.of(context)
                            //                   .textTheme
                            //                   .headlineSmall!
                            //                   .copyWith(
                            //                     fontSize: 10,
                            //                   ),
                            //             ),
                            //           ],
                            //         )),
                            //   ),
                            // ),
                            // Container(
                            //   height: 50,
                            //   width: 50,
                            //   decoration: BoxDecoration(
                            //     image: const DecorationImage(
                            //       opacity: 0.4,
                            //       image: AssetImage(
                            //           'assets/images/dummy/lands.jpg'),
                            //       fit: BoxFit.cover,
                            //     ),
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(top: 12),
                            //     child: RichText(
                            //         textAlign: TextAlign.center,
                            //         text: TextSpan(
                            //           text: 'Land',
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .titleLarge!
                            //               .copyWith(
                            //                   fontSize: 10, color: kWhiteColor),
                            //           children: [
                            //             TextSpan(
                            //               text: '\nSketch',
                            //               style: Theme.of(context)
                            //                   .textTheme
                            //                   .headlineSmall!
                            //                   .copyWith(fontSize: 10),
                            //             ),
                            //           ],
                            //         )),
                            //   ),
                            // )
                          
                          ],
                        ),
                      ),
                      kHeight10,
                      kHeight10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconWithButtonBottom(
                            color: kWhiteColor,
                            onpressed: () {
                              launch("tel://9876543210");
                            },
                            text: "Give a Call",
                            iconData: Icons.phone,
                            radius: 100,
                            size: const Size(155, 51),
                          ),
                          IconWithButtonBottom(
                            background: const Color(0xff1BD741),
                            onpressed: () {
                              showModalBottomSheet(
                                  elevation: 10,
                                  context: context,
                                  backgroundColor: kBlackColor.withOpacity(.5),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: Image.asset(
                                            'assets/images/icons/messag.png',
                                            height: 40,
                                          ),
                                          title: const Text(
                                            'Phone Messenger',
                                            style:
                                                TextStyle(color: kWhiteColor),
                                          ),
                                          onTap: () {
                                            const phoneNumber = '9876543210';
                                            const message =
                                                'Your message goes here';

                                            const url =
                                                'sms:$phoneNumber?body=$message';

                                            launch(url);
                                          },
                                        ),
                                        ListTile(
                                          leading: Image.asset(
                                              'assets/images/icons/whatsapp.png'),
                                          title: const Text(
                                            'WhatsApp Messenger',
                                            style:
                                                TextStyle(color: kWhiteColor),
                                          ),
                                          onTap: () {
                                            const phoneNumber = '9876543210';
                                            const message =
                                                'Your message goes here';

                                            const url =
                                                'whatsapp://send?phone=$phoneNumber&text=$message';
                                            launch(url);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            text: "Message Me",
                            imageAsset: 'assets/images/icons/whatsapp.png',
                            radius: 100,
                            size: const Size(155, 51),
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
      ),
    );
  }

  ListView _existingListView(ScrollController scrollController) {
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
                          child: Text(
                            "Modern Restaurant aluva",
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
                          "ads_address",
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
                    const DetailsRow(
                      details: {},
                    ),
                    kHeight10,
                    DashedLineGenerator(
                        width: screenWidth, color: kDottedBorder),
                    kHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
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
                                    text: "/",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontSize: 22),
                                  ),
                                  TextSpan(
                                    text: "prebid",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 25,
                              width: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kBlackColor),
                              child: Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: "₹ 98000 - ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text: "15 Jan - 20 Dec ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        kWidth10,
                        IconWithButton(
                          onpressed: () {},
                          iconData: Icons.rocket_launch_outlined,
                          text: "Chat Now",
                          radius: 10,
                          size: const Size(160, 50),
                        )
                      ],
                    ),
                    kHeight20,
                    DashedLineGenerator(
                        width: screenWidth, color: kPrimaryColor),
                    kHeight10,
                    const DetailsRow(
                      details: {},
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
                    ConstrainedBox(
  
                      constraints: const BoxConstraints(
                        maxHeight: 500
                      ),
                      child: Text(
                      'Kalyan Gateway is our new upcoming luxury apartment project in Trivandrum. Located at NH Bypass, in close proximity to the IT Technopark and the upcoming Lulu Mall, these 2 and 3 BHK luxury flats are ideal for the increasing young and vibrant crowd in the city.',
                        maxLines: 6,
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
                            text: "Near PRS Hospital",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontSize: 13,
                                    color: const Color(0XFF878181)),
                            children: [
                              TextSpan(
                                // ignore: prefer_interpolation_to_compose_strings
                                text: "\nwww.calletic.com",
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
                    kHeight10,
                    Container(
                      height: 40,
                      color: kPrimaryColor.withOpacity(0.3),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 70,
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Amenities',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontSize: 12, color: kBlackColor),
                                    children: [
                                      TextSpan(
                                        text: '\nincluded',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(fontSize: 12),
                                      ),
                                    ],
                                  )),
                            ),
                            const VerticalDivider(
                              endIndent: 4,
                              indent: 4,
                              thickness: 2,
                              color: Color(0XFFB9B9B9),
                            ),
                            kWidth10,
                            Expanded(
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  return const Center(
                                    child: Text(
                                      'Gym',
                                      style: TextStyle(color: kWhiteColor),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return vericalDivider;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    kHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconWithButton(
                          onpressed: () {
                            // launch("tel://9876543210");
                            launchUrl(Uri.parse("tel://9876543210"));
                          },
                          text: "Give a Call",
                          iconData: Icons.phone,
                          radius: 100,
                          size: const Size(100, 51),
                        ),
                        IconWithButton(
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
                                        const phoneNumber = '9876543210';
                                        const message =
                                            'Your message goes here';
  
                                        const url =
                                            'sms:$phoneNumber?body=$message';
  
                                        // launch(url);
                                        launchUrl(Uri.parse(url));
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
                                        const phoneNumber = '9876543210';
                                        const message =
                                            'Your message goes here';
  
                                        const url =
                                            'whatsapp://send?phone=$phoneNumber&text=$message';
                                        // launch(url);
                                        launchUrl(Uri.parse(url));
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
  }
}


class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 2.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}