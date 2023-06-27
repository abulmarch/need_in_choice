import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/ad_detail/ad_detail_bloc/bloc/ad_detail_bloc.dart';
import 'package:need_in_choice/views/pages/ad_detail/widgets/image_card.dart';
import 'package:need_in_choice/views/pages/ad_detail/widgets/top_account_bar.dart';
import 'package:need_in_choice/views/pages/ad_detail/widgets/bottomsheet_e_auction.dart';
import '../../../services/repositories/selected_ads_service.dart';
import '../../../utils/dummy_data.dart';

class AdDetailScreen extends StatelessWidget {
  const AdDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int adId = ModalRoute.of(context)!.settings.arguments as int;
    log(adId.toString());
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: BlocProvider<AdDetailBloc>(
            create: (context) => AdDetailBloc(SelectedAdsRepo())
              ..add(FetchAdDetailEvent(adId: adId)),
            child: BlocBuilder<AdDetailBloc, AdDetailState>(
              builder: (context, state) {
                if (state is AdDetailsLoaded) {
                  final adsModel = state.adsModel;
                  if (adsModel != null) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(kpadding10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TopAccountBar(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                                adsModel: adsModel,
                              ),
                              kHeight5,
                              ImageCard(
                                phouseFoRentr: houseFoRentAd,
                                imageUrls: adsModel.images,
                                timeAgo: adsModel.timeAgo,
                              ),
                            ],
                          ),
                        ),
                        // BottomDetailsSheet(
                        //   screenWidth: screenWidth,
                        //   screenHeight: screenHeight,
                        //   adsModel: adsModel,
                        // ),
                        BottomSheetEAction(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          adsModel: adsModel,
                        )
                      ],
                    );
                  } else {
                    // ignore: prefer_const_constructors
                    return Center(
                      child: const Text('Something went wrong'),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
      ),
    );
  }
}
