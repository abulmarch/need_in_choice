import 'package:flutter/material.dart';


class EditButton extends StatelessWidget {
  final Function() ontap;
  final double width;
  final double height;
  final String text;
  final Color boxcolor;
  final Color textcolor;
  const EditButton({
    super.key, required this.ontap, required this.width, required this.height, required this.text, required this.boxcolor, required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: boxcolor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: textcolor),
          ),
        ),
      ),
    );
  }
}
