import 'package:flutter/material.dart';
import '../../config/theme/screen_size.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class IconWithButton extends StatelessWidget {
  final Function()? onpressed;
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
    this.fontsize = 20,
    this.background = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
        backgroundColor: MaterialStateProperty.all(background),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
        elevation: MaterialStateProperty.all<double>(0),
        minimumSize: MaterialStateProperty.all<Size>(size),
        iconColor: MaterialStateProperty.all(kWhiteColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: fontWeight, fontSize: fontsize),
          ),
          kWidth5,
          Icon(
            iconData,
            size: 16,
          )
        ],
      ),
    );
  }
}

class IconWithButtonBottom extends StatelessWidget {
  final Function() onpressed;
  final String text;
  final IconData? iconData;
  final double radius;
  final Size size;
  final FontWeight? fontWeight;
  final double? fontsize;
  final Color? background;
  final Color? color;
  final String? imageAsset;

  const IconWithButtonBottom({
    super.key,
    required this.onpressed,
    required this.text,
    this.iconData,
    required this.radius,
    required this.size,
    this.fontWeight = FontWeight.w600,
    this.fontsize = 14,
    this.background = kPrimaryColor,
    this.color,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.size.height;
    final double screenWidth = ScreenSize.size.width;

    return InkWell(
        onTap: onpressed,
        child: Container(
          height: screenHeight * 0.065,
          width: screenWidth * .42,
          decoration: BoxDecoration(
            color: background,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          padding: const EdgeInsets.only(
            left: 8,
            right: 18,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: iconData != null
                    ? Icon(
                        iconData,
                        color: kPrimaryColor,
                      )
                    : imageAsset != null
                        ? Image.asset(
                            imageAsset!,
                          )
                        : null,
              ),
              const Spacer(),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: fontWeight, fontSize: fontsize),
              ),
              const Spacer()
            ],
          ),
        ));
  }
}
