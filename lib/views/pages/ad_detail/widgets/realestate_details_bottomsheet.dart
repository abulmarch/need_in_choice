
import 'package:extended_text/extended_text.dart'
    show ExtendedText, TextOverflowWidget;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:need_in_choice/services/model/chat_connection_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../services/model/ads_models.dart';
import '../../../../services/repositories/firestore_chat.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import '../../../widgets_refactored/error_popup.dart';
import '../../../widgets_refactored/icon_button.dart';
import '../../../widgets_refactored/image_upload_doted_circle.dart';
import '../../chat_page/chating_view.dart';
import 'details_row.dart';

class RealEstateDetailsBottomSheet extends StatelessWidget {
  const RealEstateDetailsBottomSheet({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.adsModel,
    required this.availableHeight,
  });

  final double screenWidth;
  final double screenHeight;
  final AdsModel adsModel;
  final double availableHeight;

  @override
  Widget build(BuildContext context) {
    String phoneMessengerPhoneNumber = adsModel.phoneNo;
    String? whatsappPhoneNumber = adsModel.whatsappNo;
    String messageText =
        'Hello, I am ${adsModel.userName}.I saw your advertisement on the NIC app. Could you please provide me with more details? Thank you!"';

    Widget adPriceWidget = const SizedBox();

    if (adsModel.adPrice is Map) {
      if (adsModel.adPrice.containsKey('Start Price') &&
          adsModel.adPrice.containsKey('Prebid')) {
        adPriceWidget = Column(
          children: [
            RichText(
              text: TextSpan(
                text: "₹ ",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
                children: [
                  TextSpan(
                    text: adsModel.adPrice['Start Price'].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 22),
                  ),
                  TextSpan(
                    text: "/",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 14),
                  ),
                  TextSpan(
                    text: "prebid",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 10, color: kPrimaryColor),
                  ),
                ],
              ),
            ),
            Container(
              height: 25,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kBlackColor,
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "₹ ${adsModel.adPrice['Prebid']} - ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 11),
                    children: [
                      TextSpan(
                        text: adsModel.primaryData['Date Range'],
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
      } else if (adsModel.adPrice.containsKey('Monthly') &&
          adsModel.adPrice.containsKey('Security Deposit')) {
        adPriceWidget = Column(
          children: [
            RichText(
              text: TextSpan(
                text: "₹ ",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
                children: [
                  TextSpan(
                    text: adsModel.adPrice['Monthly'].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 22),
                  ),
                  TextSpan(
                    text: "/",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 14),
                  ),
                  TextSpan(
                    text: "m",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 10, color: kPrimaryColor),
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
                    text: "₹ ${adsModel.adPrice['Security Deposit']} - ",
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
    } else if (adsModel.adPrice is String) {
      adPriceWidget = RichText(
        text: TextSpan(
          text: "₹",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          children: [
            TextSpan(
              text: adsModel.adPrice,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 22),
            ),
            TextSpan(
              text: "/-",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 14),
            ),
          ],
        ),
      );
    }

    return DraggableScrollableSheet(
      initialChildSize: .3,
      minChildSize: .3,
      maxChildSize: 0.75,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: availableHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                itemCount: 1,
                controller: scrollController,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: bottomSheetcolor.withOpacity(.96),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    // height: screenHeight * .76,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kpadding15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kHeight10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  kWidth5,
                                  SizedBox(
                                    width: screenWidth * 0.8,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(adsModel.adsTitle,
                                          // "Modern Restaurant aluva",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ),
                                  ),
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
                                      adsModel.categoryInfo["ads_address"],
                                      //maxLines: 1,
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
                                details: adsModel.primaryData.exclude(
                                    ['Date Range', 'Website Link', 'Landmark']),
                                dotColor: kDottedBorder,
                              ),
                              kHeight5,
                              SizedBox(
                                width: screenWidth * .9,
                                child: const MySeparator(color: kDottedBorder),
                              ),
                              kHeight5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  adPriceWidget,
                                  IconWithButton(
                                      onpressed: FirebaseAuth
                                                  .instance.currentUser!.uid !=
                                              adsModel.userId
                                          ? () async {
                                              await FireStoreChat
                                                      .checkChatAllreadyGenerated(
                                                          creatorId:
                                                              adsModel.userId,
                                                          selectedAdId:
                                                              adsModel.id)
                                                  .then((chatConn) async {
                                                if (chatConn == null) {
                                                  FireStoreChat.generateNewChat(
                                                    adCreatorUid:
                                                        adsModel.userId,
                                                    selectedAdId: adsModel.id,
                                                    adImgUrl: adsModel
                                                            .images.isNotEmpty
                                                        ? adsModel.images.first
                                                        : '',
                                                    adTitle: adsModel.adsTitle,
                                                  ).then(
                                                      (chatConnectionModel) async {
                                                    if (chatConnectionModel !=
                                                        null) {
                                                      /*06/09/2023*/
                                                      FireStoreChat.findCurrentChatUser(
                                                              chatConnectionModel
                                                                  .chattingPartnerUid())
                                                          .then((chatUser) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChatingView(
                                                                      chatConn:
                                                                          chatConnectionModel,
                                                                      isFirstMessage:
                                                                          true,
                                                                      user:
                                                                          chatUser),
                                                            ));
                                                      });
                                                    } else {
                                                      showErrorDialog(context,
                                                          'Something went wrong');
                                                    }
                                                  });
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatingView(
                                                          chatConn: chatConn,
                                                        ),
                                                      ));
                                                }
                                              });
                                            }
                                          : null,
                                      iconData: Icons.rocket_launch_outlined,
                                      text: "Chat Now",
                                      radius: 10,
                                      size: adsModel.adPrice == null
                                          ? Size(screenWidth - 30, 50)
                                          : const Size(150, 50))
                                ],
                              ),
                              DetailsRow(
                                details: adsModel.moreInfoData.exclude([
                                  'Website Link',
                                  'Landmark',
                                  'Selected Amenities'
                                ]),
                                dotColor: kSecondaryColor,
                              ),
                              kHeight5,
                              SizedBox(
                                width: screenWidth * .9,
                                child:
                                    const MySeparator(color: kSecondaryColor),
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
                                      //  'Kalyan Gateway is our new upcoming luxury apartment pro Technopark and the Kalyan Gateway is our new upcoming Kalyan Gateway echnopark and the Kalyan Gateway is our new upcoming Kalyan Gateway is our new upcoming luxury apartment pro Technopark and the up luxury apartment pro Technopark',
                                      adsModel.description,
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
                                                      // 'Kalyan Gateway is our new upcoming luxury apartment project in Trivandrum. Located at NH Bypass, in close proximity to the IT Technopark and the upcoming Lulu Mall, these 2 and 3 BHK luxury flats are ideal for the increasing young and vibrant crowd in the city.',

                                                      adsModel.description,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _getLandmark(adsModel),
                                          //"Near PRS Hospital",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                  fontSize: 13,
                                                  color:
                                                      const Color(0XFF878181)),
                                        ),
                                        GestureDetector(
                                          onTap: () => _launchURL(
                                              "https://${_getWebsiteLink(adsModel)}"),
                                          child: Text(
                                            _getWebsiteLink(adsModel),
                                            //"www.calletic.com",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .copyWith(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        _otherAdsImagePreview(
                                            imageName: 'Floor Plan',
                                            defaultImage:
                                                'assets/images/dummy/Room.jpg'),
                                        kWidth15,
                                        _otherAdsImagePreview(
                                            imageName: 'Land Sketch',
                                            defaultImage:
                                                'assets/images/dummy/lands.jpg'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              kHeight10,
                            ],
                          ),
                        ),
                        (adsModel.moreInfoData['Selected Amenities'] != null)
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kpadding10),
                                height: 40,
                                color: kPrimaryColor.withOpacity(0.5),
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
                                        itemCount: adsModel
                                            .moreInfoData['Selected Amenities']
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Center(
                                            child: Text(
                                              adsModel.moreInfoData[
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
                                  launch("tel://${adsModel.phoneNo}");
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
                                                style: TextStyle(
                                                    color: kWhiteColor),
                                              ),
                                              onTap: () {
                                                launch(
                                                    'sms:$phoneMessengerPhoneNumber?body=$messageText');

                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: Image.asset(
                                                  'assets/images/icons/whatsapp.png'),
                                              title: const Text(
                                                'WhatsApp Messenger',
                                                style: TextStyle(
                                                    color: kWhiteColor),
                                              ),
                                              onTap: () {
                                                if (whatsappPhoneNumber !=
                                                    null) {
                                                  launch(
                                                      'https://wa.me/+91$whatsappPhoneNumber/?text=$messageText');
                                                } else {
                                                  launch(
                                                      'https://wa.me/+91$phoneMessengerPhoneNumber/?text=$messageText');
                                                }
                                                Navigator.pop(context);
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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _getLandmark(adsModel) {
    String? landmark = adsModel.moreInfoData['Landmark'];
    if (landmark == null || landmark.isEmpty) {
      landmark = adsModel.primaryData['Landmark'];
    }

    return landmark ?? '';
  }

  String _getWebsiteLink(adsModel) {
    String? websiteLink = adsModel.moreInfoData['Website Link'];
    if (websiteLink == null || websiteLink.isEmpty) {
      websiteLink = adsModel.primaryData['Website Link'];
    }

    return websiteLink ?? '';
  }

  Widget _otherAdsImagePreview(
      {required String imageName, required String defaultImage}) {
    String? imageUrl = adsModel.otherimages.firstWhere(
      (element) => element['image_type'] == imageName,
      orElse: () => {},
    )['url'];
    return imageUrl != null
        ? OtherAdsImagePreviewBox(
            documentTypeName: imageName,
            networkImageUrl: imageUrl,
            defaultImage: 'assets/images/dummy/Room.jpg',
          )
        : const SizedBox();
  }
}
