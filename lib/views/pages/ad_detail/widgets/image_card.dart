import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../config/theme/screen_size.dart';
import '../../../../services/repositories/repository_urls.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import 'full_image.dart';

class ImageCard extends StatelessWidget {
  ImageCard({
    Key? key,
    required this.phouseFoRentr,
    required this.imageUrls,
    this.timeAgo,
  }) : super(key: key);

  final List<String> phouseFoRentr;
  final PageController controller = PageController();
  final List<String> imageUrls;
  final String? timeAgo;

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSize.size;

    return Stack(children: [
      CustomScrollView(
        controller: controller,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullImageView(
                            imageUrls: imageUrls,
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: kLightBlueWhiteBorder, width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(kpadding10)),
                        child: SizedBox(
                          height: screenSize.width,
                          width: screenSize.width,
                          child: InteractiveViewer(
                            child: Image.network(
                              '$imageUrlEndpoint${imageUrls[index]}',
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return SizedBox(
                                  width: double.infinity,
                                  height: screenSize.width,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: imageUrls.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: screenSize.height * .1,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      Positioned(
        top: kpadding15,
        left: kpadding20,
        child: Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(kpadding20))),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: timeAgo == 'Just now' ? 'Just' : timeAgo ?? "",
                    style: const TextStyle(
                      fontSize: 10,
                      color: kPrimaryColor,
                    ),
                  ),
                  TextSpan(
                    text: timeAgo == 'Just now' ? ' now' : " ago",
                    style: const TextStyle(fontSize: 10, color: kGreyColor),
                  ),
                ],
              ),
            )),
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
                count: imageUrls.length,
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
    ]);
  }
}
