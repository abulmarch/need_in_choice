import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class FullImageView extends StatelessWidget {
  const FullImageView({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(kpadding15),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const SizedBox(
                    height: 40,
                    width: 40,
                    child: Icon(Icons.arrow_back_ios_new,
                        color: kLightBlueWhite, size: kpadding20)),
              ),
            ),
            const Spacer(),
            Center(
                child: InteractiveViewer(
              child: _buildImageWidget(),
            )),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      return Image.network(
        imageUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const CircularProgressIndicator();
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error);
        },
      );
    } else {
      return Image.asset(imageUrl);
    }
  }
}
