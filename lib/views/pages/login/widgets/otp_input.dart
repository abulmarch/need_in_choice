import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        cursorColor: Theme.of(context).primaryColor,
        decoration:  InputDecoration(
          filled: true,
          fillColor: kWhiteColor.withOpacity(.24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
