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
  final MaterialStateProperty<Size?>? maxSize;
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
    this.maxSize,
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
        maximumSize: maxSize,
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


class TextIconButtonDisabled extends StatelessWidget {
  const TextIconButtonDisabled({
    super.key, 
    required this.width, 
    required this.height,
    required this.fontsize,
    required this.text,
    required this.backgroundColor,
  });
  const TextIconButtonDisabled.black({
    super.key, 
    required this.width, 
    required this.height, 
    required this.text,
    }) : backgroundColor = Colors.black, fontsize = 15;

  const TextIconButtonDisabled.blue({
    super.key, 
    required this.width, 
    required this.height, 
    required this.text,
    }) : backgroundColor = kPrimaryColor, fontsize = 22;

  final double width;
  final double height;
  final String text;
  final double fontsize;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        SnackBar snackBar = const SnackBar(
                  content: Text('You have to select ads image...!'),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color(0xFF00000e),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30)
        ),
        child: Text(
          text,
          style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: kWhiteColor.withOpacity(0.5), fontSize: fontsize),
        ),
      ),
    );
  }
}