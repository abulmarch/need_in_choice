import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

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
      margin: const EdgeInsets.only(right: 7),
      padding: const EdgeInsets.symmetric(horizontal: 6),
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


class NewUsedContainer extends StatelessWidget {
  const NewUsedContainer({
    super.key,
    required this.height,
    required this.width,
    required this.text,
  });

  final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.07,
      width: width * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kSecondaryColor.withOpacity(0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: kPrimaryColor, fontWeight: FontWeight.w600),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 10,
            color: kWhiteColor,
          )
        ],
      ),
    );
  }
}
