import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/services/model/account_model.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';

import 'alert_dialog_box.dart';

class AddressModalSheet extends StatelessWidget {
  final int phoneNumber;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  static GlobalKey<FormState> nameFormKey = GlobalKey();
  final user = FirebaseAuth.instance.currentUser;

  AddressModalSheet({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          const Center(
              child: CircularProgressIndicator(),
            );
        } else if (state is AuthAccountCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                backgroundColor: kPrimaryColor.withOpacity(.5),
                content: Text('Account Created', style: Theme.of(context).textTheme.labelSmall,),
                duration: const Duration(seconds: 3),
              ),
            );
          Navigator.pushNamed(context, mainNavigationScreen);
        } else if(state is AuthCreatedfailed){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('somthing happend'),
                duration: Duration(seconds: 20),
              ),
            );
        }
        
      },
      child: SingleChildScrollView(
        child: Form(
          key: nameFormKey,
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
                      
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Your Name",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 23),
                        filled: true,
                        fillColor: kWhiteColor.withOpacity(.24),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  kHeight10,
                  SizedBox(
                    width: screenWidth * .9,
                    child: TextFormField(
                      
                      controller: addressController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Your Address",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 23),
                        filled: true,
                        fillColor: kWhiteColor.withOpacity(.24),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  kHeight10,
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return StartButton(
                          screenWidth: screenWidth,
                          ontap: () async {
                            if (nameFormKey.currentState!.validate()) {
                              final accountDetails = AccountModels(
                                
                                phone: phoneNumber.toString(),
                                  userId: user!.uid,
                                  address: addressController.text,
                                  name: nameController.text,
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
}
