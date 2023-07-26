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
import '../../../widgets_refactored/lottie_widget.dart';

class ApartmentSaleScreen extends StatefulWidget {
  const ApartmentSaleScreen({super.key});

  @override
  State<ApartmentSaleScreen> createState() => _ApartmentSaleScreenState();
}

class _ApartmentSaleScreenState extends State<ApartmentSaleScreen> {
  final ValueNotifier<bool> _addMoreEnabled = ValueNotifier(false); // false
  final _formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _brandNameController;
  late TextEditingController _buildupAreaController;
  late TextEditingController _bedroomController;
  late TextEditingController _bathroomController;
  late TextEditingController _roadWidthController;
  late TextEditingController _adsPriceController;
  late TextEditingController _totalFloorController;
  late TextEditingController _carpetAreaController;
  late TextEditingController _floorNoController;
  late TextEditingController _parkingController;
  late TextEditingController _ageOfBuildingController;
  late TextEditingController _landMarksController;
  late TextEditingController _websiteLinkController;

  late List<String> selectedAmenities = [];

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
    _buildupAreaController = TextEditingController();
    _bedroomController = TextEditingController();
    _bathroomController = TextEditingController();
    _roadWidthController = TextEditingController();
    _adsPriceController = TextEditingController();
    _carpetAreaController = TextEditingController();
    _totalFloorController = TextEditingController();
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
      currentPageRoute: appartmentAndFlatForSaleRoot,
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
                              'Apartment & Flat',
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
                                        .055),
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
                                          hintText: 'Eg 3',
                                          controller: _floorNoController,
                                          keyboardType: TextInputType.number,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          suffixIcon: const DarkTextChip(
                                              text: 'Floor No'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter the Floor count';
                                            }

                                            final bedroomCount =
                                                int.tryParse(value);
                                            if (bedroomCount == null) {
                                              return 'Please enter a valid Floor count';
                                            }

                                            return null;
                                          },
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
                                                fillColor: kWhiteColor,
                                                controller:
                                                    _roadWidthController,
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
                                              ),
                                            ),
                                            SizedBox(
                                              width: cons.maxWidth * 0.435,
                                              child: CustomTextField(
                                                hintText: 'Carpet Area',
                                                fillColor: kWhiteColor,
                                                controller:
                                                    _carpetAreaController,
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
                                                controller:
                                                    _totalFloorController,
                                                hintText: 'Eg 3',
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
                                              ),
                                            ),
                                            SizedBox(
                                              height: 70,
                                              width: 70,
                                              child: ImageUploadDotedCircle(
                                                color: kPrimaryColor,
                                                documentTypeName: 'Floor\nPlan',
                                                networkImageUrl:
                                                    otherImageUrl.firstWhere(
                                                  (map) =>
                                                      map['image_type'] ==
                                                      'Floor Plan',
                                                  orElse: () => {},
                                                )?['url'],
                                                imageFile:
                                                    otherImageFiles.firstWhere(
                                                  (map) =>
                                                      map['image_type'] ==
                                                      'Floor Plan',
                                                  orElse: () => {},
                                                )['file'],
                                                onTap: () {
                                                  context
                                                      .read<
                                                          AdCreateOrUpdateBloc>()
                                                      .add(
                                                          const PickOtherImageEvent(
                                                              'Floor Plan'));
                                                },
                                              ),
                                            ),
                                            kWidth20
                                          ],
                                        ),
                                        kHeight5,
                                        SizedBox(
                                          width: double.infinity,
                                          height: height * 0.08,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                                maxWidth: width * 0.35,
                                                onChanged: (String? value) {
                                                  furnishing = value!;
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        kHeight15,
                                        SizedBox(
                                          height: height * .4,
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
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 18,
                                                              color:
                                                                  kGreyColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.33,
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
                                                        children: [
                                                          AmenitiesContainer(
                                                            text: 'Wifi',
                                                            color: kWhiteColor,
                                                            width: width * 0.15,
                                                            textcolor:
                                                                kSecondaryColor,
                                                            selected:
                                                                selectedAmenities
                                                                    .contains(
                                                                        'Wifi'),
                                                            onSelected: () {
                                                              _toggleDaySelection(
                                                                  'Wifi');
                                                            },
                                                          ),
                                                          AmenitiesContainer(
                                                            text:
                                                                'basement car parking',
                                                            color: kWhiteColor,
                                                            width: width * 0.5,
                                                            textcolor:
                                                                kSecondaryColor,
                                                            selected:
                                                                selectedAmenities
                                                                    .contains(
                                                                        'basement car parking'),
                                                            onSelected: () {
                                                              _toggleDaySelection(
                                                                  'basement car parking');
                                                            },
                                                          ),
                                                          AmenitiesContainer(
                                                            text: 'Lift',
                                                            color: kWhiteColor,
                                                            width: width * 0.15,
                                                            textcolor:
                                                                kSecondaryColor,
                                                            selected:
                                                                selectedAmenities
                                                                    .contains(
                                                                        'Lift'),
                                                            onSelected: () {
                                                              _toggleDaySelection(
                                                                  'Lift');
                                                            },
                                                          ),
                                                          AmenitiesContainer(
                                                            text: 'GYM',
                                                            color: kWhiteColor,
                                                            width: width * 0.15,
                                                            textcolor:
                                                                kSecondaryColor,
                                                            selected:
                                                                selectedAmenities
                                                                    .contains(
                                                                        'GYM'),
                                                            onSelected: () {
                                                              _toggleDaySelection(
                                                                  'GYM');
                                                            },
                                                          ),
                                                          AmenitiesContainer(
                                                            text:
                                                                'Gas Pipeline',
                                                            color: kWhiteColor,
                                                            width: width * .35,
                                                            textcolor:
                                                                kSecondaryColor,
                                                            selected:
                                                                selectedAmenities
                                                                    .contains(
                                                                        'Gas Pipeline'),
                                                            onSelected: () {
                                                              _toggleDaySelection(
                                                                  'Gas Pipeline');
                                                            },
                                                          ),
                                                          AmenitiesContainer(
                                                            text:
                                                                'Jogging Track',
                                                            color: kWhiteColor,
                                                            width: width * .33,
                                                            textcolor:
                                                                kSecondaryColor,
                                                            selected:
                                                                selectedAmenities
                                                                    .contains(
                                                                        'Jogging Track'),
                                                            onSelected: () {
                                                              _toggleDaySelection(
                                                                  'Jogging Track');
                                                            },
                                                          ),
                                                          AmenitiesContainer(
                                                            text: 'intercom',
                                                            color: kWhiteColor,
                                                            width: width * .33,
                                                            textcolor:
                                                                kSecondaryColor,
                                                            selected:
                                                                selectedAmenities
                                                                    .contains(
                                                                        'intercom'),
                                                            onSelected: () {
                                                              _toggleDaySelection(
                                                                  'intercom');
                                                            },
                                                          ),
                                                          AmenitiesContainer(
                                                            text: 'fire safety',
                                                            color: kWhiteColor,
                                                            width: width * .33,
                                                            textcolor:
                                                                kSecondaryColor,
                                                            selected:
                                                                selectedAmenities
                                                                    .contains(
                                                                        'fire safety'),
                                                            onSelected: () {
                                                              _toggleDaySelection(
                                                                  'fire safety');
                                                            },
                                                          ),
                                                          AmenitiesContainer(
                                                            text:
                                                                'rain water harvest',
                                                            color: kWhiteColor,
                                                            width: width * .39,
                                                            textcolor:
                                                                kSecondaryColor,
                                                            selected:
                                                                selectedAmenities
                                                                    .contains(
                                                                        'rain water harvest'),
                                                            onSelected: () {
                                                              _toggleDaySelection(
                                                                  'rain water harvest');
                                                            },
                                                          ),
                                                          AmenitiesContainer(
                                                            text:
                                                                'covered parking',
                                                            color: kWhiteColor,
                                                            width: width * .35,
                                                            textcolor:
                                                                kSecondaryColor,
                                                            selected:
                                                                selectedAmenities
                                                                    .contains(
                                                                        'covered parking'),
                                                            onSelected: () {
                                                              _toggleDaySelection(
                                                                  'covered parking');
                                                            },
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
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              kGreyColor),
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          'More',
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
                                                                  width: width *
                                                                      0.21,
                                                                  child:
                                                                      const Divider(
                                                                    thickness:
                                                                        2,
                                                                    color:
                                                                        kWhiteColor,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          kWidth10,
                                                          Container(
                                                            width: width * 0.07,
                                                            height:
                                                                height * 0.07,
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  kWhiteColor,
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_outlined,
                                                              color:
                                                                  kPrimaryColor,
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
                                        CustomTextField(
                                          hintText:
                                              'Land marks near your Restaurant',
                                          fillColor: kWhiteColor,
                                          controller: _landMarksController,
                                        ),
                                        kHeight10,
                                        CustomTextField(
                                          fillColor: kWhiteColor,
                                          controller: _websiteLinkController,
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
                ),
              );
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
      body: state is FaildToFetchExceptionState ? Center(
        child:  Text(state.errorMessagge),
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
    _bedroomController.text = primaryData['Bedroom'];
    _bathroomController.text = primaryData['Bathroom'];
    _floorNoController.text = primaryData['Floor No'];
    _buildupAreaController.text = primaryData['Buildup Area']['value'];
    buildupArea = primaryData['Buildup Area']['dropname'];
    saleType = primaryData['Sale Type'];
    listedBy = primaryData['Listed By'];
    facing = primaryData['Facing'];

    //-----------------------------------------------------------------

    _adsPriceController.text =
        adUpdateModel.adPrice; //---------------------------------
    _roadWidthController.text = moreInfoData['Road Width']['value'];
    roadWidth = moreInfoData['Road Width']['dropname'];
    _carpetAreaController.text = moreInfoData['Carpet Area']['value'];
    carpetArea =
        'sq.feet'; //moreInfoData['Carpet Area']['dropname'];//    ERROR
    _totalFloorController.text = moreInfoData['Total Floor'];
    _parkingController.text = moreInfoData['Parking'];
    _ageOfBuildingController.text = moreInfoData['Age Of Building'];
    constructionStatus = moreInfoData['Construction Status'];
    furnishing = moreInfoData['Furnishing'];
    _landMarksController.text = moreInfoData['Landmark'];
    _websiteLinkController.text = moreInfoData['Website Link'];
  
    selectedAmenities =  moreInfoData['Selected Amenities'];
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
        'Floor No': _floorNoController.text,
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
        'Total Floor': _totalFloorController.text,
        'Parking': _parkingController.text,
        'Age Of Building': _ageOfBuildingController.text,
        'Construction Status': constructionStatus,
        'Furnishing': furnishing,
        'Landmark': _landMarksController.text,
        'Website Link': _websiteLinkController.text,
        'Selected Amenities':selectedAmenities ,
      };

      context.read<AdCreateOrUpdateBloc>().savePrimaryMoreInfoDetails(
        adsTitle: _titleController.text,
        description: _descriptionController.text,
        prymaryInfo: primaryInfo,
        moreInfo: moreInfo,
        // level4Sub: building4saleCommercial[_level4Cat.value]['cat_name'],
        adPrice: _adsPriceController.text,
        adsLevels: {
          "route": appartmentAndFlatForSaleRoot,
          "sub category": null,
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
    _totalFloorController.dispose();
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

  void _toggleDaySelection(String day) {
    setState(() {
      if (selectedAmenities.contains(day)) {
        selectedAmenities.remove(day);
      } else {
        selectedAmenities.add(day);
      }
    });
  }
}

class AmenitiesContainer extends StatelessWidget {
  const AmenitiesContainer({
    super.key,
    required this.text,
    required this.width,
    required this.color,
    required this.textcolor,
    this.selected = false,
    this.onSelected,
  });

  final String text;
  final double width;
  final Color color;
  final Color textcolor;
  final bool selected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        height: 30,
        width: width,
        decoration: BoxDecoration(
          color: selected ? textcolor : color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: selected ? color : textcolor),
        )),
      ),
    );
  }
}
