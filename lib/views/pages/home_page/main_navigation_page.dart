import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/views/pages/home_page/home_screen.dart';
import 'package:need_in_choice/views/pages/home_page/widgets.dart/bottom_navigation_bar.dart';
import '../../../blocs/all_ads_bloc/all_ads_bloc.dart';
import '../../../services/repositories/all_ads_services.dart';
import '../chat_page/chat_screen.dart';
import 'show_category_bottomsheet.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key, this.selectIndex = 0});
  final int selectIndex;
  final _pages = const <Widget>[
    HomePageScreen(),
    ChatScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    indexChangeNotifier.value = selectIndex;
    return BlocProvider(
      create: (context) => AllAdsBloc(AllAdsRepo())..add(GetAllAdsFirstFetch()),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFFFFFFFF),
          body: SafeArea(
            child: ValueListenableBuilder<int>(
              valueListenable: indexChangeNotifier,
              builder: (context, currentIndex, _) => _pages[currentIndex],
            ),
          ),
          floatingActionButton: Container(
            width: 95,
            height: 95,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.white, width: 8, style: BorderStyle.solid),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xB1D2D2D2),
                      blurRadius: 20,
                      offset: Offset(-5, 20)),
                  BoxShadow(
                      color: Color(0xB1D2D2D2),
                      blurRadius: 20,
                      offset: Offset(5, 20)),
                ]),
            child: FloatingActionButton(
              elevation: 0,
              child: const Icon(Icons.add, size: 50, shadows: [
                BoxShadow(
                  color: Color(0xFF545454),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ]),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const ShowCatogoryBottomSheet(),
                  backgroundColor: Colors.white.withOpacity(0),
                  enableDrag: false,
                );
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const BottomNavigationBarWidget()),
    );
  }
}
