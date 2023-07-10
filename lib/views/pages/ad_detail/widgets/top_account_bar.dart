import 'package:flutter/material.dart';

import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';
import '../../../../services/model/ads_models.dart';
import '../../../../utils/colors.dart';
import '../../../widgets_refactored/circular_back_button.dart';
import '../../../widgets_refactored/icon_button.dart';
import 'package:intl/intl.dart';

class TopAccountBar extends StatelessWidget {
  const TopAccountBar({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.adsModel,
  });

  final double screenHeight;
  final double screenWidth;
  final AdsModel adsModel;

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  String getProfileImage() {
    if (adsModel.profileImage != null && adsModel.profileImage!.isNotEmpty) {
      return "https://nic.calletic.com/storage/app/${adsModel.profileImage!}";
    } else {
      return 'assets/images/profile/profile_head.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * .09,
      width: screenWidth * .9,
      decoration: BoxDecoration(
        color: kLightBlueWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kLightBlueWhiteBorder, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            size: const Size(40, 40),
          ),
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kWhiteColor,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: kBlackColor.withOpacity(.5),
                    spreadRadius: 1)
              ],
            ),
            child: CircleAvatar(
              backgroundColor: kWhiteColor,
              radius: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  "https://nic.calletic.com/storage/app/${adsModel.profileImage}",
                  fit: BoxFit.fill,
                  width: 35,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Image.asset(
                        'assets/images/profile/no_profile_img.png');
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Image.asset(
                        'assets/images/profile/no_profile_img.png');
                  },
                ),
              ),
            ),
          ),
          //kWidth5,
          const DashedLineHeight(height: 50),
          // kWidth5,
          RichText(
            text: TextSpan(
                text: adsModel.adsTitle,
                //"Anjitha",
                style: Theme.of(context).textTheme.labelLarge,
                children: [
                  TextSpan(
                      text: "\nPosted on ",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: const Color(0XFF8B8B8B), fontSize: 9)),
                  TextSpan(
                      text: formatDate(adsModel.createdDate),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 10)
                          .copyWith(color: kPrimaryColor)),
                ]),
          ),
          IconWithButton(
            onpressed: () {},
            iconData: Icons.share,
            radius: 50,
            size: const Size(76, 35),
            text: "Share",
            fontWeight: FontWeight.w500,
            fontsize: 12,
          ),
        ],
      ),
    );
  }
}
