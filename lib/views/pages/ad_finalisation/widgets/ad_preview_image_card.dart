import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../config/theme/screen_size.dart';
import '../../../../services/repositories/repository_urls.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class AdPreviewImageCard extends StatelessWidget {
  AdPreviewImageCard({
    super.key,
    required this.houseFoRentr,
    required this.imageUrlsOrFiles,
  });

  final List<String> houseFoRentr;
  final PageController controller = PageController();
  final List imageUrlsOrFiles;

  @override
  Widget build(BuildContext context) {
    final imageList = imageUrlsOrFiles.isNotEmpty
        ? imageUrlsOrFiles
        : ['assets/images/dummy/house_for_rent1.png'];
    final screenSize = ScreenSize.size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.separated(
          scrollDirection: Axis.vertical,
          controller: controller,
          itemCount: imageList.length,
          cacheExtent: screenSize.width,
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(kpadding10)),
            child: SizedBox(
              height: screenSize.width,
              width: screenSize.width,
              child: imageList[index].runtimeType == String
                  ? Image.network(
                      '$imageUrlEndpoint${imageList[index]}',
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: screenSize.width,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) =>
                          DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(color: kGreyColor),
                            color: kLightGreyColor.withOpacity(0.6)),
                        child: const Icon(
                          Icons.image,
                          size: 80,
                          color: kGreyColor,
                        ),
                      ),
                    )
                  : Image.file(
                      File((imageList[index] as XFile).path),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image),
                    ),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        ),
        Positioned(
          top: 150,
          right: 1,
          child: Container(
              width: 50,
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              alignment: Alignment.center,
              child: SmoothPageIndicator(
                  axisDirection: Axis.vertical,
                  controller: controller,
                  count: imageList.length,
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
                  ))),
        ),
      ],
    );
  }
}
