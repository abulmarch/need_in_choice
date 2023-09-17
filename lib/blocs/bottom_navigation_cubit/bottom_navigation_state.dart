part of 'bottom_navigation_cubit.dart';

class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class PageSwitchedState extends BottomNavigationState {
  final int currentPageIndex;

  const PageSwitchedState([this.currentPageIndex = 0]);
  @override
  List<Object> get props => [currentPageIndex];
}
