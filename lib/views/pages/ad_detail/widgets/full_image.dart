import 'package:flutter/material.dart';
import '../../../../services/repositories/repository_urls.dart';
import '../../../../utils/colors.dart';

class FullImageView extends StatelessWidget {
  const FullImageView({super.key, required this.imageUrls, this.initialIndex});
   final List<String> imageUrls;
  final int? initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: kBlackColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
      backgroundColor: kBlackColor, 
      body: PageView.builder(
        controller: PageController(initialPage: initialIndex!),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Center(
            child: InteractiveViewer(
              child: Image.network(
                '$imageUrlEndpoint${imageUrls[index]}',
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}



class FullImageScreen extends StatelessWidget {
  const FullImageScreen({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBlackColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        backgroundColor: kBlackColor,
        body: Center(
            child: InteractiveViewer(
          child: _buildImageWidget(),
        )),
      ),
    );
  }

  Widget _buildImageWidget() {
    return Image.network(
      '$imageUrlEndpoint$imageUrl',
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const CircularProgressIndicator();
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
        imageUrl,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
      },
    );
  }
}
