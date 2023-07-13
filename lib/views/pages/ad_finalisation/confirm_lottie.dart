
import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';

import '../../../config/routes/route_names.dart';


class ConfirmLottieScreen extends StatefulWidget {
  const ConfirmLottieScreen({super.key});

  @override
  State<ConfirmLottieScreen> createState() => _ConfirmLottieScreenState();
}

class _ConfirmLottieScreenState extends State<ConfirmLottieScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.popUntil(context, ModalRoute.withName(mainNavigationScreen));
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: kWhiteColor,
      body: Center(
        child: Column(
          children: [
            kHeight20,
            Padding(
              padding: const EdgeInsets.only(right: kpadding20),
              child: Image.asset('assets/images/congrats.png', fit: BoxFit.contain,),
            ),
              kHeight20,
              kHeight20,
            Text('Congrtas !', style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kPrimaryColor, fontSize: 40),),
            kHeight15,
            const Text(
                      '-------------------------',
                      style: TextStyle(height: 0.7, color: kDottedBorder),
                    ),
                    kHeight15,
                    RichText(text: TextSpan(
                      text: 'Now Your Ad Is being', style: Theme.of(context).textTheme.displaySmall!.copyWith(color: kBlackColor),
                      children: [
                        TextSpan(
                          text: '\nSend to the Clouds', style: Theme.of(context).textTheme.displaySmall!.copyWith(color: kPrimaryColor),
                        ),
                      ]
                    ),
                    textAlign: TextAlign.center,)
          ],
        ),
      ),
    ));
  }
}
