// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:need_in_choice/services/model/account_model.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/account/bloc/account_page_bloc.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';

import '../login/widgets/alert_dialog_box.dart';

class UpdateAdressModel extends StatelessWidget {
  final AccountModels accountModels;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final whatsappController = TextEditingController();
  static GlobalKey<FormState> nameFormKey = GlobalKey();

  UpdateAdressModel({
    Key? key,
    required this.accountModels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    nameController.text = accountModels.name!;
    addressController.text = accountModels.address!;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Form(
        key: nameFormKey,
        child: Container(
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          height: screenHeight * 0.6,
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
                    controller: whatsappController,
                    decoration: InputDecoration(
                      hintText: "whatsapp number",
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
                  child: BlocBuilder<AccountPageBloc, AccountPageState>(
                    builder: (context, state) {
                      if (state is AccountEditingState) {
                        return SizedBox(
                          height: screenHeight * 0.085,
                          width: screenWidth * .8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Updating Account',
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
                          if (nameFormKey.currentState!.validate()) {
                            final accountDetails = AccountModels(
                              whatsapp: whatsappController.text,
                              userId: accountModels.userId,
                              address: addressController.text,
                              name: nameController.text,
                            );
                            
                          context.read<AccountPageBloc>().add(EditingAccount(accountDetails));
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
                        boldText: "Update",
                        lightText: ' Account',
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
    );
  }

  updateAccount(AccountModels accountModels) async {
    
  }
}
