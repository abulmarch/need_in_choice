part of 'work_time_bloc.dart';

class WorkTimeEvent extends Equatable {
  const WorkTimeEvent();

  @override
  List<Object> get props => [];
}
class ToggleDaySelectionEvent extends WorkTimeEvent {
  final String day;
  final List<String> daysList;

  const ToggleDaySelectionEvent(this.day, this.daysList);

   @override
  List<Object> get props => [day, daysList];
}

class SetTimeRangeEvent extends WorkTimeEvent {
  final TimeRange selectedRange;

  const SetTimeRangeEvent(this.selectedRange);

   @override
  List<Object> get props => [selectedRange];
}