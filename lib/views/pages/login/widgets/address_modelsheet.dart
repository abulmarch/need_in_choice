import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/config/theme/screen_size.dart';
import 'package:need_in_choice/services/model/account_model.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';

import 'alert_dialog_box.dart';

class AddressModalSheet extends StatefulWidget {
  final int phoneNumber;

  const AddressModalSheet({super.key, required this.phoneNumber});

  @override
  State<AddressModalSheet> createState() => _AddressModalSheetState();
}

class _AddressModalSheetState extends State<AddressModalSheet> {
  final GlobalKey<FormState> _nameFormKey = GlobalKey();
  late final TextEditingController _nameController;

  late final  TextEditingController _addressController;
  User? _user;
  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _addressController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.size.height;
    final double screenWidth = ScreenSize.size.width;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAccountCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kPrimaryColor.withOpacity(.5),
              content: Text(
                'Account Created',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.pushReplacementNamed(context, mainNavigationScreen, arguments: state.accountModels);
        } else if (state is AuthCreatedfailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something happend'),
              duration: Duration(seconds: 20),
            ),
          );
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: _nameFormKey,
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
                    'Account Details',
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
                      controller: _nameController,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Your Name",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                                fontSize: 16,
                                color: kWhiteColor.withOpacity(0.5)),
                        filled: true,
                        fillColor: kWhiteColor.withOpacity(.24),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  kHeight10,
                  SizedBox(
                    width: screenWidth * .9,
                    child: TextFormField(
                      controller: _addressController,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Your Address",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                                fontSize: 16,
                                color: kWhiteColor.withOpacity(0.5)),
                        filled: true,
                        fillColor: kWhiteColor.withOpacity(.24),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  kHeight20,
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return SizedBox(
                          height: screenHeight * 0.085,
                          width: screenWidth * .8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Creating Account',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: kWhiteColor, fontSize: 18),
                              ),
                              kWidth15,
                              const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(kPrimaryColor),
                              ),
                            ],
                          ),
                        );
                      }
                      return StartButton(
                        screenWidth: screenWidth,
                        ontap: () async {
                          if (_nameFormKey.currentState!.validate()) {
                            final accountDetails = AccountModels(
                              phone: widget.phoneNumber.toString(),
                              userId: _user!.uid,
                              address: _addressController.text,
                              name: _nameController.text,
                            );

                            await createAccount(context, accountDetails);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialogBox(
                                title: ' Name is Empty',
                                content: Text('Please Enter Your Name'),
                              ),
                            );
                          }
                        },
                        boldText: "Finishing",
                        lightText: ' Process',
                        button: kWhiteColor,
                        circle: kPrimaryColor,
                        arrow: kWhiteColor,
                        textcolor: kPrimaryColor,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  createAccount(BuildContext context, AccountModels accountModels) async {
    context.read<AuthBloc>().add(AuthCraetionEvent(accountModels));
  }
  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
