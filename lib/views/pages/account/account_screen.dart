import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:need_in_choice/services/model/ads_models.dart';
import 'package:need_in_choice/views/pages/account/ad_card_cubit/ad_card_cubit.dart';
import 'package:need_in_choice/views/pages/account/bloc/account_page_bloc.dart';
import 'package:need_in_choice/views/pages/account/widgets/ad_tiles.dart';
import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';
import 'package:need_in_choice/views/widgets_refactored/lottie_widget.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/search_form_field.dart';
import 'widgets/address_bar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<AdsModel> adsData = [];
  List<AdsModel> filteredAdsData = [];
  bool isPressed = false;
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
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
                return Center(
                  child: Lottie.asset(LottieCollections.loading),
                );
              } else if (state is AccountDataLoaded) {
                adsData = state.adsModelList;
              } else if (state is ViewPressedState) {
                isPressed = true;
              } else if (state is ViewNotPressedState) {
                isPressed = false;
              } else if (state is AccountEditedState) {
                context.read<AccountPageBloc>().add(AccountLoadingEvent());
              } else if (state is SearchLoadedState) {
                isSearching = true;
                filteredAdsData = state.filteredAdsDataList;
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      const AddressBar(),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kpadding20),
                        child: SearchFormField(
                          hintText: 'Search your Ads',
                          controller: searchController,
                          onChanged: (value) {
                            context.read<AccountPageBloc>().add(SearchEvent(
                                adsList: adsData, searchText: value));
                          },
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: kpadding10),
                      child: isPressed
                          ? LottieWidget.comingsoon()
                          : (isSearching ? filteredAdsData : adsData).isEmpty
                              ? LottieWidget.noData()
                              : ListView.builder(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: kpadding10),
                                  itemCount: isSearching
                                      ? filteredAdsData.length
                                      : adsData.length,
                                  itemBuilder: (context, index) {
                                    final ad = isSearching
                                        ? filteredAdsData[index]
                                        : adsData[index];
                                    return BlocProvider(
                                      create: (context) => AdCardCubit(),
                                      child: Adtiles(
                                        adsModel: ad,
                                      ),
                                    );
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
