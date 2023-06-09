import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class DashedLineGenerator extends StatelessWidget {
  const DashedLineGenerator({
    super.key,
    required this.width,
    this.color = kDottedBorder,
  });
  final double width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 4,
      child: Text(
        dashedLineGenerator(), //kPadding15*2   // '-------------------------------------------------',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          height: 0.6,
          color: color,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  String dashedLineGenerator() {
    int noOfTimes = int.parse('${width ~/ 6}');
    return '-' * noOfTimes;
  }
}

class DashedLineHeight extends StatelessWidget {
  const DashedLineHeight({
    super.key,
    required this.height,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2,
      height: height,
      child: Text(
        dashedLineGenerator(),
        style: const TextStyle(
          height: 0.6,
          color: kDottedBorder,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  String dashedLineGenerator() {
    int noOfTimes = int.parse('${height ~/ 6}');
    return '-' * noOfTimes;
  }
}
