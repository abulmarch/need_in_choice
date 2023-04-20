import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
    required this.screenWidth,
    required this.ontap,
    required this.boldText,
    required this.lightText,
    required this.button,
    required this.circle,
    required this.arrow,
  });

  final double screenWidth;
  final Function() ontap;
  final String boldText;
  final String lightText;
  final Color button;
  final Color circle;
  final Color arrow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 70,
        width: screenWidth * .82,
        decoration: BoxDecoration(
          color: button,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                  text: boldText,
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                        text: lightText,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w300))
                  ]),
            ),
            kWidth10,
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: circle,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: arrow,
                ),
              ),
            ),
            kWidth10,
          ],
        ),
      ),
    );
  }
}
