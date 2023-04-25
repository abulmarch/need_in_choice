import 'package:flutter/material.dart';
import 'package:need_in_choice/views/pages/home_page/home_screen.dart';
import 'package:need_in_choice/views/pages/home_page/widgets.dart/bottom_navigation_bar.dart';
import '../chat_page/chat_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  MainNavigationScreen({super.key, required this.selectIndex});
  final int selectIndex;
  final _pages = <Widget>[
    HomePageScreen(),
    const ChatScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    indexChangeNotifier.value = selectIndex;
    return Scaffold(
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
          border: Border.all(color: Colors.white, width: 8, style: BorderStyle.solid),
          boxShadow: const [
            BoxShadow(
              color: Color(0x9AD2D2D2),
              blurRadius: 6,
              offset: Offset(0, 8)
            ),
            BoxShadow(
              color: Color(0xDFBBBBBB),
              blurRadius: 15,
              offset: Offset(0, 7)
            ),
          ]
        ),
        child: FloatingActionButton( 
          
          elevation: 0,
          child: const Icon(Icons.add,size: 50,shadows: [
            BoxShadow(
              color: Color(0xFF545454),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ]),        
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavigationBarWidget()
    );
  }
}


