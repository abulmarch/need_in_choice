import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';

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
    this.textcolor = kWhiteColor,
  });

  final double screenWidth;
  final Function() ontap;
  final String boldText;
  final String lightText;
  final Color button;
  final Color circle;
  final Color arrow;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: ontap,
      child: Center(
        child: Container(
          height: screenHeight * 0.085,
          width: screenWidth * .8,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: button,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              RichText(
                text: TextSpan(
                    text: boldText,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: textcolor, fontSize: 18),
                    children: [
                      TextSpan(
                        text: lightText,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w300,
                            color: textcolor,
                            fontSize: 18),
                      )
                    ]),
              ),
              const Spacer(),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: circle,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: arrow,
                    size: 20,
                  ),
                ),
              ),
              // kWidth10,
            ],
          ),
        ),
      ),
    );
  }
}
