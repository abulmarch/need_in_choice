import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';

class TextIconButton extends StatelessWidget {
  final String text;
  final Color txtcolor;
  final double fontsize;
  final IconData? iconData;
  final Function()? onpressed;
  final Color? background;
  final Color? iconcolor;
  final Color? bordercolor;
  final double? radius;
  final Size size;
  const TextIconButton({
    super.key,
    required this.text,
    required this.txtcolor,
    required this.fontsize,
    this.iconData,
    required this.onpressed,
    this.background = kWhiteColor,
    this.iconcolor,
    this.radius = 100,
    required this.size,
    this.bordercolor = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed ?? (){},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(background),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
        ),
        side: MaterialStateProperty.all(BorderSide(color: bordercolor!)),
        elevation: MaterialStateProperty.all<double>(0),
        minimumSize: MaterialStateProperty.all<Size>(size),
        iconColor: MaterialStateProperty.all(iconcolor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          onpressed !=null ? Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: txtcolor, fontSize: fontsize),
          )
          : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}