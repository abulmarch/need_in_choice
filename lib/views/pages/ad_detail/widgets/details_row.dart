import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import 'land_widget.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: kWhiteColor.withOpacity(.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bolt,
                color: kWhiteColor,
              ),
            ),
            kWidth5,
            RichText(text: TextSpan(
              text: "Shobha", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 12),
              children: [
                TextSpan(
                  text: "\nHotel", style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 12),
                )
              ]
            ),
            ),
          ],
        ),
        vericalDivider,
        const LandWidget(image: "cent", value: 20, name: "Cent",),
        vericalDivider,
        const LandWidget(image: "sqrft", value: 1200, name: "Square Foot",),
        vericalDivider,
        RichText(text: TextSpan(
              text: "New", style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
              children: [
                TextSpan(
                  text: "\nHotel", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 8),
                )
              ]
            ),
            ),
      ],
    );
  }
}


