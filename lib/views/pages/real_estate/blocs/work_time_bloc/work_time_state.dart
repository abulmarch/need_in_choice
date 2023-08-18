part of 'work_time_bloc.dart';

class WorkTimeState extends Equatable {
  const WorkTimeState();

  @override
  List<Object> get props => [];
}

class WorkTimeInitial extends WorkTimeState {}

class WorkTimeLoadedState extends WorkTimeState {
  final List<String> selectedDays;

  const WorkTimeLoadedState(this.selectedDays);

  @override
  List<Object> get props => [selectedDays];
}

class WorkTimeSelectedState extends WorkTimeState {
  final String startTime;
  final String endTime;

  const WorkTimeSelectedState(this.startTime, this.endTime);

  @override
  List<Object> get props => [startTime, endTime];
}
