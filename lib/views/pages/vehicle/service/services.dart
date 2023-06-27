import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../widgets_refactored/circular_back_button.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import '../../../widgets_refactored/condinue_button.dart';
import 'package:flutter/material.dart';
import '../../real_estate/building_sale/collect_ad_details.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

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
            padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: kpadding10),
            child: SizedBox(
              height: height * .08,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                      'Services',
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
                          width:
                              building4saleCommercial[0]['cat_name']!.length *
                                  width *
                                  0.04,
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
          //  double keyBoardHeight = 0;
          return SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: kpadding15),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: cons.maxHeight * 0.8,
                    maxHeight: double.infinity,
                  ),
                  child: Column(
                    children: [
                      kHeight10,
                      const CustomTextField(
                          hintText: 'Ads name | Title',
                          suffixIcon: kRequiredAsterisk),
                      kHeight15,
                      const CustomTextField(
                          maxLines: 5,
                          hintText: 'Description',
                          suffixIcon: kRequiredAsterisk),
                      kHeight20,
                      SizedBox(
                        height: height * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Brand Name',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: kLightGreyColor),
                            ),
                            kHeight5,
                            const CustomTextField(
                              hintText: 'Eg Bajaj',
                              suffixIcon: kRequiredAsterisk,
                            ),
                            kHeight15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Your\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                            color: kLightGreyColor),
                                    children: [
                                      TextSpan(
                                        text: 'Services',
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * 0.05,
                                      child: CustomTextField(
                                        width: width * 0.65,
                                        hintText: 'Services 1',
                                      ),
                                    ),
                                    kHeight10,
                                    SizedBox(
                                      height: height * 0.05,
                                      child: CustomTextField(
                                          width: width * 0.65,
                                          hintText: 'Services 2'),
                                    ),
                                    kHeight10,
                                    SizedBox(
                                      height: height * .05,
                                      child: CustomTextField(
                                        width: width * 0.65,
                                        hintText: 'Services 3',
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: width * 0.08,
                                          height: height * 0.08,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kPrimaryColor,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: kWhiteColor,
                                          ),
                                        ),
                                        kWidth10,
                                        RichText(
                                          text: TextSpan(
                                            text: 'Add More\n',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: kBlackColor),
                                            children: [
                                              TextSpan(
                                                text: 'Services',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: kPrimaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            kHeight20,
                            Center(
                                child: DashedLineGenerator(
                              width: width * .9,
                              color: kDottedBorder,
                            )),
                            kHeight20,
                          ],
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: addMoreEnabled,
                        builder: (context, isEnabled, _) {
                          if (isEnabled == false) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  addMoreEnabled.value = !addMoreEnabled.value;
                                  scrollController.jumpTo(
                                    cons.maxHeight * 0.8,
                                  );
                                },
                                icon: const Icon(Icons.add_circle),
                                label: const Text(
                                  'Click to add more info',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
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
                                  addMoreEnabled.value = !addMoreEnabled.value;
                                },
                                icon: const Icon(Icons.remove_circle),
                                label: const Text(
                                  'Click to add more info',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
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
                    ],
                  ),
                ),
                kHeight10,
                ValueListenableBuilder(
                    valueListenable: addMoreEnabled,
                    builder: (context, isEnabled, _) {
                      return isEnabled == true
                          ? Container(
                              width: cons.maxWidth,
                              constraints: BoxConstraints(
                                  minHeight: cons.maxHeight * 0.3,
                                  maxHeight: double.infinity),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kpadding15),
                              decoration: const BoxDecoration(
                                color: Color(0x1CA6A7A8),
                              ),
                              child: Column(
                                children: const [
                                  kHeight15,
                                  CustomTextField(
                                    fillColor: kWhiteColor,
                                    hintText: 'Landmark near your Brand',
                                  ),
                                  kHeight10,
                                  CustomTextField(
                                    fillColor: kWhiteColor,
                                    hintText: 'Website link of your Brand',
                                  ),
                                  kHeight20
                                ],
                              ),
                            )
                          : const SizedBox();
                    })
              ],
            ),
          );
        },
      ),
      //  bottom continue button
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: height * 0.09,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: ButtonWithRightSideIcon(onPressed: null //(){},//
              ),
        ),
      ),
    );
  }
}
