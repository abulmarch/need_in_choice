import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';
import '../../../../config/theme/screen_size.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dropdown_list_items.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../widgets_refactored/circular_back_button.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import '../../../widgets_refactored/condinue_button.dart';
import '../../../widgets_refactored/custom_dropdown_button.dart';

class LoadingVehicleForRent extends StatelessWidget {
  const LoadingVehicleForRent({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> addMoreEnabled = ValueNotifier(false);
    ScrollController scrollController = ScrollController();
    final height = ScreenSize.size.height;
    final width = ScreenSize.size.width;
    String? rent;
    String? listedBy;
    String? drivingType;
    String loadingCapacity = VehicleDropDownList.loadingCapacity.first;

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
                      'Loading Vehicle for Rent',
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
                                  0.07,
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
          return SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: kpadding15),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: cons.maxHeight * 0.5,
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
                        height: height * 0.08,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          runSpacing: 3,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            CustomDropDownButton(
                              initialValue: listedBy,
                              hint: Text(
                                'Listed by',
                                style: TextStyle(
                                    color: kWhiteColor.withOpacity(0.7)),
                              ),
                              maxWidth: width * 0.25,
                              itemList: VehicleDropDownList.listedBy,
                              onChanged: (String? value) {
                                listedBy = value!;
                              },
                            ),
                            CustomDropDownButton(
                              initialValue: drivingType,
                              hint: Text(
                                'Driving Type',
                                style: TextStyle(
                                    color: kWhiteColor.withOpacity(0.7)),
                              ),
                              maxWidth: width * 0.31,
                              itemList: VehicleDropDownList.drivingType,
                              onChanged: (String? value) {
                                drivingType = value!;
                              },
                            ),
                            CustomDropDownButton(
                              initialValue: rent,
                              hint: Text(
                                'Rent',
                                style: TextStyle(
                                    color: kWhiteColor.withOpacity(0.7)),
                              ),
                              maxWidth: width * 0.23,
                              itemList: VehicleDropDownList.rentTypeLoading,
                              onChanged: (String? value) {
                                rent = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      kHeight20,
                      SizedBox(
                        width: cons.maxWidth * 0.835,
                        child: CustomTextField(
                          hintText: 'Loading Capacity',
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          suffixIcon: CustomDropDownButton(
                            initialValue: loadingCapacity,
                            itemList: VehicleDropDownList.loadingCapacity,
                            onChanged: (String? value) {
                              loadingCapacity = value!;
                            },
                          ),
                          // focusNode: ,
                        ),
                      ),
                      kHeight20,
                      DashedLineGenerator(
                        width: width * .9,
                        color: kDottedBorder,
                      ),
                      kHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: height * 0.07,
                            width: width * 0.42,
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
                                    hintText: 'Minimum Charge',
                                    hintStyle:
                                        TextStyle(color: kSecondaryColor),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.07,
                            width: width * 0.42,
                            child: DottedBorder(
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
                                    hintText: 'Daily Charge',
                                    hintStyle: TextStyle(color: kGreyColor),
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
                kHeight10,
                ValueListenableBuilder(
                    valueListenable: addMoreEnabled,
                    builder: (context, isEnabled, _) {
                      return isEnabled == true
                          ? Container(
                              width: cons.maxWidth,
                              constraints: BoxConstraints(
                                  minHeight: cons.maxHeight * 0.45,
                                  maxHeight: double.infinity),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kpadding15),
                              decoration: const BoxDecoration(
                                color: Color(0x1CA6A7A8),
                              ),
                              child: Column(
                                children: const [
                                  kHeight15,
                                  CustomTextField(
                                    maxLines: 6,
                                    fillColor: kWhiteColor,
                                    hintText: 'Terms & Conditions',
                                  ),
                                  kHeight10,
                                  CustomTextField(
                                    fillColor: kWhiteColor,
                                    hintText: 'Website link in Here',
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
