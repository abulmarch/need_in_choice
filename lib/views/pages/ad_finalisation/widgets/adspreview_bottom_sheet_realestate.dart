import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:extended_text/extended_text.dart'
    show ExtendedText, TextOverflowWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../services/model/ad_create_or_update_model.dart'
    show AdCreateOrUpdateModel;
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets_refactored/icon_button.dart';
import '../../../widgets_refactored/image_upload_doted_circle.dart'
    show OtherAdsImagePreviewBox;
import '../../ad_detail/widgets/details_row.dart';
import '../../ad_detail/widgets/full_image.dart';

class AdPreviewBottomSheetRealEstate extends StatelessWidget {
  const AdPreviewBottomSheetRealEstate({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.availableHeight,
  });

  final double screenWidth;
  final double screenHeight;
  final double availableHeight;

  @override
  Widget build(BuildContext context) {
    final adData =
        BlocProvider.of<AdCreateOrUpdateBloc>(context).adCreateOrUpdateModel;

    Widget adPriceWidget = const SizedBox();

    if (adData.adPrice is Map) {
      if (adData.adPrice.containsKey('Start Price') &&
          adData.adPrice.containsKey('Prebid')) {
        adPriceWidget = Column(
          children: [
            RichText(
              text: TextSpan(
                text: "₹ ",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 19),
                children: [
                  TextSpan(
                    text: adData.adPrice['Start Price'].toString(),
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
                        .titleLarge!
                        .copyWith(fontSize: 14, color: kPrimaryColor),
                  ),
                ],
              ),
            ),
            Container(
              height: 25,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kBlackColor,
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "₹ ${adData.adPrice['Prebid']} - ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 11),
                    children: [
                      TextSpan(
                        text: adData.primaryData['Date Range'],
                        //"15 Jan - 20 Dec ",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      } else if (adData.adPrice.containsKey('Monthly') &&
          adData.adPrice.containsKey('Security Deposit')) {
        adPriceWidget = Column(
          children: [
            RichText(
              text: TextSpan(
                text: "₹ ",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 19),
                children: [
                  TextSpan(
                    text: adData.adPrice['Monthly'].toString(),
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
                    text: "m",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 14, color: kPrimaryColor),
                  ),
                ],
              ),
            ),
            Container(
              height: 25,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kBlackColor,
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "₹ ${adData.adPrice['Security Deposit']} - ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 11),
                    children: [
                      TextSpan(
                        text: "deposit ",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
    } else if (adData.adPrice is String) {
      adPriceWidget = RichText(
        text: TextSpan(
          text: "₹",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 19),
          children: [
            TextSpan(
              text: adData.adPrice,
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
          ],
        ),
      );
    }

    return DraggableScrollableSheet(
      initialChildSize: .3,
      minChildSize: .3,
      maxChildSize: 0.85,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(height: availableHeight,),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                itemCount: 1,
                physics: const NeverScrollableScrollPhysics(),
                controller: scrollController,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: bottomSheetcolor.withOpacity(.96),
                      borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kpadding15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  kWidth5,
                                  Text(adData.adsTitle,
                                      // "Modern Restaurant aluva",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.titleLarge),
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
                                  SizedBox(
                                    width: screenWidth * 0.82,
                                    child: Text(
                                      adData.adsAddress,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                              DetailsRow(
                                details: _primaryData(adData.primaryData),
                                dotColor: kDottedBorder,
                              ),
                              kHeight5,
                              SizedBox(
                                width: screenWidth * .9,
                                child: const MySeparator(color: kDottedBorder),
                              ),
                              kHeight5,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  adPriceWidget,
                                  IconWithButton(
                                      onpressed: () {},
                                      iconData: Icons.rocket_launch_outlined,
                                      text: "Chat Now",
                                      radius: 10,
                                      size: adData.adPrice == null
                                          ? Size(screenWidth - 30, 50)
                                          : const Size(150, 50))
                                ],
                              ),
                              DetailsRow(
                                details: _moreInfoData(adData.moreInfoData),
                                dotColor: kSecondaryColor,
                              ),
                              kHeight5,
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
                                      adData.description,
                                      // 'Kalyan Gateway is our new upcoming luxury apartment pro Technopark and the Kalyan Gateway is our new upcoming Kalyan Gateway echnopark and the Kalyan Gateway is our new upcoming Kalyan Gateway is our new upcoming luxury apartment pro Technopark and the up luxury apartment pro Technopark',
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
                                                              color:
                                                                  kPrimaryColor),
                                                    ),
                                                    content: Text(
                                                      //  'Kalyan Gateway is our new upcoming luxury apartment project in Trivandrum. Located at NH Bypass, in close proximity to the IT Technopark and the upcoming Lulu Mall, these 2 and 3 BHK luxury flats are ideal for the increasing young and vibrant crowd in the city.',

                                                      adData.description,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                            fontSize: 13,
                                                            color: const Color(
                                                                0XFF878181),
                                                          ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text('Close'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text(
                                              '... Read More',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: kPrimaryColor),
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
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          text: adData.moreInfoData['Landmark'],
                                          //"Near PRS Hospital",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                  fontSize: 13,
                                                  color: const Color(0XFF878181)),
                                          children: [
                                            TextSpan(
                                              text: "\n${adData.moreInfoData['Website Link']}",
                                              //"\nwww.calletic.com",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        _otherAdsImagePreview(
                                            imageName: 'Floor Plan',
                                            adData: adData,
                                            defaultImage:
                                                'assets/images/dummy/Room.jpg'),
                                                kWidth15,
                                        _otherAdsImagePreview(
                                            imageName: 'Land Sketch',
                                            adData: adData,
                                            defaultImage: 'assets/images/dummy/lands.jpg'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              kHeight10,
                            ],
                          ),
                        ),
                        (adData.moreInfoData['Selected Amenities'] != null)
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: kpadding10),
                                height: 40,
                                color: kPrimaryColor.withOpacity(0.5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                    fontSize: 12,
                                                    color: kBlackColor),
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
                                        itemCount: (adData.moreInfoData[
                                                'Selected Amenities'] as List)
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Center(
                                            child: Text(
                                              adData.moreInfoData[
                                                  'Selected Amenities'][index],
                                              // 'Gym',
                                              style: const TextStyle(
                                                  color: kWhiteColor),
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
                              )
                            : const SizedBox(),
                        kHeight10,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: kpadding15,
                              right: kpadding15,
                              bottom: kpadding15),
                          child: Row(
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
                                      backgroundColor:
                                          kBlackColor.withOpacity(.5),
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
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _otherAdsImagePreview({
    required String imageName,
    required AdCreateOrUpdateModel adData,
    required String defaultImage,
  }) {
    final fileDat = adData.otherImageFiles.firstWhere(
      (fileData) => fileData['image_type'] == imageName,
      orElse: () => {},
    );
    if (fileDat.isNotEmpty) {
      return OtherAdsImagePreviewBox(
        documentTypeName: imageName,
        defaultImage: 'assets/images/dummy/Room.jpg',
        imageFile: fileDat['file'],
      );
    } else {
      final urlMap = adData.otherImageUrls.firstWhere(
        (imageData) => imageData['image_type'] == imageName,
        orElse: () => null,
      );
      if (urlMap != null) {
        return OtherAdsImagePreviewBox(
          documentTypeName: imageName,
          defaultImage: 'assets/images/dummy/Room.jpg',
          networkImageUrl: urlMap['url'],
        );
      }
    }
    return const SizedBox();
    // OtherAdsImagePreviewBox(
    //   documentTypeName: imageName,
    //   defaultImage: 'assets/images/dummy/Room.jpg',
    // );
  }

  Map<String, dynamic> _moreInfoData(Map<String, dynamic> moreInfoData) {
    Map<String, dynamic> moreInfo = {};
    moreInfoData.forEach((key, value) {
      if (value != null &&
          value != "" &&
          key != 'Website Link' &&
          key != 'Landmark' &&
          key != 'Selected Amenities') {
        if (value is! String && value['value'] == "") {
          return;
        }
        moreInfo[key] = value;
      }
    });
    return moreInfo;
  }

  Map<String, dynamic> _primaryData(Map<String, dynamic> primaryData) {
    Map<String, dynamic> primaryInfo = {};
    primaryData.forEach((key, value) {
      if (value != null && value != "" && key != 'Date Range') {
        if (value is! String && value['value'] == "") {
          return;
        }
        primaryInfo[key] = value;
      }
    });
    return primaryInfo;
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
