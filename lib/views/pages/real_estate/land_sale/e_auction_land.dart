import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'  show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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


class EAuctionLandScreen extends StatefulWidget {
  const EAuctionLandScreen({super.key});

  @override
  State<EAuctionLandScreen> createState() => _EAuctionLandScreenState();
}

class _EAuctionLandScreenState extends State<EAuctionLandScreen> {
  final ValueNotifier<bool> _addMoreEnabled = ValueNotifier(false); // false
  final _formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _bankNameController;
  late TextEditingController _branchNameController;
  late TextEditingController _propertyAreaController;
  late TextEditingController _startPriceController;
  late TextEditingController _preBidPriceController;
  late TextEditingController _landMarksController;
  late TextEditingController _websiteLinkController;
   late TextEditingController _startEndDateController;

   DateTime? bidStartDate;
  DateTime? bidEndDate;

  ScrollController scrollController = ScrollController();
  String propertyArea = RealEstateDropdownList.propertyArea.first;
  String? facing;
  bool _checkValidation = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _bankNameController = TextEditingController();
    _branchNameController = TextEditingController();
    _propertyAreaController = TextEditingController();
    _startPriceController = TextEditingController();
    _preBidPriceController = TextEditingController();
    _landMarksController = TextEditingController();
    _websiteLinkController = TextEditingController();
     _startEndDateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
     final id = ModalRoute.of(context)!.settings.arguments as int?;

    final adCreateOrUpdateBloc = BlocProvider.of<AdCreateOrUpdateBloc>(context);
    adCreateOrUpdateBloc.add(AdCreateOrUpdateInitialEvent(
       id: id,
      currentPageRoute: eAuctionLandForSaleRoot,
      mainCategory: MainCategory.realestate.name,
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
                  vertical: kpadding10 / 2, horizontal: kpadding10),
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
                            'E-Auction Project',
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
                                      0.055),
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
                          SizedBox(
                            height: height * 0.53,
                            child: Column(
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
                                      suffixIcon: kRequiredAsterisk,
                                      controller: _branchNameController,
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
                                      width: cons.maxWidth * 0.535,
                                      child: CustomTextField(
                                        hintText: 'Property Area',
                                        onTapOutside: (event) {
                                          FocusScope.of(context).unfocus();
                                        },
                                        controller: _propertyAreaController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Please enter a number';
                                          }
                                          return null;
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        suffixIcon: CustomDropDownButton(
                                          initialValue: propertyArea,
                                          itemList: RealEstateDropdownList
                                              .propertyArea,
                                          onChanged: (String? value) {
                                            propertyArea = value!;
                                          },
                                        ),
                                      ),
                                    ),
                                    CustomDropDownButton(
                                      initialValue: facing,
                                      hideValidationError: facing != null ||
                                          _checkValidation == false,
                                      hint: Text(
                                        'Facing',
                                        style: TextStyle(
                                            color:
                                                kWhiteColor.withOpacity(0.7)),
                                      ),
                                      maxWidth: width * 0.27,
                                      itemList: RealEstateDropdownList.facing,
                                      onChanged: (String? value) {
                                        facing = value!;
                                      },
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () => _selectDate(context, true),
                                      child: Container(
                                        height: height * 0.045,
                                        width: width * 0.36,
                                        decoration: BoxDecoration(
                                            color: kGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child:  Center(
                                            child: Text(
                                               bidStartDate != null
                                              ? _formatDate(bidStartDate)
                                              : 'Bid Start Date',
                                         // 'Bid Start Date',
                                          style:const TextStyle(
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.w400),
                                        )),
                                      ),
                                    ),
                                    GestureDetector(
                                       onTap: () => _selectDate(context, false),
                                      child: Container(
                                        height: height * 0.045,
                                        width: width * 0.36,
                                        decoration: BoxDecoration(
                                            color: kGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child:  Center(
                                            child: Text(
                                         // 'Bid End Date',
                                         bidEndDate != null
                                              ? _formatDate(bidEndDate)
                                              : 'Bid End Date',
                                          style: const TextStyle(
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.w400),
                                        )),
                                      ),
                                    ),
                                  ],
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
                                      minHeight: cons.maxHeight * 0.3,
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
                                          CustomTextField(
                                            width: width * 0.65,
                                            hintText:
                                                'Landmarks near your Project',
                                            fillColor: kWhiteColor,
                                            controller: _landMarksController,
                                          ),
                                          ImageUploadDotedCircle(
                                            color: kBlackColor,
                                            documentTypeName: 'Land\nSketch',
                                            networkImageUrl:
                                                otherImageUrl.firstWhere(
                                              (map) =>
                                                  map['image_type'] ==
                                                  'Land Sketch',
                                              orElse: () => {},
                                            )?['url'],
                                            imageFile:
                                                otherImageFiles.firstWhere(
                                              (map) =>
                                                  map['image_type'] ==
                                                  'Land Sketch',
                                              orElse: () => {},
                                            )['file'],
                                            onTap: () {
                                              context
                                                  .read<AdCreateOrUpdateBloc>()
                                                  .add(
                                                      const PickOtherImageEvent(
                                                          'Land Sketch'));
                                            },
                                          ),
                                        ],
                                      ),
                                      kHeight15,
                                      CustomTextField(
                                        fillColor: kWhiteColor,
                                        hintText:
                                            'Website link of your Project',
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
            height: height * 0.09,
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
    _bankNameController.text =
        primaryData['Bank Name'] ?? "Dummy Bank Name is Null";
    _branchNameController.text =
        primaryData['Branch Name'] ?? "Dummy Branch Name is Null";
    _propertyAreaController.text = primaryData['Property Area']['value'];
    propertyArea = primaryData['Property Area']['dropname'];
facing = primaryData['Facing'];
 _startEndDateController.text = primaryData['Date Range'];

    //-----------------------------------------------------------------
    _startPriceController.text = adUpdateModel.adPrice['Start Price'];
    _preBidPriceController.text = adUpdateModel.adPrice['Prebid'];
    _landMarksController.text = moreInfoData['Landmark'];
    _websiteLinkController.text = moreInfoData['Website Link'];
  }

  _saveChangesAndContinue(BuildContext context) {
    _checkValidation = true;
    context
        .read<AdCreateOrUpdateBloc>()
        .add(AdCreateOrUpdateCheckDropDownValidattionEvent());
    if (_formKey.currentState!.validate() &&
        facing != null &&
        _startPriceController.text.trim().isNotEmpty &&
        _preBidPriceController.text.trim().isNotEmpty) {
      final Map<String, dynamic> primaryInfo = {
        'Bank Name': _bankNameController.text,
        'Branch Name': _branchNameController.text,
        'Property Area': {
          "value": _propertyAreaController.text,
          "dropname": propertyArea
        },
        'Date Range': _startEndDateController.text,
      };
      final Map<String, dynamic> moreInfo = {
        'Landmark': _landMarksController.text,
        'Website Link': _websiteLinkController.text,
      };

      context.read<AdCreateOrUpdateBloc>().savePrimaryMoreInfoDetails(
        adsTitle: _titleController.text,
        description: _descriptionController.text,
        prymaryInfo: primaryInfo,
        moreInfo: moreInfo,
        // level4Sub: building4saleCommercial[_level4Cat.value]['cat_name'],
         adPrice: {
            'Start Price': _startPriceController.text,
            'Prebid': _preBidPriceController.text
          },
        adsLevels: {
          "route": eAuctionLandForSaleRoot,
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
    _bankNameController.dispose();
    _propertyAreaController.dispose();
    _branchNameController.dispose();

    _startPriceController.dispose();
    _preBidPriceController.dispose();
    _landMarksController.dispose();
    _websiteLinkController.dispose();

    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          bidStartDate = picked;
        } else {
          bidEndDate = picked;
        }
        final startDate = _formatDate(bidStartDate);
        final endDate = _formatDate(bidEndDate);
        setState(() {
          _startEndDateController.text = '$startDate - $endDate';
        });
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      final formatter = DateFormat('MMM d');
      return formatter.format(date);
    }
    return '';
  }
}
