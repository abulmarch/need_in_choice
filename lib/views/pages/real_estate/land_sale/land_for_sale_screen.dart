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
import '../../../widgets_refactored/image_upload_doted_circle.dart';
import '../../../widgets_refactored/lottie_widget.dart';
import '../../../widgets_refactored/scrolling_app_bar.dart';

class LandForSaleScreen extends StatefulWidget {
  const LandForSaleScreen({super.key});

  @override
  State<LandForSaleScreen> createState() => _LandForSaleScreenState();
}

class _LandForSaleScreenState extends State<LandForSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _landAreaController;
  late TextEditingController _adsPriceController;

  late ValueNotifier<int> _level4Cat;

  ScrollController scrollController = ScrollController();
  String _propertyArea = RealEstateDropdownList.propertyArea.first;
  String? _listedBy;
  String? _facing;
  bool _checkValidation = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _landAreaController = TextEditingController();
    _adsPriceController = TextEditingController();

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
      currentPageRoute: landForSaleRoot,
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
            child: ValueListenableBuilder<int>(
                valueListenable: _level4Cat,
                builder: (context, selectedIndex, _) {
                  return ScrollingAppBarLevel4Category(
                    selectedIndex: selectedIndex,
                    level4List: land4saleLevel4Cat,
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
                                              land4saleLevel4Cat[selectedIndex]
                                                  ['cat_name']!,
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
                                                    width: land4saleLevel4Cat[
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: cons.maxWidth * 0.635,
                                    child: CustomTextField(
                                      hintText: 'Land Area',
                                      controller: _landAreaController,
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
                                        initialValue: _propertyArea,
                                        itemList:
                                            RealEstateDropdownList.propertyArea,
                                        onChanged: (String? value) {
                                          _propertyArea = value!;
                                        },
                                      ),
                                      // focusNode: ,
                                    ),
                                  ),
                                  ImageUploadDotedCircle(
                                    color: kBlackColor,
                                    documentTypeName: 'Land\nSketch',
                                    networkImageUrl: otherImageUrl.firstWhere(
                                      (map) =>
                                          map['image_type'] == 'Land Sketch',
                                      orElse: () => {},
                                    )?['url'],
                                    imageFile: otherImageFiles.firstWhere(
                                      (map) =>
                                          map['image_type'] == 'Land Sketch',
                                      orElse: () => {},
                                    )['file'],
                                    onTap: () {
                                      context.read<AdCreateOrUpdateBloc>().add(
                                          const PickOtherImageEvent(
                                              'Land Sketch'));
                                    },
                                  ),
                                ],
                              ),
                              kHeight10,
                              SizedBox(
                                height: height * 0.05,
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceEvenly,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    CustomDropDownButton(
                                      initialValue: _facing,
                                      hideValidationError: _facing != null ||
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
                                        _facing = value!;
                                      },
                                    ),
                                    CustomDropDownButton(
                                      initialValue: _listedBy,
                                      hideValidationError: _listedBy != null ||
                                          _checkValidation == false,
                                      hint: Text(
                                        'Listed by',
                                        style: TextStyle(
                                            color:
                                                kWhiteColor.withOpacity(0.7)),
                                      ),
                                      maxWidth: width * 0.27,
                                      itemList: RealEstateDropdownList.listedBy,
                                      onChanged: (String? value) {
                                        _listedBy = value!;
                                      },
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
                                hideValidationError: _adsPriceController.text
                                        .trim()
                                        .isNotEmpty ||
                                    _checkValidation == false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                    left: 20, right: 20, bottom: 20, top: 10),
                child: ButtonWithRightSideIcon(onPressed: () {
                  
                  _saveChangesAndContinue(context);
                }),
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

    _titleController.text = adUpdateModel.adsTitle;
    _descriptionController.text = adUpdateModel.description;
    _landAreaController.text = primaryData['Land Area']['value'];
    _propertyArea = primaryData['Land Area']['unit'];

    _listedBy = primaryData['Listed By'];
    _facing = primaryData['Facing'];

    //-----------------------------------------------------------------
    _adsPriceController.text = adUpdateModel.adPrice;
    final String subCategory = adUpdateModel.adsLevels['sub category'];
    final index = land4saleLevel4Cat.indexWhere(
        (level) => (level['cat_name'] as String).toLowerCase() == subCategory);
    if (index != -1) {
      _level4Cat.value = index;
    }
  }

  _saveChangesAndContinue(BuildContext context) {
    _checkValidation = true;
    context
        .read<AdCreateOrUpdateBloc>()
        .add(AdCreateOrUpdateCheckDropDownValidattionEvent());
    if (_formKey.currentState!.validate() &&
        _listedBy != null &&
        _facing != null &&
        _adsPriceController.text.trim().isNotEmpty) {
      final Map<String, dynamic> primaryInfo = {
        'Land Area': {"value": _landAreaController.text, "unit": _propertyArea},
        'Listed By': _listedBy!,
        'Facing': _facing!,
      };

      context.read<AdCreateOrUpdateBloc>().savePrimaryMoreInfoDetails(
        adsTitle: _titleController.text,
        description: _descriptionController.text,
        prymaryInfo: primaryInfo,
        level4Sub: land4saleLevel4Cat[_level4Cat.value]['cat_name'],
        adPrice: _adsPriceController.text,
        adsLevels: {
          "route": landForSaleRoot,
          "sub category":
              land4saleLevel4Cat[_level4Cat.value]['cat_name']?.toLowerCase(),
        },
        moreInfo: {},
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
    _landAreaController.dispose();
    _adsPriceController.dispose();
    _level4Cat.dispose();
    super.dispose();
  }
}
