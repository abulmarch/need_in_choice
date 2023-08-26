import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/utils/colors.dart';
import '../../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../../config/theme/screen_size.dart';
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
import '../../../widgets_refactored/lottie_widget.dart';
import '../blocs/work_time_bloc/work_time_bloc.dart';

class RealEstateAgentScreen extends StatefulWidget {
  const RealEstateAgentScreen({super.key});

  @override
  State<RealEstateAgentScreen> createState() => _RealEstateAgentScreenState();
}

class _RealEstateAgentScreenState extends State<RealEstateAgentScreen> {
  final _formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _workExperienceController;
  late TextEditingController _areaCoveredController;
  late TextEditingController _landMarksController;
  late TextEditingController _websiteLinkController;

  String? _selectedStartTime;
  String? _selectedEndTime;

  late List<String> _selectedDays = [];
  bool _checkValidation = false;

  final List<String> daysList = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

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
  }

  @override
  Widget build(BuildContext context) {
    final height = ScreenSize.height;
    final width = ScreenSize.width;
    final id = ModalRoute.of(context)!.settings.arguments as int?;

    final adCreateOrUpdateBloc = BlocProvider.of<AdCreateOrUpdateBloc>(context);
    adCreateOrUpdateBloc.add(AdCreateOrUpdateInitialEvent(
      id: id,
      currentPageRoute: realestateAgentRoot,
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
                            'Real Estate Agent',
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
                                      0.052),
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
                                  hintText: 'Work Experience',
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
                                  suffixIcon: const DarkTextChip(text: 'year'),
                                ),
                              ),
                              SizedBox(
                                width: cons.maxWidth * 0.435,
                                child: CustomTextField(
                                  hintText: 'Area Covered',
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
                                  suffixIcon: const DarkTextChip(text: 'km'),
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
                      child: BlocProvider(
                        create: (context) => WorkTimeBloc(),
                        child: BlocBuilder<WorkTimeBloc, WorkTimeState>(
                            builder: (context, state) {
                          if (state is WorkTimeLoadedState) {
                            _selectedDays = state.selectedDays;
                          } else if (state is WorkTimeSelectedState) {
                            _selectedStartTime = state.startTime;
                            _selectedEndTime = state.endTime;
                          }

                          return Column(
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
                                ElevatedButton(
                                  onPressed: () async {
                                    _showTimeRangePicker(context)
                                        .then((selectedRange) {
                                      if (selectedRange != null) {
                                        context.read<WorkTimeBloc>().add(
                                            SetTimeRangeEvent(selectedRange));
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    maximumSize:
                                        Size(width * .45, height * .04),
                                    minimumSize:
                                        Size(width * .2, height * 0.01),
                                    shadowColor: kPrimaryColor,
                                    backgroundColor: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    elevation: 10,
                                    side: _selectedStartTime == null &&
                                            _selectedEndTime == null &&
                                            _checkValidation
                                        ? const BorderSide(color: Colors.red)
                                        : BorderSide.none,
                                  ),
                                  child: Center(
                                    child: Text(
                                      //'10.00 am to 5.00pm',
                                      _selectedStartTime != null &&
                                              _selectedEndTime != null
                                          ? '$_selectedStartTime to $_selectedEndTime'
                                          : 'Select Time Range',
                                      style: const TextStyle(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                kHeight15,
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: _selectedDays.isEmpty &&
                                            _checkValidation
                                        ? Border.all(color: Colors.red)
                                        : null,
                                  ),
                                  child: Wrap(
                                    spacing: 7.0,
                                    runSpacing: 8.0,
                                    children: List<Widget>.generate(
                                      daysList.length,
                                      (index) => WorkTimeContainer(
                                        color: kWhiteColor,
                                        textcolor: kPrimaryColor,
                                        text: daysList[index], // 'Mon'
                                        selected: _selectedDays
                                            .contains(daysList[index]),
                                        onSelected: () {
                                          BlocProvider.of<WorkTimeBloc>(context)
                                              .add(ToggleDaySelectionEvent(
                                                  daysList[index],
                                                  _selectedDays));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                DashedLineGenerator(width: width * .9),
                                kHeight15,
                                CustomTextField(
                                  hintText: 'Landmarks near your Agent',
                                  fillColor: kWhiteColor,
                                  controller: _landMarksController,
                                ),
                                kHeight10,
                                CustomTextField(
                                  fillColor: kWhiteColor,
                                  hintText: 'Website link of your Agent',
                                  controller: _websiteLinkController,
                                ),
                                kHeight20
                              ]);
                        }),
                      ),
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
      body: state is FaildToFetchExceptionState
          ? Center(
              child: Text(state.errorMessagge),
            )
          : LottieWidget.loading(),
    );
  }

  void _initializeUpdatingAdData(AdCreateOrUpdateModel adUpdateModel) {
    final primaryData = adUpdateModel.primaryData;

    final daysListed = primaryData['Time Range']['value'];
    if (daysListed is List) {
      _selectedDays = List<String>.from(daysListed);
    } else if (daysListed is String) {
      _selectedDays = [daysListed];
    }

    _titleController.text = adUpdateModel.adsTitle;
    _descriptionController.text = adUpdateModel.description;
    _workExperienceController.text = primaryData['Work Experience']['value'];
    _areaCoveredController.text = primaryData['Area Covered']['value'];
    _landMarksController.text = primaryData['Landmark'];
    _websiteLinkController.text = primaryData['Website Link'];

    final groupValue = primaryData['Time Range']['groupValue'].split(' - ');
    _selectedStartTime = groupValue[0];
    _selectedEndTime = groupValue[1];
  }

  _saveChangesAndContinue(BuildContext context) {
    _checkValidation = true;
    context
        .read<AdCreateOrUpdateBloc>()
        .add(AdCreateOrUpdateCheckDropDownValidattionEvent());
    if (_formKey.currentState!.validate() &&
        _selectedDays.isNotEmpty &&
        _selectedStartTime!.isNotEmpty) {
      final Map<String, dynamic> primaryInfo = {
        'Work Experience': {
          'value': _workExperienceController.text,
          'unit': 'yrs',
        },
        'Area Covered': {
          'value': _areaCoveredController.text,
          'unit': 'km',
        },
        'Landmark': _landMarksController.text,
        'Website Link': _websiteLinkController.text,
        'Time Range': {
          "value": _selectedDays,
          'groupValue': '$_selectedStartTime - $_selectedEndTime',
        },
      };

      context.read<AdCreateOrUpdateBloc>().savePrimaryMoreInfoDetails(
        adsTitle: _titleController.text,
        description: _descriptionController.text,
        prymaryInfo: primaryInfo,
        adsLevels: {
          "route": realestateAgentRoot,
          "sub category": null,
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
    _workExperienceController.dispose();
    _areaCoveredController.dispose();
    _landMarksController.dispose();
    _websiteLinkController.dispose();
    super.dispose();
  }

  Future<TimeRange?> _showTimeRangePicker(BuildContext context) async {
    return await showDialog<TimeRange?>(
      context: context,
      builder: (context) => const TimeRangePickerDialog(),
    );
  }

  String timeFormat(TimeOfDay selectedStartTime, TimeOfDay selectedEndTime) {
    return '${context.read<WorkTimeBloc>().formatTime(selectedStartTime)} - ${context.read<WorkTimeBloc>().formatTime(selectedEndTime)}';
  }
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
  State<TimeRangePickerDialog> createState() => _TimeRangePickerDialogState();
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
