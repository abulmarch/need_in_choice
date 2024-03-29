import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

import '../../utils/colors.dart';

class DottedBorderTextField extends StatelessWidget {
  const DottedBorderTextField({
    super.key,
    this.color = kSecondaryColor,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.hideValidationError,
  });
  final Color color;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? hideValidationError;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [3, 2],
      color: hideValidationError == null || hideValidationError == true
          ? color
          : Colors.red, //color,
      borderType: BorderType.RRect,
      strokeWidth: 1.5,
      radius: const Radius.circular(10),
      padding: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: TextFormField(
          controller: controller,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            fillColor: kWhiteColor,
            hintText: hintText,
            hintStyle: TextStyle(
              color: hideValidationError == null || hideValidationError == true
                  ? color
                  : Colors.red.shade300, //color,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}

class AddMoreInfoButton extends StatelessWidget {
  const AddMoreInfoButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.icon,
  });
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon ?? const Icon(Icons.add_circle),
        label: const Text(
          'Click to add more info',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                backgroundColor ?? kDarkGreyButtonColor)),
      ),
    );
  }
}

class DarkTextChip extends StatelessWidget {
  const DarkTextChip({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 7),
      // alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        color: kDarkGreyButtonColor,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      constraints: const BoxConstraints(
        minWidth: 50,
        maxWidth: 100,
      ),
      child: Text(
        text,
        style: const TextStyle(color: kWhiteColor, fontSize: 11),
      ),
    );
  }
}
