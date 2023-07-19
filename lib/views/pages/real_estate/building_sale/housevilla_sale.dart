import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/utils/colors.dart';
import '../../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../../config/routes/route_names.dart';
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

class HouseVillaSaleScreen extends StatefulWidget {
  const HouseVillaSaleScreen({super.key});

  @override
  State<HouseVillaSaleScreen> createState() => _HouseVillaSaleScreenState();
}

class _HouseVillaSaleScreenState extends State<HouseVillaSaleScreen> {
  final ValueNotifier<bool> _addMoreEnabled = ValueNotifier(false); // false
  final _formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _brandNameController;
  late TextEditingController _propertyAreaController;
  late TextEditingController _buildupAreaController;
  late TextEditingController _bedroomController;
  late TextEditingController _bathroomController;

  late TextEditingController _roadWidthController;
  late TextEditingController _adsPriceController;
  late TextEditingController _carpetAreaController;
  late TextEditingController _floorNoController;
  late TextEditingController _parkingController;
  late TextEditingController _ageOfBuildingController;
  late TextEditingController _landMarksController;
  late TextEditingController _websiteLinkController;

  ScrollController scrollController = ScrollController();
  String propertyArea = RealEstateDropdownList.propertyArea.first;
  String buildupArea = RealEstateDropdownList.buildupArea.first;
  String? saleType;
  String? listedBy;
  String? facing;
  String carpetArea = RealEstateDropdownList.carpetArea.first;
  String roadWidth = RealEstateDropdownList.carpetArea.first;
  String? constructionStatus;
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
    _bedroomController = TextEditingController();
    _bathroomController = TextEditingController();
    _roadWidthController = TextEditingController();
    _adsPriceController = TextEditingController();
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

    final adCreateOrUpdateBloc = BlocProvider.of<AdCreateOrUpdateBloc>(context);
    adCreateOrUpdateBloc.add(AdCreateOrUpdateInitialEvent(
      // id: 29,
      currentPageRoute: houseAndVillaForSaleRoot,
      mainCategory: MainCategory.realestate.name, //'realestate',
    ));

    return BlocBuilder<AdCreateOrUpdateBloc, AdCreateOrUpdateState>(
      builder: (context, state) {
        List otherImageUrl = [];
        List<Map> otherImageFiles = [];
        if (state is FaildToFetchExceptionState ||
            state is AdCreateOrUpdateLoading) {
          return _loadingScaffoldWidget(state);
        } else if (state is AdCreateOrUpdateLoaded &&
            state.adUpdateModel != null) {
          _initializeUpdatingAdData(state.adUpdateModel!);
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
                              'House | Villa',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 22, color: kPrimaryColor),
                            ),
                            // title arrow underline
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                DashedLineGenerator(
                                    width: building4saleCommercial[0]
                                                ['cat_name']!
                                            .length *
                                        width *
                                        0.04),
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
                                maxHeight: height * 0.54,
                              ),
                              // height: height * 0.45,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                          hintText: 'Eg 3',
                                          controller: _bedroomController,
                                          keyboardType: TextInputType.number,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          suffixIcon: const DarkTextChip(
                                              text: 'Bedroom'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter the Bedroom count';
                                            }

                                            final bedroomCount =
                                                int.tryParse(value);
                                            if (bedroomCount == null) {
                                              return 'Please enter a valid Bedroom count';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: cons.maxWidth * 0.435,
                                        child: CustomTextField(
                                          hintText: 'Eg 3',
                                          controller: _bathroomController,
                                          keyboardType: TextInputType.number,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          suffixIcon: const DarkTextChip(
                                              text: 'Bathroom'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter the Bathroom count';
                                            }

                                            final bedroomCount =
                                                int.tryParse(value);
                                            if (bedroomCount == null) {
                                              return 'Please enter a valid Bathroom count';
                                            }

                                            return null;
                                          },
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
                                  kHeight10,
                                  SizedBox(
                                    height: height * 0.08,
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      alignment: WrapAlignment.spaceEvenly,
                                      runAlignment: WrapAlignment.center,
                                      children: [
                                        CustomDropDownButton(
                                          initialValue: saleType,
                                          hideValidationError:
                                              saleType != null ||
                                                  _checkValidation == false,
                                          hint: Text(
                                            'sale type',
                                            style: TextStyle(
                                                color: kWhiteColor
                                                    .withOpacity(0.7)),
                                          ),
                                          maxWidth: width * 0.27,
                                          itemList:
                                              RealEstateDropdownList.saleType,
                                          onChanged: (String? value) {
                                            saleType = value!;
                                          },
                                        ),
                                        CustomDropDownButton(
                                          initialValue: listedBy,
                                          hideValidationError:
                                              listedBy != null ||
                                                  _checkValidation == false,
                                          hint: Text(
                                            'listed by',
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
                                          hideValidationError: facing != null ||
                                              _checkValidation == false,
                                          hint: Text(
                                            'facing',
                                            style: TextStyle(
                                                color: kWhiteColor
                                                    .withOpacity(0.7)),
                                          ),
                                          maxWidth: width * 0.25,
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
                              hintText: 'Ads Price',
                              controller: _adsPriceController,
                              hideValidationError:
                                  _adsPriceController.text.trim().isNotEmpty ||
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
                                                    CustomDropDownButton(
                                                  initialValue: roadWidth,
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
                                        kHeight5,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: cons.maxWidth * 0.435,
                                                child: CustomTextField(
                                                  hintText: 'Eg 3',
                                                  controller:
                                                      _floorNoController,
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
                                                          text: 'No of Floors'),
                                                )),
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
                                                )),
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
                                                      text: 'Age of Building'),
                                                )),
                                            SizedBox(
                                                width: cons.maxWidth * 0.435,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ImageUploadDotedCircle(
                                                      color: kBlackColor,
                                                      documentTypeName:
                                                          'Land\nSketch',
                                                      networkImageUrl:
                                                          otherImageUrl
                                                              .firstWhere(
                                                        (map) =>
                                                            map['image_type'] ==
                                                            'land_sketch',
                                                        orElse: () => {},
                                                      )?['url'],
                                                      imageFile: otherImageFiles
                                                          .firstWhere(
                                                        (map) =>
                                                            map['image_type'] ==
                                                            'land_sketch',
                                                        orElse: () => {},
                                                      )['file'],
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                AdCreateOrUpdateBloc>()
                                                            .add(const PickOtherImageEvent(
                                                                'land_sketch'));
                                                      },
                                                    ),
                                                    ImageUploadDotedCircle(
                                                      color: kPrimaryColor,
                                                      documentTypeName:
                                                          'Floor\nPlan',
                                                      networkImageUrl:
                                                          otherImageUrl
                                                              .firstWhere(
                                                        (map) =>
                                                            map['image_type'] ==
                                                            'floor_plan',
                                                        orElse: () => {},
                                                      )?['url'],
                                                      imageFile: otherImageFiles
                                                          .firstWhere(
                                                        (map) =>
                                                            map['image_type'] ==
                                                            'floor_plan',
                                                        orElse: () => {},
                                                      )['file'],
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                AdCreateOrUpdateBloc>()
                                                            .add(const PickOtherImageEvent(
                                                                'floor_plan'));
                                                      },
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                        kHeight5,
                                        SizedBox(
                                          width: double.infinity,
                                          height: height * 0.09,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomDropDownButton(
                                                initialValue:
                                                    constructionStatus,
                                                hint: Text(
                                                  'construction status',
                                                  style: TextStyle(
                                                      color: kWhiteColor
                                                          .withOpacity(0.7)),
                                                ),
                                                itemList: RealEstateDropdownList
                                                    .constructionStatus,
                                                maxWidth: width * 0.44,
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
                                                itemList: RealEstateDropdownList
                                                    .furnishing,
                                                maxWidth: width * 0.38,
                                                onChanged: (String? value) {
                                                  furnishing = value!;
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        kHeight15,
                                        CustomTextField(
                                          hintText:
                                              'Land marks near your Villa',
                                          controller: _landMarksController,
                                          fillColor: kWhiteColor,
                                        ),
                                        kHeight10,
                                        CustomTextField(
                                          fillColor: kWhiteColor,
                                          hintText:
                                              'Website link of your Villa',
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
          //  bottom continue button
          bottomNavigationBar: SizedBox(
            width: double.infinity,
            height: height * 0.09,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ButtonWithRightSideIcon(
                onPressed: () {
                  _saveChangesAndContinue(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Scaffold _loadingScaffoldWidget(AdCreateOrUpdateState state) {
    return Scaffold(
      body: Center(
        child: state is FaildToFetchExceptionState
            ? Text(state.errorMessagge)
            : const CircularProgressIndicator(),
      ),
    );
  }

  void _initializeUpdatingAdData(AdCreateOrUpdateModel adUpdateModel) {
    log(adUpdateModel.toString());
    final primaryData = adUpdateModel.primaryData;
    final moreInfoData = adUpdateModel.moreInfoData;
    _titleController.text = adUpdateModel.adsTitle;
    _descriptionController.text = adUpdateModel.description;
    _brandNameController.text =
        primaryData['Brand Name'] ?? "Dummy Brand Name is Null";
    _bedroomController.text = primaryData['Bedroom'];
    _bathroomController.text = primaryData['Bathroom'];
    _propertyAreaController.text = primaryData['Property Area']['value'];
    propertyArea = primaryData['Property Area']['dropname'];
    _buildupAreaController.text = primaryData['Buildup Area']['value'];
    buildupArea = primaryData['Buildup Area']['dropname'];
    saleType = primaryData['Sale Type'];
    listedBy = primaryData['Listed By'];
    facing = primaryData['Facing'];

    //-----------------------------------------------------------------

    _adsPriceController.text = '10000'; //---------------------------------
    _roadWidthController.text = moreInfoData['Road Width']['value'];
    roadWidth = moreInfoData['Road Width']['dropname'];
    _carpetAreaController.text = moreInfoData['Carpet Area']['value'];
    carpetArea =
        'sq.feet'; //moreInfoData['Carpet Area']['dropname'];//    ERROR
    _floorNoController.text = moreInfoData['Floor No'];
    _parkingController.text = moreInfoData['Parking'];
    _ageOfBuildingController.text = moreInfoData['Age Of Building'];
    constructionStatus = moreInfoData['Construction Status'];
    furnishing = moreInfoData['Furnishing'];
    _landMarksController.text = moreInfoData['Landmark'];
    _websiteLinkController.text = moreInfoData['Website Link'];
  }

  _saveChangesAndContinue(BuildContext context) {
    _checkValidation = true;
    context
        .read<AdCreateOrUpdateBloc>()
        .add(AdCreateOrUpdateCheckDropDownValidattionEvent());
    if (_formKey.currentState!.validate() &&
        saleType != null &&
        listedBy != null &&
        facing != null &&
        _adsPriceController.text.trim().isNotEmpty) {
      final Map<String, dynamic> primaryInfo = {
        'Brand Name': _brandNameController.text,
        'Bedroom': _bedroomController.text,
        'Bathroom': _bathroomController.text,
        'Property Area': {
          "value": _propertyAreaController.text,
          "dropname": propertyArea
        },
        'Buildup Area': {
          "value": _buildupAreaController.text,
          "dropname": buildupArea
        },
        'Sale Type': saleType!,
        'Listed By': listedBy!,
        'Facing': facing!,
      };
      final Map<String, dynamic> moreInfo = {
        'Road Width': {
          'value': _roadWidthController.text,
          'dropname': roadWidth,
        },
        'Carpet Area': {
          'value': _carpetAreaController.text,
          'dropname': carpetArea,
        },
        'Floor No': _floorNoController.text,
        'Parking': _parkingController.text,
        'Age Of Building': _ageOfBuildingController.text,
        'Construction Status': constructionStatus,
        'Furnishing': furnishing,
        'Landmark': _landMarksController.text,
        'Website Link': _websiteLinkController.text,
      };

      context.read<AdCreateOrUpdateBloc>().savePrimaryMoreInfoDetails(
        adsTitle: _titleController.text,
        description: _descriptionController.text,
        prymaryInfo: primaryInfo,
        moreInfo: moreInfo,
        // level4Sub: building4saleCommercial[_level4Cat.value]['cat_name'],
        adPrice: '',
        adsLevels: {
          "route": houseAndVillaForSaleRoot,
          "sub category": Null,
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
    _bedroomController.dispose();
    _bathroomController.dispose();
    _buildupAreaController.dispose();
    _roadWidthController.dispose();
    _adsPriceController.dispose();
    _carpetAreaController.dispose();
    _floorNoController.dispose();
    _parkingController.dispose();
    _ageOfBuildingController.dispose();
    _landMarksController.dispose();
    _websiteLinkController.dispose();

    super.dispose();
  }
}
