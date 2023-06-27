// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';

import '../bloc/auth_bloc.dart';

class SigninModalSheet extends StatefulWidget {
  final String? code;
  const SigninModalSheet({
    Key? key,
    this.code,
  }) : super(key: key);

  @override
  State<SigninModalSheet> createState() => _SigninModalSheetState();
}

class _SigninModalSheetState extends State<SigninModalSheet> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final bool isLoading = false;
  late bool selectedValue = false;

  final GlobalKey<FormState> _phoneNumberFormKey = GlobalKey();
  final GlobalKey<FormState> _otpFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: _phoneNumberFormKey,
      child: Container(
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
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
                  validator: (value) {
                    if (value!.length != 10) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
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
                      onTap: () async {
                        if (_phoneNumberFormKey.currentState!.validate()) {
                          _sendOtp(
                              context: context,
                              phoneNumber: phoneController.text);
                        }
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
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const SizedBox(
                                height: 10,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            } else {
                              return const Text(
                                'Send OTP',
                                style: TextStyle(color: kPrimaryColor),
                              );
                            }
                          },
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
                  key: _otpFormKey,
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
                  ),
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
                padding: const EdgeInsets.only(left: 10.0),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return StartButton(
                      screenWidth: screenWidth,
                      ontap: () {
                        if (_otpFormKey.currentState!.validate()) {
                          if (state is AuthCodeSentSuccess) {
                            verifyOTP(context, state.verificationId);
                          }
                          
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialogBox(
                              title: ' OTP required',
                              content: Text('Please Enter OTP'),
                            ),
                          );
                        }
                      },
                      boldText: "Signin | Signup",
                      lightText: ' Now',
                      button: kWhiteColor,
                      circle: kPrimaryColor,
                      arrow: kWhiteColor,
                      textcolor: kPrimaryColor,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyOTP(BuildContext context, code) async {
    if (selectedValue) {
      context.read<AuthBloc>().add(VerifySentOtpEvent(
          otpCode: otpController.text, verificationId: code));
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialogBox(
          title: 'Terms and Conditions',
          content: Text('Please accept the terms and conditions'),
        ),
      );
    }
  }
}

void _sendOtp({required String phoneNumber, required BuildContext context}) {
  final phoneNumberWithCode = "+91$phoneNumber";
  context.read<AuthBloc>().add(
        SendOtpToPhoneEvent(
          phoneNumber: phoneNumberWithCode,
        ),
      );
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
