import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/widgets/otp_input.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _openBottomSheet(context));
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/signup.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ));
  }

  _openBottomSheet(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      isDismissible: false,
      backgroundColor: kPrimaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: screenHeight * .5,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight5,
                Text(
                  'Sign up | Sign in',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  width: screenWidth * .9,
                  child: const Divider(
                    color: kWhiteColor,
                    thickness: 1,
                  ),
                ),
                kHeight10,
                SizedBox(
                  width: screenWidth * .9,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kWhiteColor.withOpacity(.24),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                kHeight5,
                Text(
                  'OTP',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                kHeight10,
                Row(
                  children: const [
                    OtpInput(),
                    kWidth10,
                    OtpInput(),
                    kWidth10,
                    OtpInput(),
                    kWidth10,
                    OtpInput(),
                    kWidth10,
                    OtpInput(),
                    kWidth10,
                    OtpInput(),
                  ],
                ),
                kHeight10,
                Row(
                  children: [
                    Text(
                      'Terms and Conditions apply',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: kWhiteColor),
                    )
                  ],
                ),
                kHeight10,
                StartButton(
                    screenWidth: screenWidth,
                    ontap: () {},
                    boldText: "Signin | Signup",
                    lightText: 'Now',
                    button: kWhiteColor,
                    circle: kPrimaryColor,
                    arrow: kWhiteColor,),
              ],
            ),
          ),
        );
      },
    );
  }
}
