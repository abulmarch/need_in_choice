import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/ad_detail/widgets/bottom_detail_sheet.dart';
import 'package:need_in_choice/views/pages/ad_detail/widgets/image_card.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/dummy_data.dart';
import 'widgets/text_icon_button.dart';

class AdPreviewScreen extends StatelessWidget {
  const AdPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(kpadding10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  kHeight10,
                  ImageCard(
                    imageSize: screenWidth,
                    phouseFoRentr: houseFoRentAd,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: screenHeight * .14,
              child: SizedBox(
                width: screenWidth,
                height: screenHeight * .8,
                child: BottomDetailsSheet(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              child: ColoredBox(
                color: kWhiteColor,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kWidth5,
                      TextIconButton(
                        onpressed: () {
                          Navigator.pushNamed(context, collectAdDetails);
                        },
                        text: 'Edit',
                        fontsize: 22,
                        txtcolor: kFadedBlack,
                        size: const Size(126, 77),
                        bordercolor: const Color(0XFFB7B7B7),
                      ),
                      kWidth15,
                      TextIconButton(
                        onpressed: () {
                          Navigator.pushNamed(context, confirmLottieScreen);
                        },
                        text: 'Confirm Ad',
                        fontsize: 22,
                        txtcolor: kWhiteColor,
                        background: kPrimaryColor,
                        size: const Size(243, 77),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
