import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';

import 'otp_input.dart';

class SigninModalSheet extends StatelessWidget {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  
  SigninModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
      final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: 
        Column(
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
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: StartButton(
                      screenWidth: screenWidth,
                      ontap: () {},
                      boldText: "Signin|Signup",
                      lightText: ' Now',
                      button: kWhiteColor,
                      circle: kPrimaryColor,
                      arrow: kWhiteColor,
                      textcolor: kPrimaryColor,
                      ),
                ),
              ],
            ),
      ),
    );
  }
}