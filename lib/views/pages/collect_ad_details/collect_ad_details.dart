import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';

import '../../../utils/category_and_subcategory_info.dart';
import '../../../utils/constants.dart';
import '../../../utils/dropdown_list_items.dart';
import '../../widgets_refactored/circular_back_button.dart';
import '../../widgets_refactored/custom_text_field.dart';
import 'widgets/condinue_button.dart';
import 'widgets/custom_dropdown_button.dart';
import 'widgets/image_upload_doted_circle.dart';

ValueNotifier<bool> addMoreEnabled = ValueNotifier(false);

class CollectAdDetails extends StatelessWidget {
  const CollectAdDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    String propertyArea = ListItems.propertyArea.first;
    String buildupArea = ListItems.buildupArea.first;
    String? saleType;
    String? listedBy;
    String? facing;

    String carpetArea = ListItems.carpetArea.first;
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
          double keyBoardHeight = 0; //MediaQuery.of(context).viewInsets.bottom;
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
                                      itemList: ListItems.propertyArea,
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
                                      itemList: ListItems.buildupArea,
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
                                spacing: 5,
                                runSpacing: 3,
                                alignment: WrapAlignment.center,
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
                                    itemList: ListItems.saleType,
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
                                    itemList: ListItems.listedBy,
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
                                    itemList: ListItems.facing,
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
                              // contentPadding: kContentPadding,
                              // focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: kWhiteColor.withOpacity(0)),),
                              // contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
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
                                          suffixIcon: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 8),
                                            decoration: const BoxDecoration(
                                              color: kDarkGreyButtonColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 70,
                                              maxWidth: 75,
                                            ),
                                            child: const Text(
                                              'Total Floors',
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 12),
                                            ),
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
                                            itemList: ListItems.carpetArea,
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
                                          suffixIcon: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 8),
                                            decoration: const BoxDecoration(
                                              color: kDarkGreyButtonColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 70,
                                              maxWidth: 70,
                                            ),
                                            child: const Text(
                                              'Floor no',
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
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
                                          suffixIcon: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 8),
                                            decoration: const BoxDecoration(
                                              color: kDarkGreyButtonColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 70,
                                              maxWidth: 70,
                                            ),
                                            child: const Text(
                                              'Parking',
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          // focusNode: ,
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
                                        child: CustomTextField(
                                          hintText: 'Eg 3',
                                          fillColor: kWhiteColor,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          suffixIcon: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 8),
                                            decoration: const BoxDecoration(
                                              color: kDarkGreyButtonColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 70,
                                              maxWidth: 100,
                                            ),
                                            child: const Text(
                                              'Age Of Building',
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
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
                                              ListItems.constructionStatus,
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
                                          itemList: ListItems.furnishing,
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
                                      hintText: 'Land marks near your Villa',
                                      fillColor: kWhiteColor,
                                      suffixIcon: kRequiredAsterisk),
                                  kHeight15,
                                  const CustomTextField(
                                      fillColor: kWhiteColor,
                                      hintText: 'Website link of your Villa',
                                      suffixIcon: kRequiredAsterisk),
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
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: ButtonWithRightSideIcon(onPressed: () {
            Navigator.pushNamed(context, adConfirmScreen);
          }),
        ),
      ),
    );
  }
}

class AddMoreInfoButton extends StatelessWidget {
  const AddMoreInfoButton({
    super.key,
    this.onPressed,
    required this.backgroundColor,
    required this.icon,
  });
  final void Function()? onPressed;
  final Color backgroundColor;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: const Text(
          'Click to add more info',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor)),
      ),
    );
  }
}
