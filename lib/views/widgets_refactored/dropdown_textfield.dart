import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';

class CustomDropdownText extends StatelessWidget {
  const CustomDropdownText({
    super.key,
    required this.itemList,
    this.onChanged,
    this.validator,
    this.hint,
    this.initialValue,
    this.width,
  });

  final List<String> itemList;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Widget? hint;
  final String? initialValue;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonFormField(
        value: initialValue,
        validator: validator,
        onChanged: onChanged,
        style: const TextStyle(
          color: kPrimaryColor,
        ),
        iconEnabledColor: kPrimaryColor,
        hint: hint,
        decoration: InputDecoration(
          fillColor: kadBox,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: kWhiteColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: kWhiteColor,
            ),
          ),
        ),
        items: itemList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            alignment: Alignment.centerLeft,
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
      ),
    );
  }
}
