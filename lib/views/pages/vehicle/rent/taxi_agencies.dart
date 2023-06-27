import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../widgets_refactored/circular_back_button.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import '../../../widgets_refactored/condinue_button.dart';
import 'package:flutter/material.dart';

import '../../../widgets_refactored/brand_name_button.dart';

class TaxiAgencies extends StatelessWidget {
  const TaxiAgencies({super.key});

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
                      'Taxi Agencies',
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
                                  0.05,
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
          //   double keyBoardHeight = 0;
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
                        height: height * 0.66,
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
                              width: width * .8,
                              color: kDottedBorder,
                            )),
                            kHeight20,
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
                                        text: 'Vehicles',
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
                                        hintText: 'Model 1',
                                      ),
                                    ),
                                    kHeight10,
                                    SizedBox(
                                      height: height * 0.05,
                                      child: CustomTextField(
                                          width: width * 0.65,
                                          hintText: 'Model 2'),
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
                                                text: 'Vehicles',
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
                          ],
                        ),
                      ),
                      kHeight20,
                    ],
                  ),
                ),
                Container(
                  width: cons.maxWidth,
                  constraints: BoxConstraints(
                      minHeight: cons.maxHeight * 0.45,
                      maxHeight: double.infinity),
                  padding: const EdgeInsets.symmetric(horizontal: kpadding15),
                  decoration: const BoxDecoration(
                    color: Color(0x1CA6A7A8),
                  ),
                  child: Column(
                    children: [
                      kHeight15,
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kHeight20,
                            RichText(
                              text: TextSpan(
                                text: 'Working ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: kDarkGreyColor),
                                children: [
                                  TextSpan(
                                    text: 'Hours',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                            color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                            kHeight10,
                            Container(
                              height: height * 0.03,
                              width: width * 0.43,
                              decoration: BoxDecoration(
                                  color: kDarkGreyButtonColor,
                                  borderRadius: BorderRadius.circular(25)),
                              child: const Center(
                                  child: Text(
                                '10.00 am to 5.00pm',
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w300),
                              )),
                            ),
                            kHeight15,
                            Container(
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                color: kButtonColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Wrap(
                                    spacing: 7.0,
                                    runSpacing: 8.0,
                                    children: const [
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Mon',
                                      ),
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Tue',
                                      ),
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Wed',
                                      ),
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Thu',
                                      ),
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Fri',
                                      ),
                                      WorkTimeContainer(
                                        color: kLightGreyColor,
                                        textcolor: kLightGreyColor,
                                        text: 'Sun',
                                      ),
                                      WorkTimeContainer(
                                        color: kLightGreyColor,
                                        textcolor: kLightGreyColor,
                                        text: 'Sat',
                                      ),
                                    ],
                                  ),
                                  kHeight15,
                                ],
                              ),
                            ),
                            DashedLineGenerator(
                              width: width * .9,
                              color: kDottedBorder,
                            ),
                            kHeight15,
                            const CustomTextField(
                              hintText: 'Landmarks near your Agencies',
                              fillColor: kWhiteColor,
                            ),
                            kHeight20
                          ]),
                      const CustomTextField(
                        maxLines: 6,
                        fillColor: kWhiteColor,
                        hintText: 'Terms And Conditions',
                      ),
                      kHeight10,
                      const CustomTextField(
                        fillColor: kWhiteColor,
                        hintText: 'Website link of your Agencies',
                      ),
                      kHeight20
                    ],
                  ),
                )
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
