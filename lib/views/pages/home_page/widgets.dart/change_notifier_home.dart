import 'package:flutter/material.dart';

class HomeTabController extends ChangeNotifier{
  HomeTabController._internal();
  static HomeTabController instance = HomeTabController._internal();
  factory HomeTabController(){
    return instance;
  }

  static int selectedBottomTab = 1;
  void onBottomNavigationTabChange(int index){
    selectedBottomTab = index;
    notifyListeners();
  }
}