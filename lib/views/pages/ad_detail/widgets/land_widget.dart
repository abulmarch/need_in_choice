import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class LandWidget extends StatelessWidget {
  final double value;
  final String image;
  final String name;

  const LandWidget({
    super.key, required this.value, required this.image, required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$value",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
        ),
        kWidth5,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/tools/$image.png"),
            Text(
              name,
              style:
                  Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 8),
            )
          ],
        )
      ],
    );
  }
}
