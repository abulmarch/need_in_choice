
import 'package:flutter/material.dart';
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
import '../../../widgets_refactored/image_upload_doted_circle.dart';
import 'collect_ad_details.dart';

class EAuctionProperty extends StatelessWidget {
  const EAuctionProperty({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ScrollController scrollController = ScrollController();
    String propertyArea = RealEstateDropdownList.propertyArea.first;
    String buildupArea = RealEstateDropdownList.buildupArea.first;
    String carpetArea = RealEstateDropdownList.carpetArea.first;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: kpadding10),
            child: SizedBox(
              height:height*0.09,
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
                      'E-Auction Property',
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
                                    width*0.06),
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
                        height: height*0.47,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Bank ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: kPrimaryColor),
                                children: [
                                  TextSpan(
                                    text: 'Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: kLightGreyColor),
                                  ),
                                ],
                              ),
                            ),
                            kHeight5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                CustomTextField(
                                  width: width*0.44,
                                  hintText: 'Eg Bank Name',
                                ),
                                CustomTextField(
                                  width: width*0.44,
                                  hintText: 'Eg Branch Name',
                                  suffixIcon: kRequiredAsterisk,
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
                            kHeight15,
                            const Spacer(flex: 1),
                            Center(
                                child: DashedLineGenerator(
                                    width: cons.maxWidth - 70)),
                            const Spacer(flex: 1),
                            kHeight15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: height*0.07,
                                  width: width*0.44,
                                  child: const DottedBorderTextField(
                                    color: kSecondaryColor,
                                    hintText: 'Start Price',
                                  ),
                                ),
                                SizedBox(
                                  height: height*0.07,
                                  width: width*0.44,
                                  child: const DottedBorderTextField(
                                    color: kGreyColor,
                                    hintText: 'Pre bid Amount',
                                  )
                                )
                              ],
                            ),
                            kHeight15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: height*0.045,
                                  width: width*0.36,
                                  decoration: BoxDecoration(
                                      color: kGreyColor,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: const Center(
                                      child: Text(
                                        'Bid Start Date',
                                        style: TextStyle(
                                            color: kWhiteColor,
                                            fontWeight: FontWeight.w400),
                                      )),
                                ),
                                Container(
                                  height: height*0.045,
                                  width: width*0.36,
                                  decoration: BoxDecoration(
                                      color: kGreyColor,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: const Center(
                                      child: Text(
                                        'Bid End Date',
                                        style: TextStyle(
                                            color: kWhiteColor,
                                            fontWeight: FontWeight.w400),
                                      )),
                                ),
                              ],
                            ),
                            kHeight15
                          ],
                        ),
                      ),
                      DashedLineGenerator(width: cons.maxWidth - 60),
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
                            minHeight: cons.maxHeight * 0.8,
                            maxHeight: double.infinity),
                        padding: const EdgeInsets.symmetric(
                            horizontal: kpadding15),
                        decoration: const BoxDecoration(
                          color: Color(0x1CA6A7A8),
                        ),
                        child: Column(
                          children: [
                            kHeight15,
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
                            kHeight5,
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: cons.maxWidth * 0.435,
                                  child: CustomTextField(
                                      hintText: 'Eg 3',
                                      fillColor: kWhiteColor,
                                      onTapOutside: (event) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      suffixIcon: const DarkTextChip(text: 'Total Floor'),
                                    ),
                                ),
                                SizedBox(
                                  width: cons.maxWidth * 0.435,
                                  child: CustomTextField(
                                      hintText: 'Eg 3',
                                      fillColor: kWhiteColor,
                                      onTapOutside: (event) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      suffixIcon: const DarkTextChip(text: 'Parking'),
                                  ),
                                ),
                              ],
                            ),
                            kHeight5,
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: cons.maxWidth * 0.435,
                                  child: CustomTextField(
                                      hintText: 'Eg 3',
                                      fillColor: kWhiteColor,
                                      onTapOutside: (event) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      suffixIcon: const DarkTextChip(text: 'Floor Number'),
                                    ),
                                ),
                                SizedBox(
                                  width: cons.maxWidth * 0.435,
                                  child: CustomTextField(
                                      hintText: 'Eg 3',
                                      fillColor: kWhiteColor,
                                      onTapOutside: (event) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      suffixIcon: const DarkTextChip(text: 'Age of Building'),
                                    ),
                                ),
                              ],
                            ),
                            kHeight20,
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                 CustomTextField(
                                  width: width*0.45,
                                  hintText:
                                  'Landmarks near your Property',
                                  fillColor: kWhiteColor,
                                ),
                                SizedBox(
                                    width: cons.maxWidth * 0.435,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: const [
                                        ImageUploadDotedCircle(
                                          color: kPrimaryColor,
                                          text: 'Floor\nPlan',
                                        ),
                                        ImageUploadDotedCircle(
                                          color: kBlackColor,
                                          text: 'Land\nSketch',
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            kHeight15,
                            const CustomTextField(
                              fillColor: kWhiteColor,
                              hintText: 'Website link of your Property',
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


      bottomNavigationBar: const SizedBox(
          width: double.infinity,
          height: 70,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: ButtonWithRightSideIcon(
              onPressed: null //(){},//
          )
        )
      ),
    );
  }
}
