import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../services/repositories/repository_urls.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class AdvertisementWidget extends StatelessWidget {
  AdvertisementWidget({
    super.key,
    required this.imageSize, 
    required this.adsImageUrlList, 
    required this.timeAgo,
  });

  final double imageSize;
  final List<String> adsImageUrlList;
  final String timeAgo;
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: imageSize,
          height: imageSize-15,
          child: adsImageUrlList.isNotEmpty
          ? PageView.builder(
            controller: controller,
            itemCount: adsImageUrlList.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(kpadding10)),
              child: Image.network(
                '$imageUrlEndpoint${adsImageUrlList[index]}',fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  kNoAdImage,fit: BoxFit.cover,
                ),
              ),
            ),
          )
          : ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(kpadding10)),
              child: Image.asset(
                kNoAdImage,fit: BoxFit.cover,
                // width: imageSize,
                // height: imageSize-15,
              ),
            ),
        ),
        Positioned(
          top: kpadding10,
          right: kpadding10,
          child: Container(
            width: 75,
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(kpadding20))
            ),
            child: Text(
              timeAgo,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 8,color: kPrimaryColor),
            ),
          ),
        ),
        adsImageUrlList.length > 1 
        ? Positioned(
          bottom: kpadding10,
          child: Container(
            width: 100,
            height: 25,
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
            alignment: Alignment.center,
            child: SmoothPageIndicator(
              controller: controller,
              count: adsImageUrlList.length,
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
        )
        : const SizedBox(),
      ],
    );
  }
}