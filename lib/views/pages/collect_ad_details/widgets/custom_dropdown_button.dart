import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key, 
    required this.itemList,
    required this.onChanged, 
    this.initialValue, 
    this.maxWidth = 70, 
    this.hint,
  });
  final List<String> itemList;
  final void Function(String?)? onChanged;
  final String? initialValue;
  final double maxWidth;
  final Widget? hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        minWidth: 20,
        minHeight: 10,
        maxHeight: 30
      ),
      child: DropdownButton<String>(

        value: initialValue,
        hint: hint,                                   
        alignment: Alignment.center,
        elevation: 16,
        iconEnabledColor: kWhiteColor,
        icon: null,
        style: const TextStyle(
          color: kPrimaryColor,
        ),
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(kpadding10),
        dropdownColor: kWhiteColor,
        menuMaxHeight: 250,isExpanded: true,
        onChanged: onChanged,
        selectedItemBuilder: (context) => itemList.map((item) => Center(
          child: Text(item,style: const TextStyle(color: kWhiteColor,overflow: TextOverflow.ellipsis),),
        )).toList(),
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