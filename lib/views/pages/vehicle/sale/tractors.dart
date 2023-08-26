import 'package:dotted_border/dotted_border.dart';

import '../../../../config/theme/screen_size.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dropdown_list_items.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../widgets_refactored/circular_back_button.dart';
import '../../../widgets_refactored/custom_dropdown_button.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import '../../../widgets_refactored/condinue_button.dart';
import 'package:flutter/material.dart';

class TractorScreen extends StatelessWidget {
  const TractorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final height = ScreenSize.size.height;
    final width = ScreenSize.size.width;
    String? fuel;
    String? listedBy;
    String? finance;
    String? driven;
    String? transmission;

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
                      'Tractors',
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
                                  0.045,
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
                        height: height * 0.6,
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
                            CustomTextField(
                              width: width * 0.65,
                              hintText: 'Eg Bajaj',
                              suffixIcon: kRequiredAsterisk,
                            ),
                            kHeight15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextField(
                                  width: width * 0.55,
                                  hintText: 'Model Number',
                                ),
                                SizedBox(
                                  width: width * 0.35,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'HP',
                                        hintStyle: TextStyle(
                                            color:
                                                kPrimaryColor.withOpacity(0.7),
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ),
                              ],
                            ),
                            kHeight5,
                            SizedBox(
                              height: height * 0.08,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 1,
                                runSpacing: 3,
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                children: [
                                  CustomDropDownButton(
                                    initialValue: fuel,
                                    hint: Text(
                                      'Fuel',
                                      style: TextStyle(
                                          color: kWhiteColor.withOpacity(0.7)),
                                    ),
                                    maxWidth: width * 0.165,
                                    itemList: VehicleDropDownList.fuel,
                                    onChanged: (String? value) {
                                      fuel = value!;
                                    },
                                  ),
                                  CustomDropDownButton(
                                    initialValue: listedBy,
                                    hint: Text(
                                      'Listed By',
                                      style: TextStyle(
                                          color: kWhiteColor.withOpacity(0.7)),
                                    ),
                                    maxWidth: width * 0.235,
                                    itemList: VehicleDropDownList.listedBySale,
                                    onChanged: (String? value) {
                                      listedBy = value!;
                                    },
                                  ),
                                  CustomDropDownButton(
                                    initialValue: finance,
                                    hint: Text(
                                      'Finance',
                                      style: TextStyle(
                                          color: kWhiteColor.withOpacity(0.7)),
                                    ),
                                    maxWidth: width * 0.23,
                                    itemList: VehicleDropDownList.finance,
                                    onChanged: (String? value) {
                                      finance = value!;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            kHeight5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextField(
                                  width: width * 0.6,
                                  hintText: 'Showroom Name',
                                ),
                                CustomTextField(
                                  width: width * 0.3,
                                  hintText: 'RTO Code',
                                ),
                              ],
                            ),
                            kHeight15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextField(
                                  width: width * 0.3,
                                  hintText: 'No of Cylinders',
                                ),
                                CustomTextField(
                                  width: width * 0.3,
                                  hintText: 'Lifting Capacity',
                                ),
                                CustomTextField(
                                  width: width * 0.3,
                                  hintText: 'Driven',
                                  suffixIcon: CustomDropDownButton(
                                    initialValue: driven,
                                    hint: Text(
                                      'km',
                                      style: TextStyle(
                                          color: kWhiteColor.withOpacity(0.7)),
                                    ),
                                    maxWidth: width * 0.15,
                                    itemList: VehicleDropDownList.driven,
                                    onChanged: (String? value) {
                                      driven = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            kHeight15,
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: kpadding20 * 4, right: kpadding20 * 4),
                              child: CustomDropDownButton(
                                initialValue: transmission,
                                hint: Text(
                                  'Transmission',
                                  style: TextStyle(
                                      color: kWhiteColor.withOpacity(0.7)),
                                ),
                                maxWidth: width * 0.2,
                                itemList: VehicleDropDownList.transmission,
                                onChanged: (String? value) {
                                  transmission = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                          child: DashedLineGenerator(
                        width: width * .8,
                        color: kDottedBorder,
                      )),
                      kHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NewUsedContainer(
                            height: height,
                            width: width,
                            text: 'Used',
                          ),
                          SizedBox(
                            height: height * 0.07,
                            width: width * 0.7,
                            child: DottedBorder(
                              dashPattern: const [3, 2],
                              color: kSecondaryColor,
                              borderType: BorderType.RRect,
                              strokeWidth: 1.5,
                              radius: const Radius.circular(10),
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    fillColor: kWhiteColor,
                                    hintText: 'Ads Price',
                                    hintStyle:
                                        TextStyle(color: kSecondaryColor),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      kHeight20
                    ],
                  ),
                ),
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
