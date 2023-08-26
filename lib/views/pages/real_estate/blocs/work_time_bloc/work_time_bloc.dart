import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'work_time_event.dart';
part 'work_time_state.dart';

class WorkTimeBloc extends Bloc<WorkTimeEvent, WorkTimeState> {
  WorkTimeBloc() : super(WorkTimeInitial()) {
    on<ToggleDaySelectionEvent>((event, emit) {
      List<String> daysList = List<String>.from(event.daysList);
      if (daysList.contains(event.day)) {
        daysList.remove(event.day);
      } else {
        daysList.add(event.day);
      }

      emit(WorkTimeLoadedState(daysList));
      print('/////////////////////////$daysList');
    });
    on<SetTimeRangeEvent>((event, emit) {
      final startTime = formatTime(event.selectedRange.startTime);
      final endTime = formatTime(event.selectedRange.endTime);
      emit(WorkTimeSelectedState(startTime, endTime));
    });
  }
  String formatTime(TimeOfDay time) {
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
