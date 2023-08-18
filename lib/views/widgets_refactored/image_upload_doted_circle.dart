import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:need_in_choice/services/repositories/repository_urls.dart';

import '../../utils/colors.dart';
import '../pages/ad_detail/widgets/full_image.dart';

class ImageUploadDotedCircle extends StatelessWidget {
  const ImageUploadDotedCircle({
    super.key,
    required this.color,
    required this.documentTypeName,
    this.imageFile,
    this.networkImageUrl,
    this.onTap,
  });
  final Color color;
  final String documentTypeName;
  final XFile? imageFile;
  final String? networkImageUrl;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: color,
        radius: const Radius.circular(50),
        child: SizedBox(
          width: 70,
          height: 70,
          child: Container(
            decoration: BoxDecoration(
                image: imageFile != null
                    ? DecorationImage(
                        image: FileImage(File(imageFile!.path)),
                        fit: BoxFit.cover,
                      )
                    : networkImageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(
                              '$imageUrlEndpoint$networkImageUrl',
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                color: color.withOpacity(0.31),
                shape: BoxShape.circle),
            child: Column(
              children: [
                const Icon(
                  Icons.keyboard_arrow_up,
                  color: kWhiteColor,
                ),
                Text(
                  documentTypeName,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageUploadDotedSquare extends StatelessWidget {
  const ImageUploadDotedSquare({
    super.key,
    required this.color,
    required this.text,
  });
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: color,
      radius: const Radius.circular(10),
      child: SizedBox(
        width: 100,
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: color.withOpacity(0.31), shape: BoxShape.rectangle),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: kWhiteColor,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
              const Icon(
                Icons.keyboard_arrow_up,
                color: kWhiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtherAdsImagePreviewBox extends StatelessWidget {
  const OtherAdsImagePreviewBox({
    super.key,
    required this.documentTypeName,
    this.imageFile,
    this.networkImageUrl,
    this.defaultImage = 'assets/images/dummy/lands.jpg',
  });
  final XFile? imageFile;
  final String? networkImageUrl;
  final String documentTypeName;
  final String defaultImage;
  @override
  Widget build(BuildContext context) {
    final dividedNameList = documentTypeName.split(' ');
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullImageScreen(
                      imageUrl: networkImageUrl ?? defaultImage,
                    )));
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          image: imageFile != null
              ? DecorationImage(
                  opacity: 0.3,
                  image: FileImage(File(imageFile!.path)),
                  fit: BoxFit.cover,
                )
              : networkImageUrl != null
                  ? DecorationImage(
                      opacity: 0.3,
                      image: NetworkImage(
                        '$imageUrlEndpoint$networkImageUrl',
                      ),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      opacity: 0.3,
                      image: AssetImage(defaultImage),
                      fit: BoxFit.cover,
                    ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 13),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: dividedNameList.first,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 10, color: kWhiteColor),
                children: [
                  TextSpan(
                    text: dividedNameList.length > 1
                        ? "\n${dividedNameList.last}"
                        : '',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 10,
                        ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
