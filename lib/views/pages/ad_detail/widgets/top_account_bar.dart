import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class TopAccountBar extends StatelessWidget {
  const TopAccountBar({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * .1,
      width: screenWidth * .9,
      decoration: BoxDecoration(
        color: kLightBlueWhite,
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: kLightBlueWhiteBorder, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              color: kLightBlueWhiteBorder,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kBlackColor,
            ),
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
            child: const Center(
              child: CircleAvatar(
                backgroundColor: kWhiteColor,
                radius: 16,
                backgroundImage: AssetImage(
                    'assets/images/profile/profile_head.png'),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
                text: "Anjitha",
                style: Theme.of(context).textTheme.labelLarge,
                children: [
                  TextSpan(
                      text: "\nPosted on",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(
                              color: const Color(0XFF8B8B8B))),
                  TextSpan(
                      text: " 6 Jan 2020",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: kPrimaryColor)),
                ]),
          ),
          Container(
            height: screenHeight * .055,
            width: screenWidth * .25,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(100)),
          ),
        ],
      ),
    );
  }
}