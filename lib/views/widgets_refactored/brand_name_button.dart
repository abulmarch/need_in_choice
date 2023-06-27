import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class BrandNameButton extends StatelessWidget {
  const BrandNameButton({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: Container(
        alignment: Alignment.center,
        height: 35,
        width: 100,
        decoration: BoxDecoration(
            color: kDarkGreyButtonColor,
            borderRadius: BorderRadius.circular(30)),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            color: kWhiteColor,
          ),
        )),
      ),
    );
  }
}

class WorkTimeContainer extends StatelessWidget {
  const WorkTimeContainer({
    super.key,
    required this.color,
    required this.textcolor,
    required this.text,
  });
  final Color color;
  final Color textcolor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 40,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: textcolor)),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(color: kPrimaryColor),
      )),
    );
  }
}

class AddMoreInfoButton extends StatelessWidget {
  const AddMoreInfoButton({
    super.key,
    this.onPressed,
    required this.backgroundColor,
    required this.icon,
  });
  final void Function()? onPressed;
  final Color backgroundColor;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: const Text(
          'Click to add more info',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor)),
      ),
    );
  }
}

class SuffixIconDottedRs extends StatelessWidget {
  const SuffixIconDottedRs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 70,
        height: 25,
        decoration: BoxDecoration(
          color: kDarkGreyButtonColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
            child: Text(
          'Rs',
          style: TextStyle(color: kWhiteColor),
        )),
      ),
    );
  }
}
