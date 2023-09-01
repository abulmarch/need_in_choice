import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/theme/screen_size.dart';
import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';
import '../../../services/model/account_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../login/widgets/start_button.dart';

class UpdateAdress extends StatefulWidget {
  const UpdateAdress({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateAdress> createState() => _UpdateAdressState();
}

class _UpdateAdressState extends State<UpdateAdress> {
  late final TextEditingController nameController;
  late final TextEditingController addressController;
  late final TextEditingController whatsappController;

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    addressController = TextEditingController();
    whatsappController = TextEditingController();
    accountDataInitilization();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    whatsappController.dispose();
    super.dispose();
  }

  void accountDataInitilization() {
    nameController.text = AccountSingleton().getAccountModels.name!;
    addressController.text = AccountSingleton().getAccountModels.address!;
    whatsappController.text =
        AccountSingleton().getAccountModels.whatsapp ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.size.height;
    final double screenWidth = ScreenSize.size.width;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          height: screenHeight * 0.62,
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
                    ),
                  ),
                ),
                kHeight10,
                SizedBox(
                  width: screenWidth * .9,
                  child: TextFormField(
                    controller: whatsappController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d{0,10}')),
                    ],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (value.length != 10 || int.tryParse(value) == null) {
                          return "Invalid phone number";
                        }
                      }
                      return null;
                    },
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: "whatsapp number",
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
                    ),
                  ),
                ),
                kHeight10,
                SizedBox(
                  width: screenWidth * .9,
                  child: TextFormField(
                    controller: addressController,
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
                    ),
                  ),
                ),
                kHeight10,
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: StartButton(
                      screenWidth: screenWidth,
                      ontap: () async {
                        if (_formKey.currentState!.validate()) {
                          final accData = AccountSingleton().getAccountModels;
                          BlocProvider.of<AuthBloc>(context)
                              .add(UpdateAccountDataEvent(
                                  accountData: accData.copyWith(
                            address: addressController.text,
                            name: nameController.text,
                            whatsapp: whatsappController.text,
                          )));
                          Navigator.pop(context);
                        }
                      },
                      boldText: "Update",
                      lightText: ' Account',
                      button: kWhiteColor,
                      circle: kPrimaryColor,
                      arrow: kWhiteColor,
                      textcolor: kPrimaryColor,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
