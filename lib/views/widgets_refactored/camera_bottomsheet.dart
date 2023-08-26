import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';

import '../../config/theme/screen_size.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

import 'package:image_picker/image_picker.dart';

class CameraBottomSheet extends StatelessWidget {
  const CameraBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.size.height;
    final double screenWidth = ScreenSize.size.width;

    return Container(
      height: screenHeight * .25,
      decoration: BoxDecoration(
          color: kWhiteColor, borderRadius: BorderRadius.circular(100)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: kpadding20 * 3, right: kpadding20 * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: 'Choose how you',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: kBlackColor),
                children: [
                  TextSpan(
                    text: '\nUpload',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            ),
            const Text(
              '----------------------------------',
              style: TextStyle(height: 0.7, color: kDottedBorder),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth * 0.33,
                  child: Row(children: [
                    const Icon(Icons.camera_alt_outlined),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<AdCreateOrUpdateBloc>(context).add(
                            const PickImageFromCameraOrGallery(
                                source: ImageSource.camera));
                      },
                      child: Text(
                        'Camera',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: kBlackColor),
                      ),
                    ),
                  ]),
                ),
                Container(
                  width: 1,
                  height: screenHeight * 0.05,
                  color: kDottedBorder,
                ),
                SizedBox(
                  width: screenWidth * .33,
                  child: Row(children: [
                    const Icon(Icons.photo_library),
                    TextButton(
                      onPressed: () {
                        context.read<AdCreateOrUpdateBloc>().add(
                            const PickImageFromCameraOrGallery(
                                source: ImageSource.gallery));
                      },
                      child: Text(
                        'Gallery',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: kBlackColor),
                      ),
                    ),
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
