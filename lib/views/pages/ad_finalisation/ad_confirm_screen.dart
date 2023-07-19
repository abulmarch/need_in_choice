import 'dart:io' show File;
import 'package:image_picker/image_picker.dart' show XFile;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/views/pages/ad_finalisation/ad_preview_screen.dart';
import 'package:need_in_choice/views/widgets_refactored/circular_back_button.dart';
import '../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../config/routes/route_names.dart';
import '../../../services/repositories/repository_urls.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/camera_bottomsheet.dart';
import '../../widgets_refactored/error_popup.dart';
import 'widgets/text_icon_button.dart';
import 'widgets/update_address_bottomsheet.dart';

class AdConfirmScreen extends StatefulWidget {
  const AdConfirmScreen({super.key});

  @override
  State<AdConfirmScreen> createState() => _AdConfirmScreenState();
}

class _AdConfirmScreenState extends State<AdConfirmScreen> {
  late AdCreateOrUpdateBloc adCreateOrUpdateBloc;
  @override
  Widget build(BuildContext context) {
    final screnSize = MediaQuery.of(context).size;
    adCreateOrUpdateBloc = BlocProvider.of<AdCreateOrUpdateBloc>(context);
    adCreateOrUpdateBloc.initializeStreamController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: BlocConsumer<AdCreateOrUpdateBloc, AdCreateOrUpdateState>(
          builder: (context, state) {
            bool isAdUloading = false;
            if (state is AdUploadingProgress) {
              isAdUloading = true;
            }
            return Padding(
              padding: const EdgeInsets.only(
                  top: kpadding10, left: kpadding10, right: kpadding10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircularBackButton(
                        size: const Size(45, 45),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      kWidth10,
                      Text(
                        'Ads Finalisation',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: const Color(0XFF575757)),
                      ),
                    ],
                  ),
                  kHeight5,
                  const Padding(
                    padding: EdgeInsets.only(left: kpadding20 * 2),
                    child: Text(
                      '---------------------------',
                      style: TextStyle(
                          height: 0.7, color: kDottedBorder, letterSpacing: 2),
                    ),
                  ),
                  kHeight5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // kWidth20,
                      InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            backgroundColor: kWhiteColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                            context: context,
                            builder: (context) {
                              return const CameraBottomSheet();
                            },
                          );
                        },
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kadBox,
                            border: Border.all(
                              color: const Color(0xFFE2E2E2),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: kpadding20 * 3.5),
                            child: Column(
                              children: [
                                const Icon(Icons.camera_alt_outlined),
                                kHeight20,
                                kHeight20,
                                Text(
                                  'Add Image',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: const Color(0XFF979797)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        width: 150,
                        child: StreamBuilder<List<dynamic>>(
                            stream: adCreateOrUpdateBloc.imageListStream,
                            builder: (context, snapshot) {
                              final int imageCount =
                                  (snapshot.data ?? []).length;
                              return RichText(
                                text: TextSpan(
                                    text: imageCount.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontSize: 100,
                                          color: kBlackColor,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: '\nimage',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontSize: 15,
                                                color: kBlackColor,
                                                height: .01),
                                      ),
                                      TextSpan(
                                        text: '\nUpdated',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontSize: 15,
                                            ),
                                      ),
                                    ]),
                                textAlign: TextAlign.center,
                              );
                            }),
                      ),
                    ],
                  ),
                  kHeight15,
                  SizedBox(
                    height: 100,
                    child: StreamBuilder<List<dynamic>>(
                        stream: adCreateOrUpdateBloc.imageListStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            if (snapshot.hasData) {
                              final adImages = snapshot.data ?? [];
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: (adImages).length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        padding:
                                            const EdgeInsets.all(kpadding10),
                                        decoration: BoxDecoration(
                                            color: kWhiteColor,
                                            border:
                                                Border.all(color: kGreyColor),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: adImages[index].runtimeType ==
                                                String
                                            ? Image.network(
                                                '$imageUrlEndpoint${adImages[index]}',
                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 70,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Icon(Icons.image),
                                                // loadingBuilder: (context, child, loadingProgress) {
                                                //   if(loadingProgress == null) return child;
                                                //     return const Center(child: CircularProgressIndicator(color: kBlackColor,));
                                                // },
                                              )
                                            : Image.file(
                                                File((adImages[index] as XFile)
                                                    .path),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: InkWell(
                                          onTap: () {
                                            context
                                                .read<AdCreateOrUpdateBloc>()
                                                .deleteImage(
                                                    index: index,
                                                    data: adImages[index]);
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/close_icon.png',
                                            scale: 0.85,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 5,
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                  kHeight15,
                  const Padding(
                    padding: EdgeInsets.only(left: kpadding20 * 2),
                    child: Text(
                      '---------------------------',
                      style: TextStyle(
                          height: 0.7, color: kDottedBorder, letterSpacing: 2),
                    ),
                  ),
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.flutter_dash_rounded,
                        color: kGreyColor,
                      ),
                      kWidth10,
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: 65,
                            maxHeight: 110,
                            maxWidth: screnSize.width - 70,
                            minWidth: 150),
                        child: StreamBuilder<String>(
                            stream: adCreateOrUpdateBloc.addressStream,
                            builder: (context, snapshot) {
                              final String address = snapshot.data ?? "";
                              return RichText(
                                text: TextSpan(
                                    text: "Ads Address\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          color: kPrimaryColor,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: address,
                                        // 'Technopark Campus, Technopark Campus, Kazhakkoottam, Thiruvananthapuram, Kerala 695581',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ]),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                textAlign: TextAlign.start,
                              );
                            }),
                      ),
                    ],
                  ),
                  kHeight10,
                  TextIconButton(
                    text: '+ Update Ad Location',
                    txtcolor: const Color(0XFF6F6F6F),
                    fontsize: 15,
                    onpressed: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        backgroundColor: kWhiteColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                        context: context,
                        builder: (context) {
                          return const UpdateAdressBottomSheet();
                        },
                      );
                    },
                    size: const Size(222, 38),
                  ),
                  const Spacer(),
                  TextIconButton(
                    text: 'Preview Ad',
                    txtcolor: kPrimaryColor,
                    fontsize: 15,
                    onpressed: () {
                      //.;
                      // Navigator.pushNamed(context, adPreviwScreen);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdPreviewScreen(),
                          ));
                    },
                    size: const Size(246, 50),
                  ),
                  kHeight15,
                  TextIconButton(
                    text: 'Confirm Ad',
                    txtcolor: kWhiteColor,
                    fontsize: 15,
                    onpressed: !isAdUloading
                        ? () {
                            context
                                .read<AdCreateOrUpdateBloc>()
                                .add(UploadAdEvent());
                          }
                        : null,
                    size: const Size(321, 61),
                    background: const Color(0XFF303030),
                    bordercolor: kWhiteColor,
                  ),
                  kHeight20,
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state is ImageFileUploadingState) {
              Navigator.pop(context);
              Future.delayed(const Duration(seconds: 1)).then((value) {
                SnackBar snackBar = const SnackBar(
                  content: LinearProgressIndicator(),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color(0xFF00000e),
                  duration: Duration(hours: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            } else if (state is ImageFileUploadedState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              if (state.exception != null) {
                SnackBar snackBar = const SnackBar(
                  content: Text('You can not add morethan 7 images.'),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color(0xFF00000e),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else if (state is AdUploadingCompletedState && !state.isUploadFailed) {
              Navigator.pushNamed(context, confirmLottieScreen);
            }else if (state is AdUploadingCompletedState && state.isUploadFailed) {
              showErrorDialog(context, 'Somthing went wrong. Try again.').then((value) {
                // Navigator.popUntil(context, ModalRoute.withName(mainNavigationScreen));
              });
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    adCreateOrUpdateBloc.dispose();
    super.dispose();
  }
}
