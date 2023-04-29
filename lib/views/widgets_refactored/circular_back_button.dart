import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class CircularBackButton extends StatelessWidget {
  const CircularBackButton({
    super.key, 
    required this.onPressed, 
    this.size = const Size(30, 30),
  });
  final void Function() onPressed;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(kDisabledBackground),
        shape: MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
        elevation: MaterialStateProperty.all<double>(0),
        minimumSize: MaterialStateProperty.all<Size>(size),
      ),                  
      child: const Icon(Icons.arrow_back_ios_new,color: kDarkBlue,size: kpadding15), 
    );
  }
}