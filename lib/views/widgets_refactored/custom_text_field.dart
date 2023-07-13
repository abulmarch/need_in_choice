import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

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
    this.fillColor, this.width, 
    this.validator, 
    this.inputFormatters, 
    this.keyboardType,
  });
  final String? hintText;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final int maxLines;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final Color? fillColor;
  final double? width;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          // contentPadding: kContentPadding,
          fillColor: fillColor,
          hintText: hintText,
          suffixIconConstraints: suffixIconConstraints ?? const BoxConstraints.tightForFinite(),
          suffixIcon : suffixIcon,
        ),
        keyboardType: keyboardType,
        validator: validator,
        onTapOutside: onTapOutside,
        onChanged: onChanged,
      ),
    );
  }
}