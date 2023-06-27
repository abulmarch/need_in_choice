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
import '../../widgets_refactored/image_upload_doted_circle.dart';

class JobSeekerScreen extends StatelessWidget {
  const JobSeekerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    String? work;
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
                            'JOB SEEKER',
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
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                  hintText: 'Ads name | Title',
                                  suffixIcon: kRequiredAsterisk),
                              kHeight15,
                              CustomTextField(
                                  maxLines: 5,
                                  hintText: 'Description',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                  suffixIcon: kRequiredAsterisk),
                              kHeight20,
                              SizedBox(
                                height: height * .15,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Job Category',
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
                                      hintText: 'Eg Job Category',
                                    ),
                                  ],
                                ),
                              ),
                              kHeight20,
                              RichText(
                                text: TextSpan(
                                  text: 'Available ',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Expected\n',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: kLightGreyColor),
                                      children: [
                                        TextSpan(
                                          text: 'Job Details',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: kPrimaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            width: width * 0.3,
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
                                                    hintText: 'Max salary',
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
                                    ],
                                  )
                                ],
                              ),
                              kHeight15,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  CustomTextField(
                                    width: width * 0.25,
                                    hintText: 'My Age',
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Resume ',
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
                                  const ImageUploadDotedSquare(
                                    color: kBlackColor,
                                    text: 'Upload\nResume',
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        kHeight20,
                        Container(
                            height: height * .06,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kadBox,
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Share Resume to :  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: kLightGreyColor),
                                  children: [
                                    TextSpan(
                                      text: 'info@calletic.com',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        kHeight20,
                        kHeight20,
                      ])),
                ]));
          },
        ),
        //  bottom continue button

        bottomNavigationBar: SizedBox(
            width: double.infinity,
            height: height * 0.12,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: kpadding20,
                  right: kpadding20,
                  bottom: kpadding20,
                  top: kpadding10),
              child: ButtonWithRightSideIcon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                }, //null //
              ),
            )));
  }
}
