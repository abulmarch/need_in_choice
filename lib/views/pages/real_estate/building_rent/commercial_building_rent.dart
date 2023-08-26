import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import '../../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../../config/theme/screen_size.dart';
import '../../../../services/model/ad_create_or_update_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dropdown_list_items.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../../utils/main_cat_enum.dart';
import '../../../widgets_refactored/condinue_button.dart';
import '../../../widgets_refactored/custom_dropdown_button.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import '../../../widgets_refactored/dotted_border_textfield.dart';
import '../../../widgets_refactored/lottie_widget.dart';
import '../../../widgets_refactored/scrolling_app_bar.dart';

class CommercialBuildingForRent extends StatefulWidget {
  const CommercialBuildingForRent({super.key});

  @override
  State<CommercialBuildingForRent> createState() =>
      _CommercialBuildingForRentState();
}

class _CommercialBuildingForRentState extends State<CommercialBuildingForRent> {
  final ValueNotifier<bool> _addMoreEnabled = ValueNotifier(false); // false
  final _formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _brandNameController;
  late TextEditingController _propertyAreaController;
  late TextEditingController _buildupAreaController;
  late TextEditingController _roadWidthController;
  late TextEditingController _carpetAreaController;
  late TextEditingController _securityDepositController;
  late TextEditingController _parkingController;
  late TextEditingController _monthlyRentController;
  late TextEditingController _landMarksController;
  late TextEditingController _websiteLinkController;

  late ValueNotifier<int> _level4Cat;

  ScrollController scrollController = ScrollController();
  String propertyArea = RealEstateDropdownList.propertyArea.first;
  String buildupArea = RealEstateDropdownList.buildupArea.first;
  String? listedBy;
  String? facing;
  String carpetArea = RealEstateDropdownList.carpetArea.first;
  String roadWidth = RealEstateDropdownList.carpetArea.first;
  String? furnishing;
  bool _checkValidation = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _brandNameController = TextEditingController();
    _propertyAreaController = TextEditingController();
    _buildupAreaController = TextEditingController();
    _securityDepositController = TextEditingController();
    _roadWidthController = TextEditingController();

    _carpetAreaController = TextEditingController();
    _monthlyRentController = TextEditingController();
    _parkingController = TextEditingController();
    _landMarksController = TextEditingController();
    _websiteLinkController = TextEditingController();

    _level4Cat = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    final height = ScreenSize.height;
    final width = ScreenSize.width;
    final id = ModalRoute.of(context)!.settings.arguments as int?;

    final adCreateOrUpdateBloc = BlocProvider.of<AdCreateOrUpdateBloc>(context);
    adCreateOrUpdateBloc.add(AdCreateOrUpdateInitialEvent(
      id: id,
      currentPageRoute: commercialBuildingForRentRoot,
      mainCategory: MainCategory.realestate.name, //'realestate',
    ));

    return BlocBuilder<AdCreateOrUpdateBloc, AdCreateOrUpdateState>(
        builder: (context, state) {
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
          state is! AdCreateOrUpdateLoading) {}
      return Scaffold(
          backgroundColor: kWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 90),
            child: ValueListenableBuilder<int>(
                valueListenable: _level4Cat,
                builder: (context, selectedIndex, _) {
                  return ScrollingAppBarLevel4Category(
                    selectedIndex: selectedIndex,
                    level4List: building4saleCommercial,
                    onTap: (index) {
                      _level4Cat.value = index;
                    },
                  );
                }),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: kpadding15),
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
                                  ValueListenableBuilder<int>(
                                      valueListenable: _level4Cat,
                                      builder: (context, selectedIndex, _) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              building4saleCommercial[
                                                  selectedIndex]['cat_name']!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontSize: 20,
                                                      color: kPrimaryColor),
                                            ),
                                            // title arrow underline
                                            Stack(
                                              alignment: Alignment.centerRight,
                                              children: [
                                                DashedLineGenerator(
                                                    width: building4saleCommercial[
                                                                    selectedIndex]
                                                                ['cat_name']!
                                                            .length *
                                                        width *
                                                        0.033),
                                                const Icon(
                                                  Icons.arrow_forward,
                                                  size: 15,
                                                  color: kDottedBorder,
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      }),
                                ],
                              ),
                              kHeight20,
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
                                  maxHeight: height * 0.44,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                    CustomTextField(
                                      controller: _brandNameController,
                                      hintText: 'Eg Kh',
                                      suffixIcon: kRequiredAsterisk,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                    kHeight15,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: cons.maxWidth * 0.435,
                                          child: CustomTextField(
                                            controller: _propertyAreaController,
                                            hintText: 'Property Area',
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
                                    kHeight5,
                                    SizedBox(
                                      height: height * 0.08,
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        alignment: WrapAlignment.spaceEvenly,
                                        runAlignment: WrapAlignment.center,
                                        children: [
                                          CustomDropDownButton(
                                            initialValue: listedBy,
                                            hideValidationError:
                                                listedBy != null ||
                                                    _checkValidation == false,
                                            hint: Text(
                                              'Listed by',
                                              style: TextStyle(
                                                  color: kWhiteColor
                                                      .withOpacity(0.7)),
                                            ),
                                            maxWidth: width * 0.27,
                                            itemList:
                                                RealEstateDropdownList.listedBy,
                                            onChanged: (String? value) {
                                              listedBy = value!;
                                            },
                                          ),
                                          CustomDropDownButton(
                                            initialValue: facing,
                                            hideValidationError:
                                                facing != null ||
                                                    _checkValidation == false,
                                            hint: Text(
                                              'Facing',
                                              style: TextStyle(
                                                  color: kWhiteColor
                                                      .withOpacity(0.7)),
                                            ),
                                            maxWidth: width * 0.27,
                                            itemList:
                                                RealEstateDropdownList.facing,
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
                              DottedBorderTextField(
                                hintText: 'Monthly Rent',
                                controller: _monthlyRentController,
                                hideValidationError: _monthlyRentController.text
                                        .trim()
                                        .isNotEmpty ||
                                    _checkValidation == false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                              ),
                              kHeight20,
                              DottedBorderTextField(
                                hintText: 'Security Deposit',
                                color: kGreyColor,
                                controller: _securityDepositController,
                                hideValidationError: _securityDepositController
                                        .text
                                        .trim()
                                        .isNotEmpty ||
                                    _checkValidation == false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                              ),
                              kHeight20,
                              ValueListenableBuilder(
                                valueListenable: _addMoreEnabled,
                                builder: (context, isEnabled, _) {
                                  if (isEnabled == false) {
                                    return AddMoreInfoButton(
                                      onPressed: () {
                                        _addMoreEnabled.value =
                                            !_addMoreEnabled.value;
                                        Future.delayed(const Duration(
                                                milliseconds: 100))
                                            .then((value) => _scrollController
                                                .jumpTo(_scrollController
                                                        .position
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
                                          minHeight: cons.maxHeight * 0.7,
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
                                                  controller:
                                                      _roadWidthController,
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
                                                  suffixIcon:
                                                      const DarkTextChip(
                                                          text: 'meter'),
                                                ),
                                              ),
                                              SizedBox(
                                                width: cons.maxWidth * 0.435,
                                                child: CustomTextField(
                                                  hintText: 'Carpet Area',
                                                  controller:
                                                      _carpetAreaController,
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
                                                  suffixIcon:
                                                      CustomDropDownButton(
                                                    initialValue: carpetArea,
                                                    itemList:
                                                        RealEstateDropdownList
                                                            .carpetArea,
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
                                            children: [
                                              SizedBox(
                                                width: cons.maxWidth * 0.435,
                                                child: CustomTextField(
                                                  hintText: 'Eg 3',
                                                  controller:
                                                      _parkingController,
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
                                                  suffixIcon:
                                                      const DarkTextChip(
                                                          text: 'Parking'),
                                                ),
                                              ),
                                              kWidth10,
                                              CustomDropDownButton(
                                                initialValue: furnishing,
                                                hint: Text(
                                                  'furnishing',
                                                  style: TextStyle(
                                                      color: kWhiteColor
                                                          .withOpacity(0.7)),
                                                ),
                                                itemList: RealEstateDropdownList
                                                    .furnishing,
                                                maxWidth: width * 0.4,
                                                onChanged: (String? value) {
                                                  furnishing = value!;
                                                },
                                              )
                                            ],
                                          ),
                                          kHeight20,
                                          ValueListenableBuilder<int>(
                                              valueListenable: _level4Cat,
                                              builder:
                                                  (context, selectedIndex, _) {
                                                return Column(
                                                  children: [
                                                    CustomTextField(
                                                      hintText:
                                                          'Land marks near your ${building4saleCommercial[selectedIndex]['cat_name']!}',
                                                      controller:
                                                          _landMarksController,
                                                      fillColor: kWhiteColor,
                                                    ),
                                                    kHeight15,
                                                    CustomTextField(
                                                      fillColor: kWhiteColor,
                                                      hintText:
                                                          'Website link of your ${building4saleCommercial[selectedIndex]['cat_name']!}',
                                                      controller:
                                                          _websiteLinkController,
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ],
                                      ),
                                    )
                                  : const SizedBox();
                            })
                      ],
                    ),
                  ));
            },
          ),
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
                    _saveChangesAndContinue(context);
                  },
                ),
              )));
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
    _brandNameController.text = primaryData['Brand Name'] ?? "";
    _propertyAreaController.text = primaryData['Property Area']['value'];
    propertyArea = primaryData['Property Area']['unit'];
    _buildupAreaController.text = primaryData['Buildup Area']['value'];
    buildupArea = primaryData['Buildup Area']['unit'];

    listedBy = primaryData['Listed By'];
    facing = primaryData['Facing'];

    //-----------------------------------------------------------------

    _monthlyRentController.text = adUpdateModel.adPrice['Monthly'];
    _securityDepositController.text = adUpdateModel.adPrice['Security Deposit'];

    _roadWidthController.text = moreInfoData['Road Width']['value'];
    roadWidth = moreInfoData['Road Width']['unit'];
    _carpetAreaController.text = moreInfoData['Carpet Area']['value'];
    carpetArea = 'sq.feet'; //moreInfoData['Carpet Area']['unit'];//    ERROR
    _parkingController.text = moreInfoData['Parking'];
    furnishing = moreInfoData['Furnishing'];
    _landMarksController.text = moreInfoData['Landmark'];
    _websiteLinkController.text = moreInfoData['Website Link'];
    final index = building4saleCommercial.indexWhere((element) =>
        element['cat_name']?.toLowerCase() == adUpdateModel.level4Sub);
    _level4Cat.value = index >= 0 ? index : 0;
  }

  _saveChangesAndContinue(BuildContext context) {
    _checkValidation = true;
    context
        .read<AdCreateOrUpdateBloc>()
        .add(AdCreateOrUpdateCheckDropDownValidattionEvent());
    if (_formKey.currentState!.validate() &&
        listedBy != null &&
        facing != null &&
        _monthlyRentController.text.trim().isNotEmpty &&
        _securityDepositController.text.trim().isNotEmpty) {
      final Map<String, dynamic> primaryInfo = {
        'Brand Name': _brandNameController.text,
        'Property Area': {
          "value": _propertyAreaController.text,
          "unit": propertyArea
        },
        'Buildup Area': {
          "value": _buildupAreaController.text,
          "unit": buildupArea
        },
        'Listed By': listedBy!,
        'Facing': facing!,
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
        'Parking': _parkingController.text,
        'Furnishing': furnishing,
        'Landmark': _landMarksController.text,
        'Website Link': _websiteLinkController.text,
      };

      context.read<AdCreateOrUpdateBloc>().savePrimaryMoreInfoDetails(
        adsTitle: _titleController.text,
        description: _descriptionController.text,
        prymaryInfo: primaryInfo,
        moreInfo: moreInfo,
        level4Sub: building4saleCommercial[_level4Cat.value]['cat_name'],
        adPrice: {
          'Monthly': _monthlyRentController.text,
          'Security Deposit': _securityDepositController.text
        },
        adsLevels: {
          "route": commercialBuildingForRentRoot,
          "sub category": building4saleCommercial[_level4Cat.value]['cat_name']
              ?.toLowerCase(),
        },
      );
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
    _brandNameController.dispose();
    _propertyAreaController.dispose();
    _roadWidthController.dispose();
    _monthlyRentController.dispose();
    _buildupAreaController.dispose();
    _roadWidthController.dispose();
    _securityDepositController.dispose();
    _carpetAreaController.dispose();
    _parkingController.dispose();
    _landMarksController.dispose();
    _websiteLinkController.dispose();

    super.dispose();
  }
}

typedef Level4CatSelectCallback = void Function(int index);
