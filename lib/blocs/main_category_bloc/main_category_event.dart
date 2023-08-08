part of 'main_category_bloc.dart';

abstract class MainCategoryEvent extends Equatable {
  const MainCategoryEvent();

  @override
  List<Object> get props => [];
}

class SelectedLevelOneCat extends MainCategoryEvent{
  final int selectedCategory;

  const SelectedLevelOneCat(this.selectedCategory); 
}
class SelectedLevelTwoCat extends MainCategoryEvent{
  final Map<String, dynamic> selectedLevel2Cat;

  const SelectedLevelTwoCat(this.selectedLevel2Cat);
}
class SelectedLevelThreeCat extends MainCategoryEvent{
  final String routName;

  const SelectedLevelThreeCat(this.routName);
}
class DoExtraEvent extends MainCategoryEvent{
  final EventAction eventType;

  const DoExtraEvent({required this.eventType});
}


