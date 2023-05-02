import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class ImageCard extends StatelessWidget {
  ImageCard({
    super.key,
    required this.imageSize, 
    required this.phouseFoRentr,
  });

  final double imageSize;
  final List<String> phouseFoRentr;
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: imageSize,
          height: imageSize*1.5,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            controller: controller,
            itemCount: phouseFoRentr.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(kpadding10)),
              child: Image.asset(
                phouseFoRentr[index],
                fit: BoxFit.fitWidth,
                
              ),
            ),
          ),
        ),
        Positioned(
          top: kpadding10,
          left: kpadding10,
          child: Container(
            width: 75,
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(kpadding20))
            ),
            child: Text(
              '10 days ago',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10,color: kPrimaryColor),
            ),
          ),
        ),
        Positioned(
          top: 250,
          right: 1,
          child: Container(
            width: 100,
            height: 25,
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
            alignment: Alignment.center,
            child: SmoothPageIndicator(
              axisDirection: Axis.vertical,
              controller: controller,
              count: phouseFoRentr.length,
              effect: const ScrollingDotsEffect(
                activeDotColor: kWhiteColor,
                dotColor: kWhiteColor,
                activeStrokeWidth: 1,
                activeDotScale: 1.5,
                maxVisibleDots: 5,
                radius: 8,
                spacing: 5,
                dotHeight: 8,
                dotWidth: 8,
              )
            )
          ),
        ),
        
      ],
    );
  }
}