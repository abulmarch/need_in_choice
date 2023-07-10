import 'package:flutter/material.dart';


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
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '$value\n',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 17),
            children: [
              TextSpan(
                text: name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 11),
              ),
            ],
          ))
    ]);
  }
}
