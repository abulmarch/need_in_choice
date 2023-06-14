import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


import '../../home_page/main_navigation_page.dart';

class SigninModalSheet extends StatefulWidget {
  const SigninModalSheet({super.key});

  @override
  State<SigninModalSheet> createState() => _SigninModalSheetState();
}

class _SigninModalSheetState extends State<SigninModalSheet> {
  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final phoneController = TextEditingController();

  final TextEditingController otpController = TextEditingController();
  bool mobileverified = false;
  bool isLoading = false;
  bool selectedValue = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  User? user;

  String? uid;

  String code = '';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeight5,
            Text(
              'Sign up | Sign in',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            kHeight10,
            DashedLineGenerator(
              width: screenWidth,
              color: kWhiteColor,
            ),
            kHeight10,
            SizedBox(
              width: screenWidth * .9,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                style: const TextStyle(color: kWhiteColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kWhiteColor.withOpacity(.24),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      verifyNumber(context);

                      setState(() {
                        isLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 10), () {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          right: kpadding10,
                          top: kpadding10,
                          bottom: kpadding10),
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kWhiteColor),
                      child: isLoading
                          ? const SizedBox(
                              height: 10,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            )
                          : const Text(
                              'Send OTP',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            kHeight5,
            Text(
              'OTP',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            kHeight5,
            Container(
              color: kPrimaryColor,
              height: screenHeight * .065,
              width: screenWidth * .9,
              child: Form(
                child: PinCodeTextField(
                    backgroundColor: kPrimaryColor,
                    controller: otpController,
                    textStyle: const TextStyle(color: kWhiteColor),
                    appContext: context,
                    length: 6,
                    onChanged: (value) {},
                    pinTheme: PinTheme(
                      activeColor: kPrimaryColor,
                      activeFillColor: kWhiteColor.withOpacity(.24),
                      inactiveColor: kPrimaryColor,
                      inactiveFillColor: kWhiteColor.withOpacity(.24),
                      selectedFillColor: kWhiteColor.withOpacity(.24),
                      selectedColor: kPrimaryColor,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 45,
                      borderWidth: 0.5,
                    ),
                    cursorColor: kWhiteColor,
                    animationDuration: const Duration(milliseconds: 300),
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    onCompleted: (pin) async {}),
              ),
            ),
            kHeight5,
            Row(
              children: [
                Radio(
                  activeColor: kWhiteColor,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return (selectedValue) ? kWhiteColor : kWhiteColor;
                  }),
                  value: true,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value ?? false;
                    });
                  },
                ),
                Text(
                  'Terms and Conditions apply',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: kWhiteColor),
                ),
              ],
            ),
            kHeight5,
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: StartButton(
                screenWidth: screenWidth,
                ontap: () {
                  verifyOTP(context);
                },
                boldText: "Signin | Signup",
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

  void verifyNumber(BuildContext context) {
    auth.verifyPhoneNumber(
      phoneNumber: "+91 ${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {});
      },
      verificationFailed: (FirebaseAuthException exception) {
        if (exception.code == 'invalid-phone-number') {
          showDialog(
            context: context,
            builder: (context) => const AlertDialogBox(
              title: 'Invalid Phone Number',
              content:
                  Text('The format of the phone number provided is incorrect.'),
            ),
          );
        }
      },
      codeSent: (String verificationID, int? resendToken) {
        code = verificationID;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP(BuildContext context) async {
    if (selectedValue) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: code,
          smsCode: otpController.text,
        );

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;

        if (user != null) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainNavigationScreen(
                selectIndex: 0,
              ),
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) => const AlertDialogBox(
              title: 'Incorrect OTP',
              content: Text('The entered OTP is incorrect.'),
            ),
          );
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error verifying OTP: $e');
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialogBox(
          title: 'Terms and Conditions',
          content: Text('Please accept the terms and conditions.'),
        ),
      );
    }
  }
}

class AlertDialogBox extends StatelessWidget {
  const AlertDialogBox({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: kPrimaryColor),
      ),
      content: content,
      actions: [
        TextButton(
          child: const Text(
            'Ok',
            style: TextStyle(color: kPrimaryColor),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
