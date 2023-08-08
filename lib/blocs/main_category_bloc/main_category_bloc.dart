import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils/category_data.dart';

part 'main_category_event.dart';
part 'main_category_state.dart';

class MainCategoryBloc extends Bloc<MainCategoryEvent, MainCategoryState> {
  MainCategoryBloc(CategoryBottomSheetPurpose categoryBottomSheetPurpose) : super(MainCategoryInitial()) {
    on<SelectedLevelOneCat>((event, emit) {
      int index = event.selectedCategory;
      if(mainCategories[index]['is_comming_soon']!=null){
        emit(ComingsoonMainCategory(index));
      }else if(mainCategories[index]['end_of_cat'] == true){
        if (categoryBottomSheetPurpose == CategoryBottomSheetPurpose.forCreateNewAd) {
          emit(PushOrPopToScreen(navigationMode: SelectedNavigationMode.push, routName: mainCategories[index]['root_name']));
        } else {
          emit(PushOrPopToScreen(navigationMode: SelectedNavigationMode.pop, routName: mainCategories[index]['root_name']));
        }
      }else{
        emit(ShowLevelTwoSubCategory(
          level2SubCategoryList: mainCategories[index]['next_cat_list'],
          index: index,
        ));
      }
    });

    on<SelectedLevelTwoCat>((event, emit) {
      Map<String, dynamic> level2Cat = event.selectedLevel2Cat;
      if(level2Cat['end_of_cat'] == true){
        if (categoryBottomSheetPurpose == CategoryBottomSheetPurpose.forCreateNewAd) {
          emit(PushOrPopToScreen(navigationMode: SelectedNavigationMode.push, routName: level2Cat['root_name']));
        } else {
          emit(PushOrPopToScreen(navigationMode: SelectedNavigationMode.pop, routName: level2Cat['root_name']));
        }
      }else{
        emit(ShowLevelThreeSubCategory(level2Cat['next_cat_list']));
      }
    });

    on<SelectedLevelThreeCat>((event, emit) {
      if (categoryBottomSheetPurpose == CategoryBottomSheetPurpose.forCreateNewAd) {
          emit(PushOrPopToScreen(navigationMode: SelectedNavigationMode.push, routName: event.routName));
        } else {
          emit(PushOrPopToScreen(navigationMode: SelectedNavigationMode.pop, routName: event.routName));
        }
    });

    on<DoExtraEvent>((event, emit) {
      if(event.eventType == EventAction.goToPageOne){
        emit(BackToFirstPage());
      }else{
        emit(RefreshPage());
      }        
    });
  }
}

enum SelectedNavigationMode {
  push, pop
}

enum CategoryBottomSheetPurpose{
  forCreateNewAd,
  forSearcinghAd
}
enum EventAction{
  goToPageOne,
  refreshPage
}