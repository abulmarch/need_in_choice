import 'package:dotted_border/dotted_border.dart';

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

class CycleScreen extends StatelessWidget {
  const CycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                      'Cycles',
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
                        height: height * 0.42,
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
                            CustomTextField(
                              width: width * 0.55,
                              hintText: 'Model Number',
                            ),
                            kHeight15,
                            CustomTextField(
                              width: width * 0.6,
                              hintText: 'Showroom Name',
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
