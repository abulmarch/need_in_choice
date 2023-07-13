import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/views/pages/ad_detail/widgets/realestate_details_bottomsheet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';
import '../bloc/auth_bloc.dart';
import 'address_modelsheet.dart';
import 'alert_dialog_box.dart';

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
  bool mobileverified = false;

  final GlobalKey<FormState> _phoneNumberFormKey = GlobalKey();
  final GlobalKey<FormState> _otpFormKey = GlobalKey();

  bool validateMobileNumber(String mobileNumber) {
    String pattern = r'^\d{10}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(mobileNumber);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: _phoneNumberFormKey,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AuthLoggedIn) {
            Navigator.pushNamed(context, mainNavigationScreen);
          } else if (state is AuthNotLoggedIn) {
            return _openAddressBottomModalSheet();
          }
        },
        child: SingleChildScrollView(
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
                  const MySeparator(
                    color: kWhiteColor,
                  ),
                  kHeight20,
                  kHeight10,
                  SizedBox(
                    width: screenWidth * .9,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a mobile number';
                        } else if (!validateMobileNumber(value)) {
                          return 'Please enter a valid mobile number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      style: const TextStyle(color: kWhiteColor),
                      onChanged: (value) {
                        if (phoneController.text.length == 10) {
                          setState(() {
                            mobileverified = true;
                          });
                        } else {
                          setState(() {
                            mobileverified = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kWhiteColor.withOpacity(.24),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        prefixText: '+91 | ',
                        prefixStyle:
                            const TextStyle(color: kWhiteColor, fontSize: 18),
                        suffixIcon: mobileverified
                            ? GestureDetector(
                                onTap: () async {
                                  if (_phoneNumberFormKey.currentState!
                                      .validate()) {
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
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        hintText: 'Enter Phone Number',
                        hintStyle:
                            TextStyle(color: kWhiteColor.withOpacity(0.6)),
                      ),
                    ),
                  ),
                  kHeight20,
                  kHeight10,
                  Container(
                    color: kPrimaryColor,
                    height: screenHeight * .075,
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
                          inactiveColor: kWhiteColor,
                          inactiveFillColor: kWhiteColor.withOpacity(.24),
                          selectedFillColor: kWhiteColor.withOpacity(.24),
                          selectedColor: kPrimaryColor,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 48,
                          borderWidth: 1,
                        ),
                        cursorColor: kWhiteColor,
                        animationDuration: const Duration(milliseconds: 300),
                        keyboardType: TextInputType.number,
                        enableActiveFill: true,
                        textInputAction: TextInputAction.done,
                        enablePinAutofill: true,
                      ),
                    ),
                  ),
                  kHeight20,
                  kHeight10,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return StartButton(
                          screenWidth: screenWidth,
                          ontap: () async {
                            if (_otpFormKey.currentState!.validate()) {
                              if (state is AuthCodeSentSuccess) {
                                await verifyOTP(context, state.verificationId);
                                await login();
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
        ),
      ),
    );
  }

  void _openAddressBottomModalSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        reverse: false,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddressModalSheet(phoneNumber: int.parse(phoneController.text)),
      ),
    );
  }

  Future login() async {
    context.read<AuthBloc>().add(AuthLoginEvent());
  }

  verifyOTP(BuildContext context, code) async {
    context.read<AuthBloc>().add(
        VerifySentOtpEvent(otpCode: otpController.text, verificationId: code));
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
