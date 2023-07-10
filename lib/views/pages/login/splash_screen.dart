import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
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
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return StartButton(
                      screenWidth: screenWidth,
                      boldText: 'Get Started',
                      lightText: ' Now',
                      circle: kWhiteColor,
                      button: kPrimaryColor,
                      ontap: () {
                        if (state is AuthInitial) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              signUpScreen, (route) => false);
                        }
                        if (state is AuthVerified) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              mainNavigationScreen, (route) => false);
                        }
                      },
                      arrow: kPrimaryColor,
                    );
                  },
                ),
                kHeight20
              ],
            ),
          ),
        );
      },
    );
  }
}
