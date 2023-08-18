import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/utils/colors.dart';
import '../../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../../services/model/ad_create_or_update_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dropdown_list_items.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../../utils/main_cat_enum.dart';
import '../../../widgets_refactored/circular_back_button.dart';
import '../../../widgets_refactored/condinue_button.dart';
import '../../../widgets_refactored/custom_dropdown_button.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import '../../../widgets_refactored/dotted_border_textfield.dart';
import '../../../widgets_refactored/image_upload_doted_circle.dart';
import '../../../widgets_refactored/lottie_widget.dart';
import '../blocs/e_auction_bloc/e_auction_bloc.dart';

class EAuctionProperty extends StatefulWidget {
  const EAuctionProperty({super.key});

  @override
  State<EAuctionProperty> createState() => _EAuctionPropertyState();
}

class _EAuctionPropertyState extends State<EAuctionProperty> {
  final ValueNotifier<bool> _addMoreEnabled = ValueNotifier(false); // false
  final _formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _bankNameController;
  late TextEditingController _branchNameController;
  late TextEditingController _propertyAreaController;
  late TextEditingController _buildupAreaController;
  late TextEditingController _totalFloorController;
  late TextEditingController _roadWidthController;
  late TextEditingController _startPriceController;
  late TextEditingController _preBidPriceController;
  late TextEditingController _startEndDateController;
  late TextEditingController _carpetAreaController;
  late TextEditingController _floorNoController;
  late TextEditingController _parkingController;
  late TextEditingController _ageOfBuildingController;
  late TextEditingController _landMarksController;
  late TextEditingController _websiteLinkController;

  String propertyArea = RealEstateDropdownList.propertyArea.first;
  String buildupArea = RealEstateDropdownList.buildupArea.first;
  String carpetArea = RealEstateDropdownList.carpetArea.first;
  String roadWidth = RealEstateDropdownList.carpetArea.first;
  bool _checkValidation = false;

  String? bidStartDate;
  String? bidEndDate;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _bankNameController = TextEditingController();
    _branchNameController = TextEditingController();

    _startEndDateController = TextEditingController();
    _propertyAreaController = TextEditingController();
    _buildupAreaController = TextEditingController();
    _totalFloorController = TextEditingController();
    _roadWidthController = TextEditingController();
    _startPriceController = TextEditingController();
    _preBidPriceController = TextEditingController();
    _carpetAreaController = TextEditingController();
    _floorNoController = TextEditingController();
    _parkingController = TextEditingController();
    _ageOfBuildingController = TextEditingController();
    _landMarksController = TextEditingController();
    _websiteLinkController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final id = ModalRoute.of(context)!.settings.arguments as int?;

    final adCreateOrUpdateBloc = BlocProvider.of<AdCreateOrUpdateBloc>(context);
    adCreateOrUpdateBloc.add(AdCreateOrUpdateInitialEvent(
      id: id,
      currentPageRoute: eAuctionProjectForSaleRoot,
      mainCategory: MainCategory.realestate.name, //'realestate',
    ));

    return BlocBuilder<AdCreateOrUpdateBloc, AdCreateOrUpdateState>(
        builder: (context, state) {
      List otherImageUrl = [];
      List<Map> otherImageFiles = [];
      if (state is FaildToFetchExceptionState ||
          state is AdCreateOrUpdateLoading) {
        return _loadingScaffoldWidget(state);
      } else if (state is AdCreateOrUpdateLoaded) {
        if (state.adUpdateModel != null) {
          _initializeUpdatingAdData(state.adUpdateModel!);
        } else {
          _checkValidation = false;
        }
      } else if (state is AdCreateOrUpdateValidateState) {
        _checkValidation = true;
      }

      if (state is! FaildToFetchExceptionState &&
          state is! AdCreateOrUpdateLoading) {
        try {
          otherImageUrl =
              adCreateOrUpdateBloc.adCreateOrUpdateModel.otherImageUrls;
          otherImageFiles =
              adCreateOrUpdateBloc.adCreateOrUpdateModel.otherImageFiles;
        } catch (e) {
          log(e.toString());
        }
      }
      return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 90),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: kpadding10),
              child: SizedBox(
                height: height * 0.09,
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
                                  width: building4saleCommercial[0]['cat_name']!
                                          .length *
                                      width *
                                      0.06),
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
          builder: (context, cons) {
            return SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kpadding15),
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: cons.maxHeight,
                        maxHeight: double.infinity,
                      ),
                      child: Column(
                        children: [
                          kHeight10,
                          CustomTextField(
                            hintText: 'Ads name | Title',
                            controller: _titleController,
                            suffixIcon: kRequiredAsterisk,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          kHeight15,
                          CustomTextField(
                            controller: _descriptionController,
                            maxLines: 5,
                            hintText: 'Description',
                            suffixIcon: kRequiredAsterisk,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          kHeight20,
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 255,
                              maxHeight: height * 0.56,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      width: width * 0.44,
                                      hintText: 'Eg Bank Name',
                                      controller: _bankNameController,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                    CustomTextField(
                                      width: width * 0.44,
                                      hintText: 'Eg Branch Name',
                                      controller: _branchNameController,
                                      suffixIcon: kRequiredAsterisk,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
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
                                        hintText: 'Property Area',
                                        controller: _propertyAreaController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Please enter a number';
                                          }
                                          return null;
                                        },
                                        inputFormatters: [
                                          // FilteringTextInputFormatter.digitsOnly
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}')),
                                        ],
                                        keyboardType: TextInputType.number,

                                        onTapOutside: (event) {
                                          FocusScope.of(context).unfocus();
                                        },
                                        suffixIcon: CustomDropDownButton(
                                          initialValue: propertyArea,
                                          itemList: RealEstateDropdownList
                                              .propertyArea,
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
                                        controller: _buildupAreaController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        onTapOutside: (event) {
                                          FocusScope.of(context).unfocus();
                                        },
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Please enter a number';
                                          }
                                          return null;
                                        },
                                        suffixIcon: CustomDropDownButton(
                                          initialValue: buildupArea,
                                          itemList: RealEstateDropdownList
                                              .buildupArea,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: height * 0.07,
                                      width: width * 0.44,
                                      child: DottedBorderTextField(
                                        hintText: 'Start Price',
                                        color: kSecondaryColor,
                                        controller: _startPriceController,
                                        hideValidationError:
                                            _startPriceController.text
                                                    .trim()
                                                    .isNotEmpty ||
                                                _checkValidation == false,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}')),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.07,
                                      width: width * 0.44,
                                      child: DottedBorderTextField(
                                        color: kGreyColor,
                                        hintText: 'Pre bid Amount',
                                        controller: _preBidPriceController,
                                        hideValidationError:
                                            _preBidPriceController.text
                                                    .trim()
                                                    .isNotEmpty ||
                                                _checkValidation == false,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}')),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                kHeight15,
                                BlocProvider(
                                  create: (context) => EAuctionBloc(),
                                  child:
                                      BlocBuilder<EAuctionBloc, EAuctionState>(
                                    builder: (context, state) {
                                      if (state is DateSelectedState) {
                                        if (state.bidType ==
                                            BidType.bidStartDate) {
                                          bidStartDate = state.date;
                                        } else {
                                          bidEndDate = state.date;
                                        }
                                        _startEndDateController.text =
                                            '$bidStartDate - $bidEndDate';
                                      }

                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              _selectDate(context, true)
                                                  .then((selectedDate) {
                                                if (selectedDate != null) {
                                                  context
                                                      .read<EAuctionBloc>()
                                                      .add(SetDateRangeEvent(
                                                          selectedDate:
                                                              selectedDate,
                                                          bidType: BidType
                                                              .bidStartDate));
                                                }
                                              });
                                            },
                                            // _selectDate(context, true),
                                            style: ElevatedButton.styleFrom(
                                              maximumSize: Size(
                                                  width * .35, height * .04),
                                              minimumSize: Size(
                                                  width * .2, height * 0.01),
                                              shadowColor: kPrimaryColor,
                                              backgroundColor: kPrimaryColor,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                side: bidStartDate == null &&
                                                        _checkValidation
                                                    ? const BorderSide(
                                                        color: Colors.red)
                                                    : BorderSide.none,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                bidStartDate != null
                                                    ? bidStartDate!
                                                    : 'Bid Start Date',
                                                style: const TextStyle(
                                                  color: kWhiteColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              _selectDate(context, false)
                                                  .then((selectedDate) {
                                                if (selectedDate != null) {
                                                  context
                                                      .read<EAuctionBloc>()
                                                      .add(SetDateRangeEvent(
                                                          selectedDate:
                                                              selectedDate,
                                                          bidType: BidType
                                                              .bidEndDate));
                                                }
                                              });
                                            },
                                            //  _selectDate(context, false),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: kPrimaryColor,
                                              maximumSize: Size(
                                                  width * .35, height * .04),
                                              minimumSize: Size(
                                                  width * .2, height * 0.01),
                                              shadowColor: kPrimaryColor,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                side: bidEndDate == null &&
                                                        _checkValidation
                                                    ? const BorderSide(
                                                        color: Colors.red)
                                                    : BorderSide.none,
                                              ),
                                            ),
                                            child: Container(
                                              height: height * 0.045,
                                              width: width * 0.36,
                                              alignment: Alignment.center,
                                              child: Text(
                                                bidEndDate != null
                                                    ? bidEndDate!
                                                    : 'Bid End Date',
                                                style: const TextStyle(
                                                  color: kWhiteColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                kHeight15
                              ],
                            ),
                          ),
                          DashedLineGenerator(width: cons.maxWidth - 60),
                          kHeight20,
                          ValueListenableBuilder(
                            valueListenable: _addMoreEnabled,
                            builder: (context, isEnabled, _) {
                              if (isEnabled == false) {
                                return AddMoreInfoButton(
                                  onPressed: () {
                                    _addMoreEnabled.value =
                                        !_addMoreEnabled.value;
                                    Future.delayed(
                                            const Duration(milliseconds: 100))
                                        .then((value) => _scrollController.jumpTo(
                                            _scrollController.position
                                                .maxScrollExtent // cons.maxHeight * 0.8,
                                            ));
                                  },
                                );
                              } else {
                                return AddMoreInfoButton(
                                  onPressed: () {
                                    _addMoreEnabled.value =
                                        !_addMoreEnabled.value;
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
                        valueListenable: _addMoreEnabled,
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
                                              controller: _roadWidthController,

                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^\d+\.?\d{0,2}')),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onTapOutside: (event) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              suffixIcon: const DarkTextChip(
                                                  text: 'meter'),
                                              // focusNode: ,
                                            ),
                                          ),
                                          SizedBox(
                                            width: cons.maxWidth * 0.435,
                                            child: CustomTextField(
                                              hintText: 'Carpet Area',
                                              controller: _carpetAreaController,
                                              fillColor: kWhiteColor,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^\d+\.?\d{0,2}')),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onTapOutside: (event) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              suffixIcon: CustomDropDownButton(
                                                initialValue: carpetArea,
                                                itemList: RealEstateDropdownList
                                                    .carpetArea,
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
                                              controller: _totalFloorController,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onTapOutside: (event) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              suffixIcon: const DarkTextChip(
                                                  text: 'Total Floor'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: cons.maxWidth * 0.435,
                                            child: CustomTextField(
                                              hintText: 'Eg 3',
                                              controller: _parkingController,
                                              fillColor: kWhiteColor,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onTapOutside: (event) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              suffixIcon: const DarkTextChip(
                                                  text: 'Parking'),
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
                                              controller: _floorNoController,
                                              fillColor: kWhiteColor,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onTapOutside: (event) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              suffixIcon: const DarkTextChip(
                                                  text: 'Floor Number'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: cons.maxWidth * 0.435,
                                            child: CustomTextField(
                                              hintText: 'Age of Building',
                                              controller:
                                                  _ageOfBuildingController,
                                              fillColor: kWhiteColor,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^\d+\.?\d{0,2}')),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onTapOutside: (event) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              suffixIcon: const DarkTextChip(
                                                  text: 'year'),
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
                                            width: width * 0.45,
                                            hintText:
                                                'Landmarks near your Property',
                                            controller: _landMarksController,
                                            fillColor: kWhiteColor,
                                          ),
                                          SizedBox(
                                              width: cons.maxWidth * 0.435,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ImageUploadDotedCircle(
                                                    color: kPrimaryColor,
                                                    documentTypeName:
                                                        'Floor\nPlan',
                                                    networkImageUrl:
                                                        otherImageUrl
                                                            .firstWhere(
                                                      (map) =>
                                                          map['image_type'] ==
                                                          'Floor Plan',
                                                      orElse: () => {},
                                                    )?['url'],
                                                    imageFile: otherImageFiles
                                                        .firstWhere(
                                                      (map) =>
                                                          map['image_type'] ==
                                                          'Floor Plan',
                                                      orElse: () => {},
                                                    )['file'],
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              AdCreateOrUpdateBloc>()
                                                          .add(const PickOtherImageEvent(
                                                              'Floor Plan'));
                                                    },
                                                  ),
                                                  ImageUploadDotedCircle(
                                                    color: kBlackColor,
                                                    documentTypeName:
                                                        'Land\nSketch',
                                                    networkImageUrl:
                                                        otherImageUrl
                                                            .firstWhere(
                                                      (map) =>
                                                          map['image_type'] ==
                                                          'Land Sketch',
                                                      orElse: () => {},
                                                    )?['url'],
                                                    imageFile: otherImageFiles
                                                        .firstWhere(
                                                      (map) =>
                                                          map['image_type'] ==
                                                          'Land Sketch',
                                                      orElse: () => {},
                                                    )['file'],
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              AdCreateOrUpdateBloc>()
                                                          .add(const PickOtherImageEvent(
                                                              'Land Sketch'));
                                                    },
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                      kHeight15,
                                      CustomTextField(
                                        fillColor: kWhiteColor,
                                        hintText:
                                            'Website link of your Property',
                                        controller: _websiteLinkController,
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
            );
          },
        ),
        bottomNavigationBar: SizedBox(
            width: double.infinity,
            height: 70,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ButtonWithRightSideIcon(
                  onPressed: () {
                    _saveChangesAndContinue(context);
                  },
                ))),
      );
    });
  }

  Scaffold _loadingScaffoldWidget(AdCreateOrUpdateState state) {
    return Scaffold(
      body: state is FaildToFetchExceptionState
          ? Center(
              child: Text(state.errorMessagge),
            )
          : LottieWidget.loading(),
    );
  }

  void _initializeUpdatingAdData(AdCreateOrUpdateModel adUpdateModel) {
    log(adUpdateModel.toString());

    final primaryData = adUpdateModel.primaryData;
    final moreInfoData = adUpdateModel.moreInfoData;
    _titleController.text = adUpdateModel.adsTitle;
    _descriptionController.text = adUpdateModel.description;
    _bankNameController.text = primaryData['Bank Name'] ?? "";
    _branchNameController.text = primaryData['Branch Name'] ?? "";

    _propertyAreaController.text = primaryData['Property Area']['value'];
    propertyArea = primaryData['Property Area']['unit'];
    _buildupAreaController.text = primaryData['Buildup Area']['value'];
    buildupArea = primaryData['Buildup Area']['unit'];
    _startEndDateController.text = primaryData['Date Range'];

    //-----------------------------------------------------------------

    _startPriceController.text = adUpdateModel.adPrice['Start Price'];
    _preBidPriceController.text = adUpdateModel.adPrice['Prebid'];
    _roadWidthController.text = moreInfoData['Road Width']['value'];
    roadWidth = moreInfoData['Road Width']['unit'];
    _carpetAreaController.text = moreInfoData['Carpet Area']['value'];
    carpetArea = 'sq.feet'; //moreInfoData['Carpet Area']['unit'];//    ERROR
    _totalFloorController.text = moreInfoData['Total Floor'];
    _floorNoController.text = moreInfoData['Floor No'];
    _parkingController.text = moreInfoData['Parking'];
    _ageOfBuildingController.text = moreInfoData['Age Of Building'];

    _landMarksController.text = moreInfoData['Landmark'];
    _websiteLinkController.text = moreInfoData['Website Link'];
  }

  _saveChangesAndContinue(BuildContext context) {
    _checkValidation = true;
    context
        .read<AdCreateOrUpdateBloc>()
        .add(AdCreateOrUpdateCheckDropDownValidattionEvent());
    if (_formKey.currentState!.validate() &&
        _startPriceController.text.trim().isNotEmpty &&
        _preBidPriceController.text.trim().isNotEmpty) {
      final Map<String, dynamic> primaryInfo = {
        'Bank Name': _bankNameController.text,
        'Branch Name': _branchNameController.text,
        'Property Area': {
          "value": _propertyAreaController.text,
          "unit": propertyArea
        },
        'Buildup Area': {
          "value": _buildupAreaController.text,
          "unit": buildupArea
        },
        'Date Range': _startEndDateController.text,
      };
      final Map<String, dynamic> moreInfo = {
        'Road Width': {
          'value': _roadWidthController.text,
          'unit': 'm',
        },
        'Carpet Area': {
          'value': _carpetAreaController.text,
          'unit': carpetArea,
        },
        'Floor No': _floorNoController.text,
        'Parking': _parkingController.text,
        'Age Of Building': {
          'value': _ageOfBuildingController.text,
          'unit': 'yrs',
        },
        'Total Floor': _totalFloorController.text,
        'Landmark': _landMarksController.text,
        'Website Link': _websiteLinkController.text,
      };

      context.read<AdCreateOrUpdateBloc>().savePrimaryMoreInfoDetails(
          adsTitle: _titleController.text,
          description: _descriptionController.text,
          prymaryInfo: primaryInfo,
          moreInfo: moreInfo,
          // level4Sub: building4saleCommercial[_level4Cat.value]['cat_name'],
          adsLevels: {
            "route": eAuctionProjectForSaleRoot,
            "sub category": null,
          },
          adPrice: {
            'Start Price': _startPriceController.text,
            'Prebid': _preBidPriceController.text
          });
      Navigator.pushNamed(
        context,
        adConfirmScreen,
      ); //
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _bankNameController.dispose();
    _propertyAreaController.dispose();
    _branchNameController.dispose();
    _totalFloorController.dispose();
    _buildupAreaController.dispose();
    _roadWidthController.dispose();
    _startPriceController.dispose();
    _preBidPriceController.dispose();
    _carpetAreaController.dispose();
    _floorNoController.dispose();
    _parkingController.dispose();
    _ageOfBuildingController.dispose();
    _landMarksController.dispose();
    _websiteLinkController.dispose();
    super.dispose();
  }

  Future<DateTime?> _selectDate(BuildContext context, bool isStartDate) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
  }

  String dateFormat(DateTime selectedStartDate, DateTime selectedEndDate) {
    return '${context.read<EAuctionBloc>().formatDate(selectedStartDate)} - ${context.read<EAuctionBloc>().formatDate(selectedEndDate)}';
  }
}
