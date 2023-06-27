import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:need_in_choice/utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dropdown_list_items.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../widgets_refactored/circular_back_button.dart';
import '../../../widgets_refactored/condinue_button.dart';
import '../../../widgets_refactored/custom_dropdown_button.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import '../../../widgets_refactored/dotted_border_textfield.dart';
import '../building_sale/collect_ad_details.dart';

class HouseVillaRentScreen extends StatelessWidget {
  const HouseVillaRentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ScrollController scrollController = ScrollController();
    String propertyArea = RealEstateDropdownList.propertyArea.first;
    String buildupArea = RealEstateDropdownList.buildupArea.first;
    String? listedBy;
    String? facing;
    String carpetArea = RealEstateDropdownList.carpetArea.first;
    String? constructionStatus;
    String? furnishing;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: kpadding10),
            child: SizedBox(
              height: height*0.09,
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
                      'House | Villa',
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
                                    width*0.04),
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
                    minHeight: cons.maxHeight,
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
                        height: height*0.45,
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
                              hintText: 'Eg Kh',
                              suffixIcon: kRequiredAsterisk,
                            ),
                            kHeight15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: cons.maxWidth * 0.435,
                                  child: CustomTextField(
                                      hintText: 'Eg 3',
                                      onTapOutside: (event) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      suffixIcon: const DarkTextChip(text: 'Bedroom'),
                                      ),
                                ),
                                SizedBox(
                                  width: cons.maxWidth * 0.435,
                                  child: CustomTextField(
                                    hintText: 'Eg 3',
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    suffixIcon: const DarkTextChip(text: 'Bathroom'),
                                  ),
                                ),
                              ],
                            ),
                            kHeight15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: cons.maxWidth * 0.435,
                                  child: CustomTextField(
                                    hintText: 'Property Area',
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    suffixIcon: CustomDropDownButton(
                                      initialValue: propertyArea,
                                      itemList: RealEstateDropdownList.propertyArea,
                                      onChanged: (String? value) {
                                        propertyArea = value!;
                                      },
                                    ),
                                    // focusNode: ,
                                  ),
                                ),
                                SizedBox(
                                  width: cons.maxWidth * 0.435,
                                  child: CustomTextField(
                                    hintText: 'Buildup Area',
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    suffixIcon: CustomDropDownButton(
                                      initialValue: buildupArea,
                                      itemList: RealEstateDropdownList.buildupArea,
                                      onChanged: (String? value) {
                                        buildupArea = value!;
                                      },
                                    ),
                                    // focusNode: ,
                                  ),
                                ),
                              ],
                            ),
                            kHeight10,
                            SizedBox(
                              height: height*0.08,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.spaceEvenly,
                                runAlignment: WrapAlignment.center,
                                children: [
                                  CustomDropDownButton(
                                    initialValue: listedBy,
                                    hint: Text(
                                      'Listed by',
                                      style: TextStyle(
                                          color: kWhiteColor.withOpacity(0.7)),
                                    ),
                                    maxWidth: width*0.27,
                                    itemList: RealEstateDropdownList.listedBy,
                                    onChanged: (String? value) {
                                      listedBy = value!;
                                    },
                                  ),
                                  CustomDropDownButton(
                                    initialValue: facing,
                                    hint: Text(
                                      'Facing',
                                      style: TextStyle(
                                          color: kWhiteColor.withOpacity(0.7)),
                                    ),
                                    maxWidth: width*0.27,
                                    itemList: RealEstateDropdownList.facing,
                                    onChanged: (String? value) {
                                      facing = value!;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      DashedLineGenerator(width: cons.maxWidth - 60),
                      kHeight20,
                      DottedBorder(
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
                              hintText: 'Monthly Rent',
                              hintStyle: TextStyle(color: kSecondaryColor),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      kHeight20,
                      DottedBorder(
                        dashPattern: const [3, 2],
                        color: kGreyColor,
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
                              hintText: 'Security Deposit',
                              hintStyle: TextStyle(color: kGreyColor),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
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
                // ---------------------------------------------------- more info
                kHeight10,
                ValueListenableBuilder(
                    valueListenable: addMoreEnabled,
                    builder: (context, isEnabled, _) {
                      return isEnabled == true
                          ? Container(
                              width: cons.maxWidth,
                              constraints: BoxConstraints(
                                  minHeight: cons.maxHeight * 0.6,
                                  maxHeight: double.infinity),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kpadding15),
                              decoration: const BoxDecoration(
                                color: Color(0x1CA6A7A8),
                              ),
                              child: Column(
                                children: [
                                  kHeight20,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: cons.maxWidth * 0.435,
                                        child: CustomTextField(
                                          hintText: 'Road Width',
                                          fillColor: kWhiteColor,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          suffixIcon: CustomDropDownButton(
                                            initialValue: carpetArea,
                                            itemList: RealEstateDropdownList.carpetArea,
                                            onChanged: (String? value) {
                                              carpetArea = value!;
                                            },
                                          ),
                                          // focusNode: ,
                                        ),
                                      ),
                                      SizedBox(
                                        width: cons.maxWidth * 0.435,
                                        child: CustomTextField(
                                          hintText: 'Carpet Area',
                                          fillColor: kWhiteColor,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          suffixIcon: CustomDropDownButton(
                                            initialValue: carpetArea,
                                            itemList: RealEstateDropdownList.carpetArea,
                                            onChanged: (String? value) {
                                              carpetArea = value!;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  kHeight15,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: cons.maxWidth * 0.35,
                                        child: CustomTextField(
                                          hintText: 'Eg 3',
                                          fillColor: kWhiteColor,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          suffixIcon: const DarkTextChip(text: 'Parking'),
                                        ),
                                      ),
                                      CustomDropDownButton(
                                        initialValue: constructionStatus,
                                        hint: Text(
                                          "Bachelor's",
                                          style: TextStyle(
                                              color:
                                                  kWhiteColor.withOpacity(0.7)),
                                        ),
                                        itemList: RealEstateDropdownList.constructionStatus,
                                        maxWidth: width*0.26,
                                        onChanged: (String? value) {
                                          constructionStatus = value!;
                                        },
                                      ),
                                      CustomDropDownButton(
                                        initialValue: furnishing,
                                        hint: Text(
                                          'furnishing',
                                          style: TextStyle(
                                              color:
                                                  kWhiteColor.withOpacity(0.7)),
                                        ),
                                        itemList: RealEstateDropdownList.furnishing,
                                        maxWidth: width*0.26,
                                        onChanged: (String? value) {
                                          furnishing = value!;
                                        },
                                      )
                                    ],
                                  ),
                                  kHeight15,
                                  const CustomTextField(
                                    hintText: 'Landmarks near your Villa',
                                    fillColor: kWhiteColor,
                                  ),
                                  kHeight10,
                                  const CustomTextField(
                                    fillColor: kWhiteColor,
                                    hintText: 'Website link of your Villa',
                                  ),
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
        height: height*0.09,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: ButtonWithRightSideIcon(
            onPressed: null //(){},//
          ),
        ),
      ),
    );
  }
}
