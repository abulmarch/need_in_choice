import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/ad_detail/widgets/bottom_detail_sheet.dart';
import 'package:need_in_choice/views/pages/ad_detail/widgets/image_card.dart';
import 'package:need_in_choice/views/pages/ad_detail/widgets/top_account_bar.dart';

import '../../../utils/dummy_data.dart';

class AdDetailScreen extends StatelessWidget {
  const AdDetailScreen({super.key});

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
                  TopAccountBar(screenHeight: screenHeight, screenWidth: screenWidth),
                  kHeight5,
                  ImageCard(
                    imageSize: screenWidth,
                    phouseFoRentr: houseFoRentAd,
                  ),
                ],
              ),
            ),
            BottomDetailsSheet(screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}



