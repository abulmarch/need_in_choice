
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ImageUploadDotedCircle extends StatelessWidget {
  const ImageUploadDotedCircle({
    super.key, 
    required this.color, 
    required this.text,
  });
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: color,
      radius: const Radius.circular(50),
      child: SizedBox(
        width: 70,
        height: 70,
        child: DecoratedBox(
            decoration: BoxDecoration(
            color: color.withOpacity(0.31),
            shape: BoxShape.circle
          ),
          child: Column(
            children: [
              const Icon(Icons.keyboard_arrow_up,color: kWhiteColor,),
              Text(
                text,style: TextStyle(
                  color: color,fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ImageUploadDotedSquare extends StatelessWidget {
  const ImageUploadDotedSquare({
    super.key,
    required this.color,
    required this.text,
  });
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: color,
      radius: const Radius.circular(10),
      child: SizedBox(
        width: 100,
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: color.withOpacity(0.31), shape: BoxShape.rectangle),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: kWhiteColor,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
              const Icon(
                Icons.keyboard_arrow_up,
                color: kWhiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
