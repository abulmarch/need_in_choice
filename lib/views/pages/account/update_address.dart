import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:http/http.dart' as http;
import 'package:need_in_choice/views/pages/home_page/main_navigation_page.dart';
import '../../../services/model/account_model.dart';
import '../../../services/repositories/auth_repo.dart';
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
  bool validateMobileNumber(String mobileNumber) {
    String pattern = r'^\d{10}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(mobileNumber);
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
    addressController.text =
        AccountSingleton().getAccountModels.address!;
    whatsappController.text =
        AccountSingleton().getAccountModels.whatsapp ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
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
                    validator:  (value) {
                        if (!validateMobileNumber(value ?? '')) {
                          return 'Please enter a valid mobile number';
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
                          updateAccountDetails();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainNavigationScreen()),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Account Updated'),
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
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateAccountDetails() async {
    final apiUrl = Uri.parse('https://nic.calletic.com/api/account/update');

    var request = http.MultipartRequest('POST', apiUrl);

    String? userId = AccountSingleton().getAccountModels.userId;
    if (userId != null) {
      request.fields["user_id"] = userId;
    } else {
      debugPrint("User ID not available");
      return;
    }
    setState(() {
      request.fields["name"] = nameController.text;
      request.fields["address"] = addressController.text;
      request.fields["whatsapp"] = whatsappController.text;
    });

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        Authrepo().fetchAccountsData(userId).then((accountmodel) {
          if (accountmodel != null) {
            AccountSingleton().setAccountModels = accountmodel;
          }
        });

        log('Account details updated successfully');
      } else {
        log('Failed to update details. Status code: ${response.request}');
      }
    } catch (e) {
      debugPrint('Error updating details: $e');
    }
  }
}
