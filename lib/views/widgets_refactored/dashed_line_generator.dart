import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class DashedLineGenerator extends StatelessWidget {
  const DashedLineGenerator({
    super.key, required this.width,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    print(width);
    return SizedBox(
      width: width,
      height: 2,
      child: Text(
        dashedLineGenerator(),//kPadding15*2   // '-------------------------------------------------',
        style: const TextStyle(
          height: 0.6,
          color: kDottedBorder,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
  String dashedLineGenerator(){
    int noOfTimes = int.parse('${width~/6}');
    return '-'*noOfTimes;
  }
}