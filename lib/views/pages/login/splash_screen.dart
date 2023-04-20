import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/splash.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'search and buy anything with nic now',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            kHeight20,
            StartButton(
                screenWidth: screenWidth,
                boldText: 'Get Started',
                lightText: ' Now',
                circle: kWhiteColor,
                button: kPrimaryColor,
                ontap: () {
                  print('get started now');
                },
                arrow: kPrimaryColor),
            kHeight20
          ],
        ),
      ),
    );
  }
}
