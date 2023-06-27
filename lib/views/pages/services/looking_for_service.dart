import 'package:dotted_border/dotted_border.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/level4_category_data.dart';
import 'package:flutter/material.dart';

import '../../widgets_refactored/circular_back_button.dart';
import '../../widgets_refactored/condinue_button.dart';
import '../../widgets_refactored/custom_text_field.dart';
import '../../widgets_refactored/dashed_line_generator.dart';
import '../real_estate/building_sale/collect_ad_details.dart';

class LookingForService extends StatelessWidget {
  const LookingForService({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 90),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: kpadding10),
              child: SizedBox(
                height: height * .08,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2, bottom: 0),
                        child: CircularBackButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          size: const Size(45, 45),
                        ),
                      ),
                      kWidth15,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Looking for a Service',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontSize: 22, color: kPrimaryColor),
                          ),
                          // title arrow underline
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              DashedLineGenerator(
                                width: building4saleCommercial[0]['cat_name']!
                                        .length *
                                    width *
                                    0.06,
                                color: kDottedBorder,
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                size: 15,
                                color: kDottedBorder,
                              )
                            ],
                          )
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (ctx, cons) {
            // double keyBoardHeight =
            //     0; //MediaQuery.of(context).viewInsets.bottom;
            return SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kpadding15),
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: cons.maxHeight,
                        maxHeight: double.infinity,
                      ),
                      child: Column(children: [
                        kHeight10,
                        //       Row(
                        //children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextField(
                                hintText: 'Ads name | Title',
                                suffixIcon: kRequiredAsterisk),
                            kHeight15,
                            const CustomTextField(
                                maxLines: 5,
                                hintText: 'Description',
                                suffixIcon: kRequiredAsterisk),
                            kHeight20,
                            RichText(
                              text: TextSpan(
                                text: 'Required ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: kLightGreyColor),
                                children: [
                                  TextSpan(
                                    text: 'Service',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                            color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                            const CustomTextField(
                                maxLines: 5,
                                hintText:
                                    'Eg Provide your needed service here.',
                                suffixIcon: kRequiredAsterisk),
                            kHeight20,
                            Center(
                                child: DashedLineGenerator(
                              width: width * .8,
                              color: kDottedBorder,
                            )),
                            kHeight20,
                            SizedBox(
                              height: height * 0.07,
                              child: DottedBorder(
                                dashPattern: const [3, 2],
                                color: kSecondaryColor,
                                borderType: BorderType.RRect,
                                strokeWidth: 1.5,
                                radius: const Radius.circular(10),
                                padding: const EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      fillColor: kWhiteColor,
                                      hintText: 'Allotted Amount',
                                      hintStyle:
                                          TextStyle(color: kSecondaryColor),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kHeight20,
                          ],
                        ),

                        kHeight20,
                        ValueListenableBuilder(
                          valueListenable: addMoreEnabled,
                          builder: (context, isEnabled, _) {
                            if (isEnabled == false) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    addMoreEnabled.value =
                                        !addMoreEnabled.value;
                                    scrollController.jumpTo(
                                      cons.maxHeight * 0.8,
                                    );
                                  },
                                  icon: const Icon(Icons.add_circle),
                                  label: const Text(
                                    'Click to add more info',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kDarkGreyButtonColor)),
                                ),
                              );
                            } else {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    addMoreEnabled.value =
                                        !addMoreEnabled.value;
                                  },
                                  icon: const Icon(Icons.remove_circle),
                                  label: const Text(
                                    'Click to add more info',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kButtonRedColor)),
                                ),
                              );
                            }
                          },
                        ),
                        kHeight20
                      ])),

                  // ---------------------------------------------------- more info
                  kHeight10,
                  ValueListenableBuilder(
                      valueListenable: addMoreEnabled,
                      builder: (context, isEnabled, _) {
                        return isEnabled == true
                            ? Container(
                                width: cons.maxWidth,
                                constraints: BoxConstraints(
                                    minHeight: cons.maxHeight * 0.1,
                                    maxHeight: double.infinity),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kpadding15),
                                decoration: const BoxDecoration(
                                  color: Color(0x1CA6A7A8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kHeight20,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'Service  ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 22,
                                                        color: kDarkGreyColor),
                                                children: [
                                                  TextSpan(
                                                    text: 'Within ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 22,
                                                            color:
                                                                kPrimaryColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: '15 January 2023  ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: kDarkGreyColor),
                                                children: [
                                                  TextSpan(
                                                    text: '- ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color:
                                                                kPrimaryColor),
                                                  ),
                                                  TextSpan(
                                                    text: '30 March 2023',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color:
                                                                kDarkGreyColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        kWidth15,
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: kWhiteColor),
                                          child: const Icon(
                                            Icons.calendar_month_outlined,
                                            color: kDarkGreyColor,
                                            size: 35,
                                          ),
                                        ),
                                        kWidth5,
                                      ],
                                    ),
                                    kHeight15,
                                    DashedLineGenerator(
                                        width: width * 0.8,
                                        color: kDottedBorder),
                                    kHeight15,
                                    const CustomTextField(
                                      fillColor: kWhiteColor,
                                      hintText: 'Landmarks near your Agent',
                                    ),
                                    kHeight20,
                                    const CustomTextField(
                                      fillColor: kWhiteColor,
                                      hintText: 'Website link of your Agent',
                                    ),
                                    kHeight20,
                                  ],
                                ),
                              )
                            : const SizedBox();
                      })
                ]));
          },
        ),
        //  bottom continue button
        bottomNavigationBar: SizedBox(
            width: double.infinity,
            height: height * 0.12,
            child: const Padding(
              padding: EdgeInsets.only(
                  left: kpadding20,
                  right: kpadding20,
                  bottom: kpadding20,
                  top: kpadding10),
              child: ButtonWithRightSideIcon(onPressed: null //(){},//
                  ),
            )));
  }
}
