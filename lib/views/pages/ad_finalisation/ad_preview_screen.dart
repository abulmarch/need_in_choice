import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';

import '../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../config/routes/route_names.dart';
import '../../../utils/dummy_data.dart';
import 'widgets/ad_preview_image_card.dart';
import 'widgets/adspreview_bottom_sheet_realestate.dart';
import 'widgets/text_icon_button.dart';

class AdPreviewScreen extends StatelessWidget {
  const AdPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<AdCreateOrUpdateBloc, AdCreateOrUpdateState>(
      builder: (context, state) {
        bool isAdUloading = false;
        if(state is AdUploadingProgress){
          isAdUloading = true;
        }
        final adDetails = BlocProvider.of<AdCreateOrUpdateBloc>(context).adCreateOrUpdateModel;
        final imageList = [...adDetails.imageFiles, ...adDetails.imageUrls];
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kpadding10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      kHeight10,
                      AdPreviewImageCard(
                        houseFoRentr: houseFoRentAd,
                        imageUrlsOrFiles: imageList,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 81,
                  child: AdPreviewBottomSheetRealEstate(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: screenWidth,
                    height: 80,
                    child: ColoredBox(
                      color: kWhiteColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextIconButton(
                            onpressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Edit',
                            fontsize: 22,
                            txtcolor: kFadedBlack,
                            // size: const Size(126, 77),
                            size: Size(screenWidth * 0.4, 60),
                            bordercolor: const Color(0XFFB7B7B7),
                          ),
                          TextIconButton(
                            onpressed: !isAdUloading ? () {
                              context.read<AdCreateOrUpdateBloc>().add(UploadAdEvent());
                            }
                            : null,
                            text: 'Confirm Ad',
                            fontsize: 22,
                            txtcolor: kWhiteColor,
                            background: kPrimaryColor,
                            // size: const Size(243, 77),
                            size: Size(screenWidth * 0.5, 60),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if(state is AdUploadingCompletedState){
          Navigator.pushNamed(context, confirmLottieScreen);
        }
      },
    );
  }
}
