part of 'main_category_bloc.dart';

abstract class MainCategoryState extends Equatable {
  const MainCategoryState();
  
  @override
  List<Object> get props => [];
}

class MainCategoryInitial extends MainCategoryState {}

class ShowLevelTwoSubCategory extends MainCategoryState {
  final int index;
  final List<Map<String, dynamic>> level2SubCategoryList;

  const ShowLevelTwoSubCategory({required this.level2SubCategoryList, required this.index});
  @override
  List<Object> get props => [index];
}
class ShowLevelThreeSubCategory extends MainCategoryState {
  final List<Map<String, dynamic>> level3SubCategoryList;

  const ShowLevelThreeSubCategory(this.level3SubCategoryList);
}

class ComingsoonMainCategory extends MainCategoryState{
  final int index;
  const ComingsoonMainCategory(this.index);

  @override
  List<Object> get props => [index];
}

class PushOrPopToScreen extends MainCategoryState {
  final SelectedNavigationMode navigationMode;
  final String routName;
  const PushOrPopToScreen({required this.navigationMode, required this.routName});
}

class BackToFirstPage extends MainCategoryState {}
class RefreshPage extends MainCategoryState {}