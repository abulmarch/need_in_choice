part of 'amenties_bloc.dart';

class AmentiesState extends Equatable {
  const AmentiesState();

  @override
  List<Object> get props => [];
}

class AmentiesInitial extends AmentiesState {}

class AmentiesLoadedState extends AmentiesState {
  final List<String> selectedAmenties;

  const AmentiesLoadedState(this.selectedAmenties);

  @override
  List<Object> get props => [selectedAmenties];
}
