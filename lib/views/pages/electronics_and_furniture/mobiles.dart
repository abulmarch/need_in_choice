import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';
import '../../../../utils/constants.dart';

import '../../../../utils/level4_category_data.dart';
import '../../widgets_refactored/circular_back_button.dart';
import '../../widgets_refactored/condinue_button.dart';
import '../../widgets_refactored/custom_dropdown_button.dart';
import '../../widgets_refactored/custom_text_field.dart';

ValueNotifier<bool> addMoreEnabled = ValueNotifier(false);

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ScrollController scrollController = ScrollController();

    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 90),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: kpadding10),
              child: SizedBox(
                height: height * 0.1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // top back button
                    Padding(
                      padding: const EdgeInsets.only(left: 2, bottom: 20),
                      child: CircularBackButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        size: const Size(45, 45),
                      ),
                    ),
                    // scrolling category
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: mobiles4sale.length,
                        itemBuilder: (context, index) => SizedBox(
                          width: width * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: height * 0.07,
                                width: width * 0.17,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kDisabledBackground,
                                  shape: BoxShape.circle,
                                  border: mobiles4sale[index]['cat_name']!
                                              .toLowerCase() ==
                                          'mobiles'
                                      ? Border.all(color: kSecondaryColor)
                                      : null,
                                ),
                                child: Image.asset(
                                  mobiles4sale[index]['cat_img']!,
                                  height: height * 0.05,
                                  width: width * 0.15,
                                ),
                              ),
                              Text(
                                mobiles4sale[index]['cat_name']!.toLowerCase(),
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: kPrimaryColor,
                                    height: 1
                                    // leadingDistribution: TextLeadingDistribution.proportional

                                    ),
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 1,
                        ),
                      ),
                    ),
                  ],
                ),
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
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: kpadding15),
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: cons.maxHeight,
                      maxHeight: double.infinity,
                    ),
                    child: Column(
                      children: [
                        kHeight10,
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mobiles4sale[0]['cat_name']!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize: 20, color: kPrimaryColor),
                                ),
                                // title arrow underline
                                Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    DashedLineGenerator(
                                      width:
                                          mobiles4sale[0]['cat_name']!.length *
                                              width *
                                              0.035,
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
                          ],
                        ),
                        kHeight20,
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
                          height: height * .26,
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
                              kHeight15,
                              const CustomTextField(
                                hintText: 'Eg Bajaj',
                                suffixIcon: kRequiredAsterisk,
                              ),
                              kHeight15,
                              const CustomTextField(
                                hintText: 'Eg Model Name',
                              ),
                            ],
                          ),
                        ),
                        kHeight20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Product\n',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: kLightGreyColor),
                                children: [
                                  TextSpan(
                                    text: 'Features',
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
                                    width: width * 0.6,
                                    hintText: 'Features 1',
                                  ),
                                ),
                                kHeight10,
                                SizedBox(
                                  height: height * 0.05,
                                  child: CustomTextField(
                                      width: width * 0.6,
                                      hintText: 'Features 2'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                                    fontWeight: FontWeight.w400,
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
                          children: [
                            NewUsedContainer(
                              height: height,
                              width: width,
                              text: 'New',
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
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
                      ],
                    ),
                  ),
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
                                  children: const [
                                    kHeight20,
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
