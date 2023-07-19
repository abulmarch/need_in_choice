import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/utils/colors.dart';
import '../../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../../services/model/ad_create_or_update_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/level4_category_data.dart';
import '../../../../utils/main_cat_enum.dart';
import '../../../widgets_refactored/circular_back_button.dart';
import '../../../widgets_refactored/condinue_button.dart';
import '../../../widgets_refactored/custom_text_field.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import '../../../widgets_refactored/dotted_border_textfield.dart';
import '../../../widgets_refactored/brand_name_button.dart';

class RealEstateAgencyScreen extends StatefulWidget {
  const RealEstateAgencyScreen({super.key});

  @override
  State<RealEstateAgencyScreen> createState() => _RealEstateAgencyScreenState();
}

class _RealEstateAgencyScreenState extends State<RealEstateAgencyScreen> {
  final _formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _workExperienceController;
  late TextEditingController _areaCoveredController;
  late TextEditingController _landMarksController;
  late TextEditingController _websiteLinkController;
  late TextEditingController _timeRangeController;

  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  late List<String> selectedDays = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _workExperienceController = TextEditingController();
    _areaCoveredController = TextEditingController();
    _landMarksController = TextEditingController();
    _websiteLinkController = TextEditingController();
    _timeRangeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final adCreateOrUpdateBloc = BlocProvider.of<AdCreateOrUpdateBloc>(context);
    adCreateOrUpdateBloc.add(AdCreateOrUpdateInitialEvent(
      // id: 29,
      currentPageRoute: realestateAgencyRoot,
      mainCategory: MainCategory.realestate.name, //'realestate',
    ));

    return BlocBuilder<AdCreateOrUpdateBloc, AdCreateOrUpdateState>(
        builder: (context, state) {
      if (state is FaildToFetchExceptionState ||
          state is AdCreateOrUpdateLoading) {
        return _loadingScaffoldWidget(state);
      } else if (state is AdCreateOrUpdateLoaded &&
          state.adUpdateModel != null) {
        _initializeUpdatingAdData(state.adUpdateModel!);
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
                            'Real Estate Agency',
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
                        minHeight: cons.maxHeight * 0.5,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: cons.maxWidth * 0.435,
                                child: CustomTextField(
                                  hintText: 'Eg 3 Yrs',
                                  controller: _workExperienceController,
                                  keyboardType: TextInputType.number,
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Work Experience';
                                    }

                                    final bedroomCount = int.tryParse(value);
                                    if (bedroomCount == null) {
                                      return 'Please enter a valid Work Experience';
                                    }

                                    return null;
                                  },
                                  suffixIcon: const DarkTextChip(
                                      text: 'Work Experience'),
                                ),
                              ),
                              SizedBox(
                                width: cons.maxWidth * 0.435,
                                child: CustomTextField(
                                  hintText: 'Eg 5 Km',
                                  controller: _areaCoveredController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter a number';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,2}')),
                                  ],
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  suffixIcon:
                                      const DarkTextChip(text: 'Area Covered'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    kHeight10,
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kpadding15),
                      width: double.infinity,
                      color: kButtonColor,
                      constraints: BoxConstraints(
                        minHeight: cons.maxHeight * 0.5,
                        maxHeight: double.infinity,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kHeight20,
                            RichText(
                              text: TextSpan(
                                text: 'Work ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: kDarkGreyColor),
                                children: [
                                  TextSpan(
                                    text: 'Time',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                            color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                            kHeight10,
                            GestureDetector(
                              onTap: () {
                                _showTimeRangePicker(context);
                              },
                              child: Container(
                                height: height * 0.035,
                                width: width * 0.41,
                                decoration: BoxDecoration(
                                    color: kDarkGreyButtonColor,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                    child: Text(
                                  // '10.00 am to 5.00pm',
                                  _selectedStartTime != null &&
                                          _selectedEndTime != null
                                      ? '${_formatTime(_selectedStartTime!)} - ${_formatTime(_selectedEndTime!)}'
                                      : 'Select Time Range',
                                  style: const TextStyle(
                                      color: kWhiteColor,
                                      fontWeight: FontWeight.w300),
                                )),
                              ),
                            ),
                            kHeight15,
                            Container(
                              height: height * 0.09,
                              decoration: BoxDecoration(
                                color: kButtonColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Wrap(
                                    spacing: 7.0,
                                    runSpacing: 8.0,
                                    children: [
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Mon',
                                        selected: selectedDays.contains('Mon'),
                                        onSelected: () {
                                          _toggleDaySelection('Mon');
                                        },
                                      ),
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Tue',
                                        selected: selectedDays.contains('Tue'),
                                        onSelected: () {
                                          _toggleDaySelection('Tue');
                                        },
                                      ),
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Wed',
                                        selected: selectedDays.contains('Wed'),
                                        onSelected: () {
                                          _toggleDaySelection('Wed');
                                        },
                                      ),
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Thu',
                                        selected: selectedDays.contains('Thu'),
                                        onSelected: () {
                                          _toggleDaySelection('Thu');
                                        },
                                      ),
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Fri',
                                        selected: selectedDays.contains('Fri'),
                                        onSelected: () {
                                          _toggleDaySelection('Fri');
                                        },
                                      ),
                                      WorkTimeContainer(
                                        text: 'Sun',
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        selected: selectedDays.contains('Sun'),
                                        onSelected: () {
                                          _toggleDaySelection('Sun');
                                        },
                                      ),
                                      WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: 'Sat',
                                        selected: selectedDays.contains('Sat'),
                                        onSelected: () {
                                          _toggleDaySelection('Sat');
                                        },
                                      ),
                                    ],
                                  ),
                                  kHeight5,
                                ],
                              ),
                            ),
                            DashedLineGenerator(width: width * .9),
                            kHeight15,
                            CustomTextField(
                              hintText: 'Landmarks near your Agency',
                              fillColor: kWhiteColor,
                              controller: _landMarksController,
                            ),
                            kHeight10,
                            CustomTextField(
                              fillColor: kWhiteColor,
                              hintText: 'Website link of your Agency',
                              controller: _websiteLinkController,
                            ),
                            kHeight20
                          ]),
                    ),
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

    _titleController.text = adUpdateModel.adsTitle;
    _descriptionController.text = adUpdateModel.description;
    _workExperienceController.text = primaryData['Work Experience'];
    _areaCoveredController.text = primaryData['Area Covered'];
    _landMarksController.text = primaryData['Landmark'];
    _websiteLinkController.text = primaryData['Website Link'];
    _timeRangeController.text = primaryData['Time Range'];
    final selectedDays = primaryData['Selected Days'] as String;
    // final selectedDaysList = selectedDaysString.split(',');
    //  selectedDays = Set.from(selectedDaysList);
  }

  _saveChangesAndContinue(BuildContext context) {
    context
        .read<AdCreateOrUpdateBloc>()
        .add(AdCreateOrUpdateCheckDropDownValidattionEvent());
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> primaryInfo = {
        'Work Experience': _workExperienceController.text,
        'Area Covered': _areaCoveredController.text,
        'Landmark': _landMarksController.text,
        'Website Link': _websiteLinkController.text,
        'Time Range': {
          'value': selectedDays.fold<String>('', (previousValue, element) => '$previousValue$element, '),
          'groupValue': _timeRangeController.text,
        },
        //  'Time Range': _timeRangeController.text,
        //'Selected Days': selectedDays.toString(),
      };

      context.read<AdCreateOrUpdateBloc>().savePrimaryMoreInfoDetails(
        adsTitle: _titleController.text,
        description: _descriptionController.text,
        prymaryInfo: primaryInfo,
        adsLevels: {
          "route": realestateAgencyRoot,
          "sub category": null,
        },
        moreInfo: {},
        adPrice: '',
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
    _workExperienceController.dispose();
    _areaCoveredController.dispose();
    _landMarksController.dispose();
    _websiteLinkController.dispose();
    _timeRangeController.dispose();
    super.dispose();
  }

  void _toggleDaySelection(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  void _showTimeRangePicker(BuildContext context) async {
    final TimeRange? selectedRange = await showDialog(
      context: context,
      builder: (context) => TimeRangePickerDialog(
        initialStartTime: _selectedStartTime,
        initialEndTime: _selectedEndTime,
      ),
    );

    if (selectedRange != null) {
      setState(() {
        _selectedStartTime = selectedRange.startTime;
        _selectedEndTime = selectedRange.endTime;
      });
      final formattedStartTime = _formatTime(_selectedStartTime!);
      final formattedEndTime = _formatTime(_selectedEndTime!);

      setState(() {
        _timeRangeController.text = '$formattedStartTime - $formattedEndTime';
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

class TimeRange {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  TimeRange({
    required this.startTime,
    required this.endTime,
  });
}

class TimeRangePickerDialog extends StatefulWidget {
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;

  const TimeRangePickerDialog({
    Key? key,
    this.initialStartTime,
    this.initialEndTime,
  }) : super(key: key);

  @override
  _TimeRangePickerDialogState createState() => _TimeRangePickerDialogState();
}

class _TimeRangePickerDialogState extends State<TimeRangePickerDialog> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _startTime = widget.initialStartTime ?? TimeOfDay.now();
    _endTime = widget.initialEndTime ?? TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Time Range'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimePicker(
            label: 'Start Time',
            selectedTime: _startTime,
            onTimeChanged: (time) {
              setState(() {
                _startTime = time;
              });
            },
          ),
          const SizedBox(height: 16),
          _buildTimePicker(
            label: 'End Time',
            selectedTime: _endTime,
            onTimeChanged: (time) {
              setState(() {
                _endTime = time;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
              TimeRange(startTime: _startTime, endTime: _endTime),
            );
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _buildTimePicker({
    required String label,
    required TimeOfDay selectedTime,
    required ValueChanged<TimeOfDay> onTimeChanged,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () {
              _showTimePicker(selectedTime, onTimeChanged);
            },
            child: InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              child: Text(
                _formatTime(selectedTime),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showTimePicker(
    TimeOfDay initialTime,
    ValueChanged<TimeOfDay> onTimeChanged,
  ) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (selectedTime != null) {
      onTimeChanged(selectedTime);
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
