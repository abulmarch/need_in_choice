
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/theme/screen_size.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/utils/constants.dart';

import '../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../blocs/ad_create_or_update_bloc/exception_file.dart';
import '../../../config/routes/route_names.dart';
import '../../../utils/dummy_data.dart';
import '../../widgets_refactored/error_popup.dart';
import 'widgets/ad_preview_image_card.dart';
import 'widgets/adspreview_bottom_sheet_realestate.dart';
import 'widgets/text_icon_button.dart';

class AdPreviewScreen extends StatelessWidget {
  const AdPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.size.height;
    final double screenWidth = ScreenSize.size.width;
    return BlocConsumer<AdCreateOrUpdateBloc, AdCreateOrUpdateState>(
      builder: (context, state) {
        bool isAdUloading = false;
        if (state is AdUploadingProgress) {
          isAdUloading = true;
        }
        final adDetails = BlocProvider.of<AdCreateOrUpdateBloc>(context).adCreateOrUpdateModel;
        final imageList = [...adDetails.imageFiles, ...adDetails.imageUrls];
        return SafeArea(
          child: Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kpadding10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: screenHeight - screenHeight * .24,
                        width: screenWidth * .9,
                        padding: EdgeInsets.only(bottom: screenHeight*0.15),
                        decoration: BoxDecoration(
                          color: kLightBlueWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: kLightBlueWhiteBorder, width: 1),
                        ),
                        child: AdPreviewImageCard(
                          houseFoRentr: houseFoRentAd,
                          imageUrlsOrFiles: imageList,
                        ),
                      )
                    ],
                  ),
                ),
                LayoutBuilder(
                  builder: (context, boxConstraints) {
                    return AdPreviewBottomSheetRealEstate(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      availableHeight: boxConstraints.maxHeight,
                    );
                  }
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
                child: SizedBox(
              width: screenWidth,
              height: screenHeight * .1,
              child: ColoredBox(
                color: kWhiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextIconButton(
                      onpressed: () {
                        Navigator.popUntil(context, ModalRoute.withName('${adDetails.adsLevels['route']}'));
                      },
                      text: 'Edit',
                      fontsize: 22,
                      txtcolor: kFadedBlack,
                      // size: const Size(126, 77),
                      size: Size(screenWidth * 0.4, 60),
                      bordercolor: const Color(0XFFB7B7B7),
                    ),
                    imageList.isEmpty 
                    ? TextIconButtonDisabled.blue(width: screenWidth * 0.5, height: 60, text: 'Confirm Ad')
                    : TextIconButton(
                      onpressed: !isAdUloading
                          ? () {
                              context
                                  .read<AdCreateOrUpdateBloc>()
                                  .add(UploadAdEvent());
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
            )),
          ),
        );
      },
      listener: (context, state) {
        if (state is AdUploadingCompletedState) {
          Navigator.pushNamed(context, confirmLottieScreen);
        }else if (state is AdUploadingExceptionState) {
          if(state.exception is FaildToUploadDataException){
            showErrorDialog(context, 'Something went wrong. Try again.').then((value) {
              Navigator.popUntil(context, ModalRoute.withName(mainNavigationScreen));
            });
          }else if(state.exception is InvalidPincodeException){
            showErrorDialog(context, 'Invalid Pincod');
          }else if(state.exception is InvalidAddressException){
            showErrorDialog(context, 'Invalid address, Include pincod in the address');
          }else{
            showErrorDialog(context, 'Verify your address');
          }
        }
      },
    );
  }
}
