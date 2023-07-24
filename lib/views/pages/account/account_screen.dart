import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/services/model/ads_models.dart';
import 'package:need_in_choice/views/pages/account/bloc/account_page_bloc.dart';
import 'package:need_in_choice/views/pages/account/widgets/ad_tiles.dart';
import 'package:need_in_choice/views/pages/account/widgets/address_bar.dart';
import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/search_form_field.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<AdsModel> adsData = [];
    bool isPressed = false;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignoutState) {
          Navigator.pushReplacementNamed(context, splashScreen);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<AccountPageBloc, AccountPageState>(
            builder: (context, state) {
              if (state is AccountPageLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AccountDataLoaded) {
                adsData = state.adsModelList;
              } else if (state is ViewPressedState) {
                isPressed = true;
              } else if (state is ViewNotPressedState) {
                isPressed = false;
              } else if (state is AccountEditedState) {
                context.read<AccountPageBloc>().add(AccountLoadingEvent());
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: const [
                      AddressBar(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: kpadding20),
                        child: SearchFormField(
                          hintText: 'Search your Ads',
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: kpadding10),
                      child: isPressed
                          ? const Center(
                              child: Text('coming soon..'),
                            )
                          : adsData.isEmpty
                              ? const Center(
                                  child: Text('No ads to preview'),
                                )
                              : ListView.builder(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                    horizontal: kpadding15 * 2,
                                  ),
                                  itemCount: adsData.length,
                                  itemBuilder: (context, index) {
                                    return Adtiles(adsData: adsData[index]);
                                  },
                                ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
