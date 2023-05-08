import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class CameraBottomSheet extends StatelessWidget {
  const CameraBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                        .copyWith(
                            color: kPrimaryColor),
                  )
                ],
              ),
            ),
            const Text(
              '-------------------------',
              style: TextStyle(
                  height: 0.7, color: kDottedBorder),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.camera_alt_outlined),
                Text('Camera', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: kBlackColor),),
                vericalDivider,
                const Icon(Icons.photo_library),
                Text('Gallery', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: kBlackColor),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
