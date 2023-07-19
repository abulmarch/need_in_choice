// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';

import 'package:need_in_choice/services/model/account_model.dart';
import 'package:need_in_choice/views/pages/account/bloc/account_page_bloc.dart';
import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../update_adress_model.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountModels accountData = AccountModels();
    bool isPressed = false;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignoutState) {
          Navigator.pushReplacementNamed(context, splashScreen);
        }
      },
      child: BlocBuilder<AccountPageBloc, AccountPageState>(
        builder: (context, state) {
          if (state is AccountDataError) {
            Center(child: Text(state.error));
          } else if (state is AccountDataLoaded) {
            accountData = state.accountModels;
          } else if (state is ViewPressedState) {
            isPressed = true;
          } else if (state is ViewNotPressedState) {
            isPressed = false;
          }
          return Container(
            width: double.infinity,
            height: 170,
            margin: const EdgeInsets.only(
              top: 5,
              bottom: kpadding10 * 3,
              left: 5,
              right: 5,
            ),
            padding: const EdgeInsets.all(kpadding10),
            decoration: BoxDecoration(
              color: kLightBlueWhite,
              borderRadius: const BorderRadius.all(
                Radius.circular(kpadding10),
              ),
              border: Border.all(color: kLightBlueWhiteBorder, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: kWhiteColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      accountData.name ?? "",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    kHeight5,
                    GestureDetector(
                      onTap: () {
                        openUpdate(context, accountData);
                      },
                      child: Text(
                        accountData.address ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/profile/no_profile_img.png'),
                    ),
                    kHeight5,
                    GestureDetector(
                      onTap: () {
                        if (isPressed) {
                          context
                              .read<AccountPageBloc>()
                              .add(ViewNotPressedEvent());
                        } else {
                          context
                              .read<AccountPageBloc>()
                              .add(ViewPressedEvent());
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isPressed
                              ? kPrimaryColor
                              : kPrimaryColor.withOpacity(.42),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.favorite_outline,
                                color: kWhiteColor,
                              ),
                              Text(
                                isPressed ? "viewing" : "view",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: kWhiteColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> openUpdate(BuildContext ctx, AccountModels accountData) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: ctx,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        reverse: false,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: UpdateAdressModel(accountModels: accountData),
      ),
    );
  }
}
