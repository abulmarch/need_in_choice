import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(const PageSwitchedState());
  // ValueNotifier<bool> 
  void changeTab(int index){
    emit(PageSwitchedState(index));
  }
}
