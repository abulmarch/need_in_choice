import 'package:flutter/material.dart';

class LandWidget extends StatelessWidget {
  final MapEntry<String, dynamic> mapEntry;

  const LandWidget({
    Key? key,
    required this.mapEntry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mapEntry.value is String) {
      return Row(children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '${mapEntry.value}\n ',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 17),
            children: [
              TextSpan(
                text: mapEntry.key,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
      ]);
    } else if (mapEntry.value is Map) {
      if (mapEntry.value.containsKey('unit')) {
        print('==========================unit');
        return Row(children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '${mapEntry.value['value']} ',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 17),
              children: [
                TextSpan(
                  text: '${mapEntry.value['unit']}\n',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 11),
                ),
                TextSpan(
                  text: mapEntry.key,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ]);
      } else if (mapEntry.value.containsKey('groupValue')) {
        print('==========================groupvalue');
        return Row(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '${mapEntry.value['value']}\n ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 17),
                children: [
                  TextSpan(
                    text: mapEntry.value['groupValue'],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    }
    return const SizedBox();
  }
}
