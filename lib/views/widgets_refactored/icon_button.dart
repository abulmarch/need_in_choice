import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class IconWithButton extends StatelessWidget {
  final Function() onpressed;
  final String text;
  final IconData iconData;
  final double radius;
  final Size size;
  final FontWeight? fontWeight;
  final double? fontsize;
  final Color? background;
  const IconWithButton({
    super.key,
    required this.onpressed,
    required this.text,
    required this.iconData,
    required this.radius,
    required this.size,
    this.fontWeight = FontWeight.w600,
    this.fontsize = 20, this.background = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(background),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
        elevation: MaterialStateProperty.all<double>(0),
        minimumSize: MaterialStateProperty.all<Size>(size),
        iconColor: MaterialStateProperty.all(kWhiteColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: fontWeight, fontSize: fontsize),
          ),
          kWidth5,
          Icon(iconData)
        ],
      ),
    );
  }
}
