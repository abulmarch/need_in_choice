part of 'amenties_bloc.dart';

 class AmentiesEvent extends Equatable {
  const AmentiesEvent();

  @override
  List<Object> get props => [];
}



class ToggleAmentiesSelectionEvent extends AmentiesEvent {
  final String amenties;
  final List<String> amentiesList;

  const ToggleAmentiesSelectionEvent(this.amenties, this.amentiesList);
   @override
  List<Object> get props => [amenties, amentiesList];
}