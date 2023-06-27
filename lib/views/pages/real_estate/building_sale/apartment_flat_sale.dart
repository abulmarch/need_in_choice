import 'package:dotted_border/dotted_border.dart';
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

class ApartmentSaleScreen extends StatelessWidget {
  const ApartmentSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ScrollController scrollController = ScrollController();
    String buildupArea = RealEstateDropdownList.buildupArea.first;
    String? saleType;
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
              padding: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: kpadding10),
              child: SizedBox(
                height: height*0.09,
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
                            'Apartment & Flat',
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
                                      width*.055),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                      initialValue: saleType,
                                      hint: Text(
                                        'sale type',
                                        style: TextStyle(
                                            color:
                                                kWhiteColor.withOpacity(0.7)),
                                      ),
                                      maxWidth: width*0.27,
                                      itemList: RealEstateDropdownList.saleType,
                                      onChanged: (String? value) {
                                        saleType = value!;
                                      },
                                    ),
                                    CustomDropDownButton(
                                      initialValue: listedBy,
                                      hint: Text(
                                        'listed by',
                                        style: TextStyle(
                                            color:
                                                kWhiteColor.withOpacity(0.7)),
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
                                        'facing',
                                        style: TextStyle(
                                            color:
                                                kWhiteColor.withOpacity(0.7)),
                                      ),
                                      maxWidth: width*0.25,
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
                                hintText: 'Ads Price',
                                hintStyle: TextStyle(color: kSecondaryColor),
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
                                                FocusScope.of(context)
                                                    .unfocus();
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
                                                FocusScope.of(context)
                                                    .unfocus();
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
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              suffixIcon: const DarkTextChip(text: 'Age of Building'),
                                            ),
                                        ),
                                        SizedBox(
                                            width: cons.maxWidth * 0.205,
                                            child: const ImageUploadDotedCircle(
                                              color: kPrimaryColor,
                                              text: 'Floor\nPlan',
                                            )),
                                        kWidth20
                                      ],
                                    ),
                                    kHeight5,
                                    SizedBox(
                                      width: double.infinity,
                                      height: height*0.08,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomDropDownButton(
                                            initialValue: constructionStatus,
                                            hint: Text(
                                              'construction status',
                                              style: TextStyle(
                                                  color: kWhiteColor
                                                      .withOpacity(0.7)),
                                            ),
                                            itemList:
                                                RealEstateDropdownList.constructionStatus,
                                            maxWidth: width*0.44,
                                            onChanged: (String? value) {
                                              constructionStatus = value!;
                                            },
                                          ),
                                          CustomDropDownButton(
                                            initialValue: furnishing,
                                            hint: Text(
                                              'furnishing',
                                              style: TextStyle(
                                                  color: kWhiteColor
                                                      .withOpacity(0.7)),
                                            ),
                                            itemList: RealEstateDropdownList.furnishing,
                                            maxWidth: width*0.35,
                                            onChanged: (String? value) {
                                              furnishing = value!;
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    kHeight15,
                                    SizedBox(
                                      height: height*.4,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Amenities ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontSize: 18,
                                                  color: kPrimaryColor),
                                              children: [
                                                TextSpan(
                                                  text: 'Below',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 18,
                                                      color: kGreyColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: height*0.33,
                                            decoration: BoxDecoration(
                                              color: kLightGreyColor
                                                  .withOpacity(0.3),
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Wrap(
                                                    spacing: 7.0,
                                                    runSpacing: 8.0,
                                                    children:  [
                                                      AmenitiesContainer(
                                                        text: 'Wifi',
                                                        color: kWhiteColor,
                                                        width: width*0.15,
                                                        textcolor: kGreyColor,
                                                      ),
                                                      AmenitiesContainer(
                                                        text:
                                                        'basement car parking',
                                                        color: kWhiteColor,
                                                        width: width*0.5,
                                                        textcolor: kGreyColor,
                                                      ),
                                                      AmenitiesContainer(
                                                        text: 'Lift',
                                                        color: kWhiteColor,
                                                        width: width*0.15,
                                                        textcolor: kGreyColor,
                                                      ),
                                                      AmenitiesContainer(
                                                        text: 'GYM',
                                                        color: kSecondaryColor,
                                                        width: width*0.15,
                                                        textcolor: kWhiteColor,
                                                      ),
                                                      AmenitiesContainer(
                                                        text: 'Gas Pipeline',
                                                        color: kWhiteColor,
                                                        width: width*.35,
                                                        textcolor: kGreyColor,
                                                      ),
                                                      AmenitiesContainer(
                                                        text: 'Jogging Track',
                                                        color: kSecondaryColor,
                                                        width: width*.33,
                                                        textcolor: kWhiteColor,
                                                      ),
                                                      AmenitiesContainer(
                                                        text: 'intercom',
                                                        color: kWhiteColor,
                                                        width: width*.33,
                                                        textcolor: kGreyColor,
                                                      ),
                                                      AmenitiesContainer(
                                                        text: 'fire safety',
                                                        color: kSecondaryColor,
                                                        width: width*.33,
                                                        textcolor: kWhiteColor,
                                                      ),
                                                      AmenitiesContainer(
                                                        text:
                                                        'rain water harvest',
                                                        color: kWhiteColor,
                                                        width: width*.39,
                                                        textcolor: kGreyColor,
                                                      ),
                                                      AmenitiesContainer(
                                                        text: 'covered parking',
                                                        color: kWhiteColor,
                                                        width: width*.35,
                                                        textcolor: kGreyColor,
                                                      ),
                                                    ],
                                                  ),
                                                  kHeight20,
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'View ',
                                                              style: Theme.of(
                                                                  context)
                                                                  .textTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  fontSize:
                                                                  16,
                                                                  color:
                                                                  kGreyColor),
                                                              children: [
                                                                TextSpan(
                                                                  text: 'More',
                                                                  style: Theme.of(
                                                                      context)
                                                                      .textTheme
                                                                      .headlineSmall
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                    fontSize:
                                                                    16,
                                                                    color:
                                                                    kPrimaryColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Center(
                                                            child: SizedBox(
                                                              width: width*0.21,
                                                              child: const Divider(
                                                                thickness: 2,
                                                                color:
                                                                kWhiteColor,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      kWidth10,
                                                      Container(
                                                        width: width*0.07,
                                                        height: height*0.07,
                                                        decoration:
                                                        const BoxDecoration(
                                                          shape:
                                                          BoxShape.circle,
                                                          color: kWhiteColor,
                                                        ),
                                                        child: const Icon(
                                                          Icons
                                                              .keyboard_arrow_down_outlined,
                                                          color: kPrimaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    kHeight5,
                                    const CustomTextField(
                                      hintText:
                                          'Land marks near your Restaurant',
                                      fillColor: kWhiteColor,
                                    ),
                                    kHeight10,
                                    const CustomTextField(
                                      fillColor: kWhiteColor,
                                      hintText:
                                          'Website link of your Restaurant',
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
        bottomNavigationBar: SizedBox(
            width: double.infinity,
            height: height*0.12,
            child: const Padding(
              padding:
                  EdgeInsets.only(left: kpadding20, right: kpadding20, bottom: kpadding20, top: kpadding10),
              child: ButtonWithRightSideIcon(
                onPressed: null //(){},//
              ),
            )));
  }
}

class AmenitiesContainer extends StatelessWidget {
  const AmenitiesContainer({
    super.key,
    required this.text,
    required this.width,
    required this.color,
    required this.textcolor,
  });

  final String text;
  final double width;
  final Color color;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: textcolor),
      )),
    );
  }
}
