import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';

import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';
import 'package:need_in_choice/views/pages/login/widgets/signin_modelsheet.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //bool _isLoading = false;
  //bool _isLoad = false;
  bool mobileverified = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final bool isLoading = false;
  late bool selectedValue = false;

  //final GlobalKey<FormState> _phoneNumberFormKey = GlobalKey();
 // final GlobalKey<FormState> _otpFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthVerified) {
              Navigator.pushNamed(context, mainNavigationScreen);
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return
                  // Stack(
                  //   children: [
                  //     Container(
                  //       height: screenHeight,
                  //       width: screenWidth,
                  //       decoration: const BoxDecoration(
                  //         image: DecorationImage(
                  //           image: AssetImage('assets/images/splash.png'),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),
                  //     // Container(
                  //     //   height: screenHeight,
                  //     //   width: screenWidth,
                  //     //   decoration:
                  //     //       BoxDecoration(color: kBlackColor.withOpacity(.5)),
                  //     // ),

                  //     Positioned(
                  //         top: screenHeight * .43, child: const SigninModalSheet()),
                  //   ],
                  // );

                  SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * .47,
                      width: screenWidth,
                      child: Image.asset(
                        'assets/images/splash.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SigninModalSheet()
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
