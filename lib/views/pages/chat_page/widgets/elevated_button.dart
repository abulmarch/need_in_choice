import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

ElevatedButton buildElevatedButton({
  bool value = false,
  required VoidCallback onPressed,
  required String label,
  required Color primaryColor,
  required Color buttonColor,
  required Color textColor,
  required double width,
  required double height,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: value ? primaryColor : buttonColor,
      foregroundColor: value ? textColor : kGreyColor,
      side: BorderSide(color: value ? primaryColor : buttonColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      minimumSize: Size(width / 2.5, height * .06),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
    ),
  );
}
