import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../widgets_refactored/circular_back_button.dart';
import '../../../widgets_refactored/condinue_button.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import '../../../widgets_refactored/dotted_border_textfield.dart';
import '../../../widgets_refactored/brand_name_button.dart';

class RealEstateAgencyScreen extends StatelessWidget {
  const RealEstateAgencyScreen({super.key});

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
              height: height*.08,
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
                      'Real Estate Agency',
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
                                    width*0.055),
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
          return SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: kpadding15),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: cons.maxHeight * 0.5,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: cons.maxWidth * 0.435,
                            child: CustomTextField(
                                hintText: 'Eg 3 Yrs',
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                                suffixIcon: const DarkTextChip(text: 'Work Experience'),
                                ),
                          ),
                          SizedBox(
                            width: cons.maxWidth * 0.435,
                            child: CustomTextField(
                              hintText: 'Eg 5 Km',
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              suffixIcon: const DarkTextChip(text: 'Area Covered'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                kHeight10,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: kpadding15),
                  width: double.infinity,
                  color: kButtonColor,
                  constraints: BoxConstraints(
                    minHeight: cons.maxHeight * 0.5,
                    maxHeight: double.infinity,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kHeight20,
                        RichText(
                          text: TextSpan(
                            text: 'Work ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: kDarkGreyColor),
                            children: [
                              TextSpan(
                                text: 'Time',
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
                          height: height*0.035,
                          width: width*0.41,
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
                          height: height*0.09,
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
                              kHeight5,
                            ],
                          ),
                        ),
                        DashedLineGenerator(width: width*.9),
                        kHeight15,
                        const CustomTextField(
                          hintText: 'Landmarks near your Agency',
                          fillColor: kWhiteColor,
                        ),
                        kHeight10,
                        const CustomTextField(
                          fillColor: kWhiteColor,
                          hintText: 'Website link of your Agency',
                        ),
                        kHeight20
                      ]),
                ),
              ],
            ),
          );
        },
      ),
      //  bottom continue button
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: height*0.09,
        child: const  Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: ButtonWithRightSideIcon(
            onPressed: null //(){},//
          ),
        ),
      ),
    );
  }
}
