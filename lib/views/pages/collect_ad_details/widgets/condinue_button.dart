
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class ButtonWithRightSideIcon extends StatelessWidget {
  const ButtonWithRightSideIcon({
    super.key, 
    required this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ElevatedButton.icon(
        icon: RotatedBox(
          quarterTurns: 3,
          child: Container(width: 45,height: 45,
            decoration: const BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: const RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.arrow_back_ios_new,
                color: kPrimaryColor, 
                size: kpadding15,
              )
            ),
          )
          // Icon(Icons.expand_circle_down,color: kWhiteColor,size: 50,)
        ),
        
        label: const Center(
          child: Text(
            'Continue',
            style: TextStyle(
              fontSize: 25,
              color: kWhiteColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          // disabledForegroundColor: kPrimaryColor.withOpacity(0.5),
          disabledBackgroundColor: kPrimaryColor.withOpacity(0.2),

        ),
        onPressed: onPressed,
      ),
    );
  }
}