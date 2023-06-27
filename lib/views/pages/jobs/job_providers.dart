import 'package:dotted_border/dotted_border.dart';
import 'package:need_in_choice/views/widgets_refactored/dropdown_textfield.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/level4_category_data.dart';
import 'package:flutter/material.dart';
import '../../../utils/dropdown_list_items.dart';
import '../../widgets_refactored/circular_back_button.dart';
import '../../widgets_refactored/condinue_button.dart';
import '../../widgets_refactored/custom_text_field.dart';
import '../../widgets_refactored/dashed_line_generator.dart';
import '../real_estate/building_sale/collect_ad_details.dart';

class JobProviders extends StatelessWidget {
  const JobProviders({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    String? employment;
    String? work;
    String? ageCategory;
    String? gender;

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
                            'JOBS PROVIDERS',
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
                            SizedBox(
                              height: height * .26,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Institution Name',
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
                                    hintText: 'Eg Job Category',
                                  ),
                                ],
                              ),
                            ),
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
                                    text: 'Qualification',
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
                            kHeight10,
                            const CustomTextField(
                              maxLines: 5,
                              hintText: 'Eg Qualification Details & Skills',
                            ),
                            kHeight15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    kHeight20,
                                    kHeight20,
                                    RichText(
                                      text: TextSpan(
                                        text: 'Job\n',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                                color: kLightGreyColor),
                                        children: [
                                          TextSpan(
                                            text: 'Details',
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
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: height * 0.06,
                                          width: width * 0.36,
                                          child: DottedBorder(
                                            dashPattern: const [3, 2],
                                            color: kSecondaryColor,
                                            borderType: BorderType.RRect,
                                            strokeWidth: 1.5,
                                            radius: const Radius.circular(10),
                                            padding: const EdgeInsets.all(2),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  fillColor: kWhiteColor,
                                                  hintText: 'Starting salary',
                                                  hintStyle: TextStyle(
                                                      color: kSecondaryColor),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        kWidth10,
                                        SizedBox(
                                          height: height * 0.06,
                                          width: width * 0.31,
                                          child: DottedBorder(
                                            dashPattern: const [3, 2],
                                            color: kGreyColor,
                                            borderType: BorderType.RRect,
                                            strokeWidth: 1.5,
                                            radius: const Radius.circular(10),
                                            padding: const EdgeInsets.all(2),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  fillColor: kWhiteColor,
                                                  hintText: 'Final salary',
                                                  hintStyle: TextStyle(
                                                      color: kGreyColor),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    kHeight15,
                                    CustomDropdownText(
                                      width: width * 0.24,
                                      initialValue: employment,
                                      itemList: JobsDropDownList.employmentType,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        }
                                        return null;
                                      },
                                      onChanged: (String? value) {
                                        employment = value!;
                                      },
                                      hint: Text(
                                        'Employment Type',
                                        style: TextStyle(
                                            color: kGreyColor.withOpacity(0.7),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            kHeight15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomDropdownText(
                                  width: width * 0.40,
                                  initialValue: work,
                                  itemList: JobsDropDownList.workExperience,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                  onChanged: (String? value) {
                                    work = value!;
                                  },
                                  hint: Text(
                                    'Work Experience',
                                    style: TextStyle(
                                        color: kGreyColor.withOpacity(0.7),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                CustomDropdownText(
                                  width: width * 0.24,
                                  initialValue: ageCategory,
                                  itemList: JobsDropDownList.ageCategory,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                  onChanged: (String? value) {
                                    ageCategory = value!;
                                  },
                                  hint: Text(
                                    'Age Category',
                                    style: TextStyle(
                                        color: kGreyColor.withOpacity(0.7),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                CustomDropdownText(
                                  width: width * 0.24,
                                  initialValue: gender,
                                  itemList: JobsDropDownList.gender,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                  onChanged: (String? value) {
                                    gender = value!;
                                  },
                                  hint: Text(
                                    'Sex',
                                    style: TextStyle(
                                        color: kGreyColor.withOpacity(0.7),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            kHeight20,
                            Center(
                                child: DashedLineGenerator(
                              width: width * .8,
                              color: kDottedBorder,
                            )),
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
                                  children: const [
                                    kHeight20,
                                    CustomTextField(
                                      fillColor: kWhiteColor,
                                      hintText: 'Email id for Resumes',
                                    ),
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
