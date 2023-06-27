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
import '../../../widgets_refactored/image_upload_doted_circle.dart';

class LandForRentScreen extends StatelessWidget {
  const LandForRentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ScrollController scrollController = ScrollController();
    String buildupArea = DropdownUnitsList.buildupArea.first;
    String? listedBy;
    String? facing;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: kpadding10),
            child: SizedBox(
              height: height*0.15,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2, bottom: kpadding20),
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
                      itemCount: land4saleLevel4Cat.length,
                      itemBuilder: (context, index) => SizedBox(
                        width: width*0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: height*0.06,
                              width: width*0.15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kDisabledBackground,
                                shape: BoxShape.circle,
                                border: land4saleLevel4Cat[index]['cat_name']!
                                            .toLowerCase() ==
                                        'farm land'
                                    ? Border.all(color: kSecondaryColor)
                                    : null,
                              ),
                              child: Image.asset(
                                land4saleLevel4Cat[index]['cat_img']!,
                                height: height*0.05,
                                width: width*0.15,
                              ),
                            ),
                            Text(
                              land4saleLevel4Cat[index]['cat_name']!
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
                                'Farm',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontSize: 20, color: kPrimaryColor),
                              ),
                              // title arrow underline
                              Stack(
                                alignment: Alignment.centerRight,
                                children:  [
                                  DashedLineGenerator(width: width*0.15),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: cons.maxWidth * 0.635,
                            child: CustomTextField(
                              hintText: 'Land Area',
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              suffixIcon: CustomDropDownButton(
                                initialValue: buildupArea,
                                itemList: DropdownUnitsList.buildupArea,
                                onChanged: (String? value) {
                                  buildupArea = value!;
                                },
                              ),
                              // focusNode: ,
                            ),
                          ),
                          const ImageUploadDotedCircle(
                            color: kBlackColor,
                            text: 'Land\nSketch',
                          ),
                        ],
                      ),
                      kHeight10,
                      SizedBox(
                        height: height*0.05,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceEvenly,
                          runAlignment: WrapAlignment.center,
                          children: [
                            CustomDropDownButton(
                              initialValue: facing,
                              hint: Text(
                                'Facing',
                                style: TextStyle(
                                    color: kWhiteColor.withOpacity(0.7)),
                              ),
                              maxWidth: width*0.27,
                              itemList: DropdownUnitsList.facing,
                              onChanged: (String? value) {
                                facing = value!;
                              },
                            ),
                            CustomDropDownButton(
                              initialValue: listedBy,
                              hint: Text(
                                'Listed by',
                                style: TextStyle(
                                    color: kWhiteColor.withOpacity(0.7)),
                              ),
                              maxWidth: width*0.27,
                              itemList: DropdownUnitsList.listedBy,
                              onChanged: (String? value) {
                                listedBy = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      kHeight10,
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
            height: height*0.12,
            child: const Padding(
              padding:
              EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
              child: ButtonWithRightSideIcon(
                onPressed: null //(){},//
              ),
            ))
    );
  }
}
