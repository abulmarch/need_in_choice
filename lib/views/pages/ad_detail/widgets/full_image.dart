import 'package:flutter/material.dart';
import '../../../../services/repositories/repository_urls.dart';
import '../../../../utils/colors.dart';

class FullImageView extends StatelessWidget {
  const FullImageView({super.key, required this.imageUrl});
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
