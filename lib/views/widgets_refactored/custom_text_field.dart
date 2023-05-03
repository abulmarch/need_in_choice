import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, 
    this.hintText, 
    this.suffixIconConstraints, 
    this.suffixIcon,
    this.maxLines = 1, 
    this.controller, 
    this.onTapOutside, 
    this.onChanged, 
    this.fillColor,
  });
  final String? hintText;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final int maxLines;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        // contentPadding: kContentPadding,
        fillColor: fillColor,
        hintText: hintText,
        suffixIconConstraints: suffixIconConstraints ?? const BoxConstraints.tightForFinite(),
        suffixIcon : suffixIcon,
      ),
      
      onTapOutside: onTapOutside,
      onChanged: onChanged,
    );
  }
}