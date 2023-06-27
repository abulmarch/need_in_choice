import 'package:flutter/material.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dropdown_list_items.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../widgets_refactored/circular_back_button.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dotted_border_textfield.dart';
import '../../../widgets_refactored/condinue_button.dart';
import '../../../widgets_refactored/custom_dropdown_button.dart';
import '../../../widgets_refactored/image_upload_doted_circle.dart';




ValueNotifier<bool> addMoreEnabled = ValueNotifier(false);

class CommercialBuildingForSale extends StatelessWidget {
  const CommercialBuildingForSale({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    String propertyArea = RealEstateDropdownList.propertyArea.first;
    String buildupArea = RealEstateDropdownList.buildupArea.first;
    String? saleType;
    String? listedBy;
    String? facing;

    String carpetArea = RealEstateDropdownList.carpetArea.first;
    String? constructionStatus;
    String? furnishing;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: kWhiteColor,
      // scrolling sub-cattegory
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: kpadding10),
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // top back button
                  Padding(
                    padding: const EdgeInsets.only(left: 2, bottom: 20),
                    child: CircularBackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => EAuctionLandScreen(),));
                      },
                      size: const Size(45, 45),
                    ),
                  ),
                  // scrolling category
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: building4saleCommercial.length,
                      itemBuilder: (context, index) => SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kDisabledBackground,
                                shape: BoxShape.circle,
                                border: building4saleCommercial[index]
                                                ['cat_name']!
                                            .toLowerCase() ==
                                        'restaurant'
                                    ? Border.all(color: kSecondaryColor)
                                    : null,
                              ),
                              child: Image.asset(
                                building4saleCommercial[index]['cat_img']!,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Text(
                              building4saleCommercial[index]['cat_name']!
                                  .toLowerCase(),
                              style: const TextStyle(
                                  fontSize: 10, color: kPrimaryColor, height: 1
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
          // double keyBoardHeight = 0; //MediaQuery.of(context).viewInsets.bottom;
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
                                building4saleCommercial[0]
                                    ['cat_name']!, //'Restaurant',
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
                                      width: building4saleCommercial[0]
                                                  ['cat_name']!
                                              .length *
                                          10),
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
                        height: 250,
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
                            kHeight5,
                            SizedBox(
                              height: 60,
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
                                          color: kWhiteColor.withOpacity(0.7)),
                                    ),
                                    maxWidth: 100,
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
                                          color: kWhiteColor.withOpacity(0.7)),
                                    ),
                                    maxWidth: 100,
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
                                          color: kWhiteColor.withOpacity(0.7)),
                                    ),
                                    maxWidth: 100,
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
                      const DottedBorderTextField(
                        hintText: 'Ads Price',
                      ),
                      kHeight20,
                      ValueListenableBuilder(
                        valueListenable: addMoreEnabled,
                        builder: (context, isEnabled, _) {
                          if (isEnabled == false) {
                            return AddMoreInfoButton(
                              onPressed: () {
                                addMoreEnabled.value = !addMoreEnabled.value;
                                scrollController.jumpTo(
                                  cons.maxHeight * 0.8,
                                );
                              },
                            );
                          } else {
                            return AddMoreInfoButton(
                              onPressed: () {
                                addMoreEnabled.value = !addMoreEnabled.value;
                              },
                              backgroundColor: kButtonRedColor,
                              icon: const Icon(Icons.remove_circle),
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
                                  kHeight20,
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
                                          suffixIcon: const DarkTextChip(text: 'Total Floors'),
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
                                          // focusNode: ,
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
                                          fillColor: kWhiteColor,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          suffixIcon: const DarkTextChip(text: 'Floor no'),
                                          // suffixIcon: Container(
                                          //   alignment: Alignment.center,
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 6, vertical: 8),
                                          //   decoration: const BoxDecoration(
                                          //     color: kDarkGreyButtonColor,
                                          //     borderRadius: BorderRadius.all(
                                          //         Radius.circular(30)),
                                          //   ),
                                          //   constraints: const BoxConstraints(
                                          //     minWidth: 70,
                                          //     maxWidth: 70,
                                          //   ),
                                          //   child: const Text(
                                          //     'Floor no',
                                          //     style: TextStyle(
                                          //         color: kWhiteColor,
                                          //         fontSize: 12),
                                          //   ),
                                          // ),
                                          // focusNode: ,
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
                                  kHeight10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: cons.maxWidth * 0.435,
                                        child: 
                                        CustomTextField(
                                          hintText: 'Eg 3',
                                          fillColor: kWhiteColor,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          suffixIcon: const DarkTextChip(text: 'Age Of Building'),
                                          // focusNode: ,
                                        ),
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
                                  SizedBox(
                                    width: double.infinity,
                                    height: 65,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                          maxWidth: 145,
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
                                          maxWidth: 130,
                                          onChanged: (String? value) {
                                            furnishing = value!;
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  kHeight5,
                                  const CustomTextField(
                                      hintText: 'Land marks near your Restaurant',
                                      fillColor: kWhiteColor,
                                      ),
                                  kHeight15,
                                  const CustomTextField(
                                      fillColor: kWhiteColor,
                                      hintText: 'Website link of your Restaurant',
                                      ),
                                  kHeight15,
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
        height: 90,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: ButtonWithRightSideIcon(
            onPressed: () {
              Navigator.pushNamed(context, adConfirmScreen);
            }
          ),
        ),
      ),
    );
  }
}



