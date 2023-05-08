import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class DashedLineGenerator extends StatelessWidget {
  const DashedLineGenerator({
    super.key,
    required this.width,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 2,
      child: Text(
        dashedLineGenerator(), //kPadding15*2   // '-------------------------------------------------',
        style: const TextStyle(
          height: 0.6,
          color: kDottedBorder,
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
