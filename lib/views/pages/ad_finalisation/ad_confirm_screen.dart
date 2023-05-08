import 'package:flutter/material.dart';
import 'package:need_in_choice/views/widgets_refactored/circular_back_button.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/camera_bottomsheet.dart';
import 'widgets/text_icon_button.dart';
import 'widgets/update_address_bottomsheet.dart';

class AdConfirmScreen extends StatelessWidget {
  const AdConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Padding(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  kWidth20,
                  Container(
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
                      padding: const EdgeInsets.only(top: kpadding20 * 3.5),
                      child: InkWell(
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
                        child: Column(
                          children: [
                            const Icon(Icons.camera_alt_outlined),
                            kHeight20,
                            kHeight20,
                            Text(
                              'Add Product Image',
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
                    width: 170,
                    child: RichText(
                      text: TextSpan(
                          text: "7",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
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
                    ),
                  ),
                ],
              ),
              kHeight15,
              SizedBox(
                height: 100,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                            border: Border.all(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          "assets/images/dummy/house_for_rent1.png",
                          fit: BoxFit.contain,
                          width: 70,
                          height: 70,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 5,
                        ),
                    itemCount: 7),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.flutter_dash_rounded,
                    color: kGreyColor,
                  ),
                  kWidth10,
                  RichText(
                    text: TextSpan(
                        text: "Ads Address",
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: kPrimaryColor,
                                ),
                        children: [
                          TextSpan(
                            text:
                                '\nTechnopark Campus,\nTechnopark Campus, Kazhakkoottam,\nThiruvananthapuram, Kerala 695581',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ]),
                    textAlign: TextAlign.start,
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
              kHeight20,
              kHeight10,
              TextIconButton(
                text: 'Preview Ad',
                txtcolor: kPrimaryColor,
                fontsize: 15,
                onpressed: () {
                  Navigator.pushNamed(context, adPreviwScreen);
                },
                size: const Size(246, 50),
              ),
              kHeight5,
              TextIconButton(
                text: 'Confirm Ad',
                txtcolor: kWhiteColor,
                fontsize: 15,
                onpressed: () {
                  Navigator.pushNamed(context, confirmLottieScreen);
                },
                size: const Size(321, 61),
                background: const Color(0XFF303030),
                bordercolor: kWhiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

