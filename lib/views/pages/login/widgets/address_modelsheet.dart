import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';

class AddressModalSheet extends StatelessWidget {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  
  AddressModalSheet({super.key});

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
                      hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 23),
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
                      hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 23),
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
                      ontap: () {},
                      boldText: "Finishing",
                      lightText: ' Process',
                      button: kWhiteColor,
                      circle: kPrimaryColor,
                      arrow: kWhiteColor,
                      textcolor: kPrimaryColor,),
                ),
          ],
        ),
      ),
    );
  }
}