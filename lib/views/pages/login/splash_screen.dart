import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
            FutureBuilder(
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {                
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return StartButton(
                      screenWidth: screenWidth,
                      boldText: 'Get Started',
                      lightText: ' Now',
                      circle: kWhiteColor,
                      button: kPrimaryColor,
                      ontap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(signUpScreen, (route) => false);
                      },
                      arrow: kPrimaryColor,
                    );
                  default :
                    return const Center(child: CircularProgressIndicator(color: Colors.black,));
                }
              },
            ),
            kHeight20
          ],
        ),
      ),
    );
  }
}