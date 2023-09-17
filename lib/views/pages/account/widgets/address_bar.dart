
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:need_in_choice/config/theme/screen_size.dart';

import 'package:need_in_choice/services/model/account_model.dart';
import 'package:need_in_choice/services/repositories/auth_repo.dart';
import 'package:need_in_choice/views/pages/account/bloc/account_page_bloc.dart';
import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';
import 'package:need_in_choice/views/pages/login/splash_screen_new.dart';

import '../../../../services/repositories/repository_urls.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../update_address.dart';

class AddressBar extends StatefulWidget {
  const AddressBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressBar> createState() => _AddressBarState();
}

class _AddressBarState extends State<AddressBar> {
  final iconPicker = ImagePicker();
  String title = 'AlertDialog';
  bool tappedYes = false;
  bool imageIsUploading = false;

  @override
  Widget build(BuildContext context) {
    final width = ScreenSize.size.width;
    AccountModels accountData = AccountSingleton().getAccountModels;
    log(accountData.toString());
    bool isPressed = false;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignoutState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return const SplashScreen();
            }),
            (Route<dynamic> route) => false,
          );
        }else if(state is AuthLoggedIn){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account Updated'),
            ),
          );
        }
      },
      child: BlocBuilder<AccountPageBloc, AccountPageState>(
        builder: (context, state) {
          if (state is AccountEditedState) {
            accountData = state.accountModal;
          }
          if (state is AccountDataError) {
            Center(child: Text(state.error));
          } else if (state is ViewPressedState) {
            isPressed = true;
          } else if (state is ViewNotPressedState) {
            isPressed = false;
          }
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoggedIn) {
                accountData = state.accountModels;
                imageIsUploading = false;
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
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
                        InkWell(
                          onTap: () {
                            openUpdate(context, accountData);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              color: kWhiteColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.mode_edit_outline_outlined,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            showErrorDialog(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              color: kWhiteColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.power_settings_new_sharp,
                              color: kRedColor,
                            ),
                          ),
                        ),
                        kHeight10,
                      ],
                    ),
                    SizedBox(
                      width: width * 0.55,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            accountData.name ?? "",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          kHeight5,
                          Text(
                            accountData.address ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            ImagePicker()
                                .pickImage(source: ImageSource.gallery)
                                .then((pickedImage) {
                              if (pickedImage != null) {
                                imageIsUploading = true;
                                BlocProvider.of<AuthBloc>(context).add(UpdateAccountDataEvent(accountData: accountData,profileImage: pickedImage));
                              }
                            });
                          },
                          child: CircleAvatar(
                              maxRadius: 40,
                              backgroundColor: kLightGreyColor,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(40)),
                                          border: Border.all(width: 0.3),
                                          color: Colors.white,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: "$imageUrlEndpoint${accountData.profileImage}",
                                          placeholder: (context, url) => Image.asset('assets/images/profile/no_profile_img.png'),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/profile/no_profile_img.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    imageIsUploading
                                        ? const CircularProgressIndicator()
                                        : const SizedBox()
                                  ],
                                ),
                              )),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
          );
        },
      ),
    );
  }

  Future<dynamic> openUpdate(
      BuildContext ctx, AccountModels accountData) async {
    return await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: ctx,
      isScrollControlled: true,
      builder: (context) => BlocProvider<AccountPageBloc>.value(
        value: AccountPageBloc(Authrepo()),
        child: SingleChildScrollView(
          reverse: false,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const UpdateAdress(),
        ),
      ),
    );
  }

  Future<void> showErrorDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text(
            'Logout Confirmation',
            style: TextStyle(color: kPrimaryColor),
          ),
          content: const Text('Are you sure, you want to logout?',
              style: TextStyle(color: kBlackColor)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: kGreyColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(const SignOutEvent());
              },
              child: const Text(
                'Ok',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            )
          ],
        );
      },
    );
  }
}
