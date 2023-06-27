import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';

class LandWidget extends StatelessWidget {
  final String value;
  final String name;

  const LandWidget({
    super.key,
    required this.value,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      RichText(
          text: TextSpan(
        text: '$value  ',
        style:
            Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
        children: [
          TextSpan(
            text: name,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 12),
          ),
        ],
      ))
    ]);
  }
}
