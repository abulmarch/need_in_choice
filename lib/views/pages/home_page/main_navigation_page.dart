import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/blocs/main_category_bloc/main_category_bloc.dart'
    show CategoryBottomSheetPurpose;
import 'package:need_in_choice/views/pages/home_page/home_screen.dart';
import 'package:need_in_choice/views/pages/home_page/show_category_bottomsheet.dart';
import 'package:need_in_choice/views/pages/home_page/widgets.dart/bottom_navigation_bar.dart';
import '../../../blocs/all_ads_bloc/all_ads_bloc.dart';
import '../../../services/repositories/all_ads_services.dart';
import '../../../services/repositories/firestore_chat.dart';
import '../chat_page/chat_list_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key, this.selectIndex = 0});
  final int selectIndex;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with WidgetsBindingObserver {
  final _pages = const <Widget>[
    HomePageScreen(),
    ChatListScreen()
    // ChatView()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (WidgetsBinding.instance.lifecycleState != null) {
      FireStoreChat.updateUserActiveStatus(true);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log(state.toString());
    if (state == AppLifecycleState.inactive) {
      FireStoreChat.updateUserActiveStatus(false);
    } else if (state == AppLifecycleState.resumed) {
      FireStoreChat.updateUserActiveStatus(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    log('------------******-----------');
    indexChangeNotifier.value = widget.selectIndex;
    return BlocProvider(
      create: (context) => AllAdsBloc(AllAdsRepo())
        ..add(const FetchAllAds(typeOfFetching: AdsFetchingType.fetchAllAds)),
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () {
            if (indexChangeNotifier.value == 0 ) {
              if (HomePageScreen.selectMainCategory.value > -1 || context.read<AllAdsBloc>().fetchingType != AdsFetchingType.fetchAllAds) {
                HomePageScreen.selectMainCategory.value = -1;
                context.read<AllAdsBloc>().add(BackToFetchAllAds());
                return Future.value(false);
              }
            } else if (indexChangeNotifier.value != 0) {
              indexChangeNotifier.value = 0;
              return Future.value(false);
            }
            return Future.value(true);
          },
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
                        color: Colors.white,
                        width: 8,
                        style: BorderStyle.solid),
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
                      builder: (context) => const ShowCatogoryBottomSheet(
                        purpose: CategoryBottomSheetPurpose.forCreateNewAd,
                      ),
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
      }),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
