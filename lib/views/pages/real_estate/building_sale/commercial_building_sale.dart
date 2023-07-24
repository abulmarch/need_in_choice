
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/utils/colors.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';
import '../../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../../services/model/ad_create_or_update_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dropdown_list_items.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../../utils/main_cat_enum.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dotted_border_textfield.dart';
import '../../../widgets_refactored/condinue_button.dart';
import '../../../widgets_refactored/custom_dropdown_button.dart';
import '../../../widgets_refactored/image_upload_doted_circle.dart';
import '../../../widgets_refactored/scrolling_app_bar.dart';


class CommercialBuildingForSale extends StatefulWidget {
   const CommercialBuildingForSale({super.key});

  @override
  State<CommercialBuildingForSale> createState() => _CommercialBuildingForSaleState();
}

class _CommercialBuildingForSaleState extends State<CommercialBuildingForSale> {

    final ValueNotifier<bool> _addMoreEnabled = ValueNotifier(false);// false
    final _formKey = GlobalKey<FormState>();
    late ScrollController _scrollController;
    
    late TextEditingController _titleController;
    late TextEditingController _descriptionController;
    late TextEditingController _brandNameController;
    late TextEditingController _propertyAreaController;
    late TextEditingController _buildupAreaController;
    late TextEditingController _totalFloorController;
    late TextEditingController _adsPriceController;
    late TextEditingController _carpetAreaController;
    late TextEditingController _floorNoController;
    late TextEditingController _parkingController;
    late TextEditingController _ageOfBuildingController;
    late TextEditingController _landMarksController;
    late TextEditingController _websiteLinkController;

    late ValueNotifier<int> _level4Cat;

    String _propertyArea = RealEstateDropdownList.propertyArea.first;
    String _buildupArea = RealEstateDropdownList.buildupArea.first;

    // String? _saleType = RealEstateDropdownList.saleType.first;
    // String? _listedBy = RealEstateDropdownList.listedBy.first;
    // String? _facing = RealEstateDropdownList.facing.first;
    String? _saleType;
    String? _listedBy;
    String? _facing;

    String _carpetArea = RealEstateDropdownList.carpetArea.first;
    String? _constructionStatus;
    String? _furnishing;
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
    _totalFloorController = TextEditingController();
    _adsPriceController = TextEditingController();
    
    _carpetAreaController = TextEditingController();
    _floorNoController = TextEditingController();
    _parkingController = TextEditingController();
    _ageOfBuildingController = TextEditingController();
    _landMarksController = TextEditingController();
    _websiteLinkController = TextEditingController();

    _level4Cat = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    final adCreateOrUpdateBloc = BlocProvider.of<AdCreateOrUpdateBloc>(context);
    final id = ModalRoute.of(context)!.settings.arguments as int?;
    adCreateOrUpdateBloc.add(AdCreateOrUpdateInitialEvent(
        id: id,
        currentPageRoute: commercialBuildingForSaleRoot,
        mainCategory: MainCategory.realestate.name,//'realestate',
    ));
    return BlocBuilder<AdCreateOrUpdateBloc, AdCreateOrUpdateState>(
      builder: (context, state) {    
            List otherImageUrl = [];
            List<Map> otherImageFiles = [];
        if (state is FaildToFetchExceptionState || state is AdCreateOrUpdateLoading) {
          return _loadingScaffoldWidget(state);
        }else if (state is AdCreateOrUpdateLoaded && state.adUpdateModel != null) {
          _initializeUpdatingAdData(state.adUpdateModel!);
        }else if(state is AdCreateOrUpdateValidateState){
          _checkValidation = true;
        }

        if(state is! FaildToFetchExceptionState && state is! AdCreateOrUpdateLoading){
          try {
            otherImageUrl = adCreateOrUpdateBloc.adCreateOrUpdateModel.otherImageUrls;
            otherImageFiles = adCreateOrUpdateBloc.adCreateOrUpdateModel.otherImageFiles;
          } catch (e) {
            log(e.toString());
          }
        }
        return Scaffold(
          backgroundColor: kWhiteColor,
          // scrolling sub-cattegory
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
              }
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
                                              fontSize: 20,
                                              color: kPrimaryColor),
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
                              constraints: const BoxConstraints(
                                minHeight: 255,
                                maxHeight: 320,
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
                                  kHeight15,
                                  CustomTextField(
                                    controller: _brandNameController,
                                    hintText: 'Eg Kh',
                                    suffixIcon: kRequiredAsterisk,
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  kHeight15,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: cons.maxWidth * 0.435,
                                        child: CustomTextField(
                                          controller: _propertyAreaController,
                                          hintText: 'Property Area',
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return 'Please enter a number';
                                            }
                                            return null;
                                          },
                                          inputFormatters: [
                                            // FilteringTextInputFormatter.digitsOnly
                                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                          ],
                                          keyboardType: TextInputType.number,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          suffixIcon: CustomDropDownButton(
                                            initialValue: _propertyArea,
                                            itemList: RealEstateDropdownList.propertyArea,
                                            onChanged: (String? value) {
                                              _propertyArea = value!;
                                            },
                                          ),
                                          // focusNode: ,
                                        ),
                                      ),
                                      SizedBox(
                                        width: cons.maxWidth * 0.435,
                                        child: CustomTextField(
                                          hintText: 'Buildup Area',
                                          controller:  _buildupAreaController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                          ],
                                          keyboardType: TextInputType.number,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return 'Please enter a number';
                                            }
                                            return null;
                                          },
                                          suffixIcon: CustomDropDownButton(
                                            initialValue: _buildupArea,
                                            itemList: RealEstateDropdownList
                                                .buildupArea,
                                            onChanged: (String? value) {
                                              _buildupArea = value!;
                                            },
                                          ),
                                          // focusNode: ,
                                        ),
                                      ),
                                    ],
                                  ),
                                  kHeight5,
                                  SizedBox(
                                    height: 55,
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      alignment: WrapAlignment.spaceEvenly,
                                      runAlignment: WrapAlignment.center,
                                      children: [
                                        CustomDropDownButton(
                                          initialValue: _saleType,
                                          hideValidationError: _saleType != null || _checkValidation == false,
                                          hint: Text(
                                            'sale type',
                                            style: TextStyle(
                                                color: kWhiteColor
                                                    .withOpacity(0.7)),
                                          ),
                                          maxWidth: 100,
                                          itemList:
                                              RealEstateDropdownList.saleType,
                                          onChanged: (String? value) {
                                            _saleType = value!;
                                          },
                                        ),
                                        CustomDropDownButton(
                                          initialValue: _listedBy,
                                          hideValidationError: _listedBy != null || _checkValidation == false,
                                          hint: Text(
                                            'listed by',
                                            style: TextStyle(
                                                color: kWhiteColor
                                                    .withOpacity(0.7)),
                                          ),
                                          maxWidth: 100,
                                          itemList:
                                              RealEstateDropdownList.listedBy,
                                          onChanged: (String? value) {
                                            _listedBy = value!;
                                          },
                                        ),
                                        CustomDropDownButton(
                                          initialValue: _facing,
                                          hideValidationError: _facing != null || _checkValidation == false,
                                          hint: Text(
                                            'facing',
                                            style: TextStyle(color: kWhiteColor.withOpacity(0.7)),
                                          ),
                                          maxWidth: 100,
                                          itemList: RealEstateDropdownList.facing,
                                          onChanged: (String? value) {
                                            _facing = value!;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            kHeight10,
                            DashedLineGenerator(width: cons.maxWidth - 60),
                            kHeight20,
                            DottedBorderTextField(
                              hintText: 'Ads Price',
                              controller: _adsPriceController,
                              hideValidationError: _adsPriceController.text.trim().isNotEmpty || _checkValidation == false,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                              ],           
                            ),
                            kHeight20,
                            ValueListenableBuilder(
                              valueListenable: _addMoreEnabled,
                              builder: (context, isEnabled, _) {
                                if (isEnabled == false) {
                                  return AddMoreInfoButton(
                                    onPressed: () {
                                      _addMoreEnabled.value = !_addMoreEnabled.value;
                                      Future.delayed(const Duration(milliseconds: 100)).then((value) => 
                                        _scrollController.jumpTo(_scrollController.position.maxScrollExtent // cons.maxHeight * 0.8,
                                        )
                                      );
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
                                        kHeight20,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: cons.maxWidth * 0.435,
                                              child: CustomTextField(
                                                hintText: 'Eg 3',
                                                controller: _totalFloorController,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly
                                                ],
                                                keyboardType: TextInputType.number,
                                                fillColor: kWhiteColor,
                                                onTapOutside: (event) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                suffixIcon: const DarkTextChip(
                                                    text: 'Total Floors'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: cons.maxWidth * 0.435,
                                              child: CustomTextField(
                                                hintText: 'Carpet Area',
                                                controller: _carpetAreaController,
                                                fillColor: kWhiteColor,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                                ],
                                                keyboardType: TextInputType.number,
                                                onTapOutside: (event) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                suffixIcon:
                                                    CustomDropDownButton(
                                                  initialValue: _carpetArea,
                                                  itemList:
                                                      RealEstateDropdownList
                                                          .carpetArea,
                                                  onChanged: (String? value) {
                                                    _carpetArea = value!;
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
                                                controller:  _floorNoController,
                                                fillColor: kWhiteColor,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly
                                                ],
                                                keyboardType: TextInputType.number,
                                                onTapOutside: (event) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                suffixIcon: const DarkTextChip(
                                                    text: 'Floor no'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: cons.maxWidth * 0.435,
                                              child: CustomTextField(
                                                hintText: 'Eg 3',
                                                controller: _parkingController,
                                                fillColor: kWhiteColor,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly
                                                ],
                                                keyboardType: TextInputType.number,
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
                                        kHeight10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: cons.maxWidth * 0.435,
                                              child: CustomTextField(
                                                hintText: 'Eg 3',
                                                controller: _ageOfBuildingController,
                                                fillColor: kWhiteColor,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                                ],
                                                keyboardType: TextInputType.number,
                                                onTapOutside: (event) {
                                                  FocusScope.of(context).unfocus();
                                                },
                                                suffixIcon: const DarkTextChip(
                                                    text: 'Age Of Building'),
                                                // focusNode: ,
                                              ),
                                            ),
                                            SizedBox(
                                              width: cons.maxWidth * 0.435,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ImageUploadDotedCircle(
                                                    color: kPrimaryColor,
                                                    documentTypeName: 'Floor\nPlan',
                                                    networkImageUrl: otherImageUrl.firstWhere((map)=>map['image_type'] == 'Floor Plan',orElse: () => {},)?['url'],
                                                    imageFile: otherImageFiles.firstWhere((map) => map['image_type'] == 'Floor Plan',orElse: () => {},)['file'],
                                                    //'adsotherimage/64a9418c1584d3_13380405.jpg',
                                                    onTap: () {
                                                      context.read<AdCreateOrUpdateBloc>().add(const PickOtherImageEvent('Floor Plan'));
                                                    },
                                                  ),
                                                  ImageUploadDotedCircle(
                                                    color: kBlackColor,
                                                    documentTypeName: 'Land\nSketch',
                                                    networkImageUrl: otherImageUrl.firstWhere((map)=>map['image_type'] == 'Land Sketch',orElse: () => {},)?['url'],
                                                    imageFile: otherImageFiles.firstWhere((map) => map['image_type'] == 'Land Sketch',orElse: () => {},)['file'],
                                                    onTap: () {
                                                      context.read<AdCreateOrUpdateBloc>().add(const PickOtherImageEvent('Land Sketch'));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 65,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomDropDownButton(
                                                initialValue: _constructionStatus,
                                                hint: Text(
                                                  'Construction Status',
                                                  style: TextStyle(color: kWhiteColor.withOpacity(0.7)),
                                                ),
                                                itemList: RealEstateDropdownList.constructionStatus,
                                                maxWidth: 160,
                                                onChanged: (String? value) {
                                                  _constructionStatus = value!;
                                                },
                                              ),
                                              CustomDropDownButton(
                                                initialValue: _furnishing,
                                                hint: Text(
                                                  'Furnishing',
                                                  style: TextStyle(
                                                      color: kWhiteColor
                                                          .withOpacity(0.7)),
                                                ),
                                                itemList: RealEstateDropdownList.furnishing,
                                                maxWidth: 130,
                                                onChanged: (String? value) {
                                                  _furnishing = value!;
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        kHeight5,
                                        CustomTextField(
                                          hintText: 'Land marks near your Restaurant',
                                          controller: _landMarksController,
                                          fillColor: kWhiteColor,
                                        ),
                                        kHeight15,
                                        CustomTextField(
                                          fillColor: kWhiteColor,
                                          hintText: 'Website link of your Restaurant',
                                          controller: _websiteLinkController,
                                        ),
                                        kHeight15,
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
            height: 90,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 10),
              child: ButtonWithRightSideIcon(
                onPressed: () {
                  _saveChangesAndContinue(context);
                }
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
        child: state is FaildToFetchExceptionState ? Text(state.errorMessagge) : const CircularProgressIndicator(),
      ),
    );
  }
  void _initializeUpdatingAdData(AdCreateOrUpdateModel adUpdateModel) {
    log(adUpdateModel.toString());
    final primaryData = adUpdateModel.primaryData;
    final moreInfoData = adUpdateModel.moreInfoData;
    _titleController.text = adUpdateModel.adsTitle;
    _descriptionController.text = adUpdateModel.description;
    _brandNameController.text = primaryData['Brand Name'] ?? "Dummy Brand Name is Null";
    _propertyAreaController.text = primaryData['Property Area']['value'];
    _propertyArea = primaryData['Property Area']['dropname'];
    _buildupAreaController.text = primaryData['Buildup Area']['value'];
    _buildupArea = primaryData['Buildup Area']['dropname'];
    _saleType = primaryData['Sale Type'];
    _listedBy = primaryData['Listed By'];
    _facing = primaryData['Facing'];

  //-----------------------------------------------------------------

    _totalFloorController.text = moreInfoData['Total Floors'];
    _adsPriceController.text = '10000';//---------------------------------
    _carpetAreaController.text = moreInfoData['Carpet Area']['value'];
    _carpetArea = 'sq.feet';//moreInfoData['Carpet Area']['dropname'];//    ERROR
    _floorNoController.text = moreInfoData['Floor No'];
    _parkingController.text = moreInfoData['Parking'];
    _ageOfBuildingController.text = moreInfoData['Age Of Building'];
    _constructionStatus = moreInfoData['Construction Status'];
    _furnishing = moreInfoData['Furnishing'];
    _landMarksController.text = moreInfoData['Landmark'];
    _websiteLinkController.text = moreInfoData['Website Link'];
    final index = building4saleCommercial.indexWhere((element) => element['cat_name']?.toLowerCase() == adUpdateModel.level4Sub);
    _level4Cat.value = index >= 0 ? index : 0;
  }
  
  _saveChangesAndContinue(BuildContext context){
    _checkValidation = true;
    context.read<AdCreateOrUpdateBloc>().add(AdCreateOrUpdateCheckDropDownValidattionEvent());
    if (_formKey.currentState!.validate() && _saleType != null && _listedBy != null && _facing != null && _adsPriceController.text.trim().isNotEmpty) {
      final Map<String, dynamic> primaryInfo = {
          'Brand Name' : _brandNameController.text,
          'Property Area': {
                "value": _propertyAreaController.text,
                "dropname": _propertyArea
            },
          'Buildup Area': {
                "value": _buildupAreaController.text,
                "dropname": _buildupArea
            },
          'Sale Type': _saleType!,
          'Listed By': _listedBy!,
          'Facing': _facing!,
        };
      final Map<String, dynamic> moreInfo = {
          'Total Floors': _totalFloorController.text,
          'Carpet Area': {
              'value': _carpetAreaController.text,
              'dropname': _carpetArea,
            },
          'Floor No': _floorNoController.text,
          'Parking': _parkingController.text,
          'Age Of Building': _ageOfBuildingController.text,
          'Construction Status': _constructionStatus,
          'Furnishing': _furnishing,
          'Landmark': _landMarksController.text,
          'Website Link': _websiteLinkController.text,
        };
      
      context.read<AdCreateOrUpdateBloc>().savePrimaryMoreInfoDetails(
        adsTitle: _titleController.text,
        description: _descriptionController.text,
        prymaryInfo: primaryInfo,
        moreInfo: moreInfo,
        level4Sub: building4saleCommercial[_level4Cat.value]['cat_name'],
        adsLevels: {
          "route": commercialBuildingForSaleRoot,
          "sub category": building4saleCommercial[_level4Cat.value]['cat']?.toLowerCase(),
        },
        adPrice: _adsPriceController.text
      );
      Navigator.pushNamed(context, adConfirmScreen,);//
    }
  }
    @override
  void dispose() {
    _scrollController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _brandNameController.dispose();
    _propertyAreaController.dispose();
    _buildupAreaController.dispose();
    _totalFloorController.dispose();
    _adsPriceController.dispose();
    _carpetAreaController.dispose();
    _floorNoController.dispose();
    _parkingController.dispose();
    _ageOfBuildingController.dispose();
    _landMarksController.dispose();
    _websiteLinkController.dispose();
    _level4Cat.dispose();
    super.dispose();
  }


}
