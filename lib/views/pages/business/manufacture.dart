import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../config/routes/route_names.dart';
import '../../../config/theme/screen_size.dart';
import '../../widgets_refactored/brand_name_button.dart';
import '../../widgets_refactored/circular_back_button.dart';
import '../../widgets_refactored/condinue_button.dart';
import '../../widgets_refactored/custom_text_field.dart';
import '../../widgets_refactored/dotted_border_textfield.dart';
import '../../widgets_refactored/image_upload_doted_circle.dart';

ValueNotifier<bool> addMoreEnabled = ValueNotifier(false);

class ManufactureScreen extends StatelessWidget {
  const ManufactureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final height = ScreenSize.size.height;
    final width = ScreenSize.size.width;

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
                      itemCount: business4sale.length,
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
                                border: business4sale[index]['cat_name']!.toLowerCase() == 'manufacturer'
                                  ? Border.all(color: kSecondaryColor)
                                  : null,
                              ),
                              child: Image.asset(
                                business4sale[index]['cat_img']!,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Text(
                              business4sale[index]['cat_name']!.toLowerCase(),
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
              child: Column(children: [
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
                                business4sale[0]['cat_name']!,
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
                                        business4sale[0]['cat_name']!.length *
                                            13,
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
                        height: 200,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextField(
                                  width: width * .6,
                                  hintText: 'Eg Bajaj',
                                  suffixIcon: kRequiredAsterisk,
                                ),
                                CustomTextField(
                                  width: width * .28,
                                  hintText: 'Eg Year Started',
                                ),
                              ],
                            ),
                            kHeight15,
                            const CustomTextField(
                              hintText: 'Eg Product',
                            ),
                          ],
                        ),
                      ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.05,
                                child: CustomTextField(
                                  width: width * 0.65,
                                  hintText: 'Details 1',
                                ),
                              ),
                              kHeight10,
                              SizedBox(
                                height: height * 0.05,
                                child: CustomTextField(
                                    width: width * 0.65, hintText: 'Details 2'),
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
                                          text: 'Details',
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
                      DashedLineGenerator(
                        width: cons.maxWidth - 60,
                        color: kDottedBorder,
                      ),
                      kHeight20,
                      const DottedBorderTextField(
                        hintText: 'Ads Price',
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
                      kHeight20,
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
                                        horizontal: kpadding10),
                                    decoration: const BoxDecoration(
                                      color: Color(0x1CA6A7A8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        kHeight20,
                                        RichText(
                                          text: TextSpan(
                                            text: 'Working ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                    color: kDarkGreyColor),
                                            children: [
                                              TextSpan(
                                                text: 'Hours',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20,
                                                        color: kPrimaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        kHeight10,
                                        Container(
                                          height: height * 0.03,
                                          width: width * 0.43,
                                          decoration: BoxDecoration(
                                              color: kDarkGreyButtonColor,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: const Center(
                                              child: Text(
                                            '10.00 am to 5.00pm',
                                            style: TextStyle(
                                                color: kWhiteColor,
                                                fontWeight: FontWeight.w300),
                                          )),
                                        ),
                                        kHeight10,
                                        Container(
                                          height: height * 0.08,
                                          decoration: BoxDecoration(
                                            color: kButtonColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            children: [
                                              Wrap(
                                                spacing: 6.0,
                                                runSpacing: 6.0,
                                                children: const [
                                                  WorkTimeContainer(
                                                    color: kWhiteColor,
                                                    textcolor: kPrimaryColor,
                                                    text: 'Mon',
                                                  ),
                                                  WorkTimeContainer(
                                                    color: kWhiteColor,
                                                    textcolor: kPrimaryColor,
                                                    text: 'Tue',
                                                  ),
                                                  WorkTimeContainer(
                                                    color: kWhiteColor,
                                                    textcolor: kPrimaryColor,
                                                    text: 'Wed',
                                                  ),
                                                  WorkTimeContainer(
                                                    color: kWhiteColor,
                                                    textcolor: kPrimaryColor,
                                                    text: 'Thu',
                                                  ),
                                                  WorkTimeContainer(
                                                    color: kWhiteColor,
                                                    textcolor: kPrimaryColor,
                                                    text: 'Fri',
                                                  ),
                                                  WorkTimeContainer(
                                                    color: kLightGreyColor,
                                                    textcolor: kLightGreyColor,
                                                    text: 'Sun',
                                                  ),
                                                  WorkTimeContainer(
                                                    color: kLightGreyColor,
                                                    textcolor: kLightGreyColor,
                                                    text: 'Sat',
                                                  ),
                                                ],
                                              ),
                                              kHeight15,
                                            ],
                                          ),
                                        ),
                                        DashedLineGenerator(
                                          width: cons.maxWidth - 60,
                                          color: kDottedBorder,
                                        ),
                                        kHeight15,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomTextField(
                                              width: width * 0.6,
                                              hintText: 'Landmarks near you',
                                              fillColor: kWhiteColor,
                                            ),
                                            const ImageUploadDotedCircle(
                                              color: kPrimaryColor,
                                              documentTypeName: 'PDF\nUpload',
                                            ),
                                          ],
                                        ),
                                        kHeight5,
                                        const CustomTextField(
                                          fillColor: kWhiteColor,
                                          hintText: 'Website',
                                        ),
                                        kHeight15,
                                        const CustomTextField(
                                          maxLines: 6,
                                          fillColor: kWhiteColor,
                                          hintText: 'Terms & Conditions',
                                        ),
                                        kHeight20
                                      ],
                                    ),
                                  )
                                : const SizedBox();
                          })
                    ],
                  ),
                ),
              ]));
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
