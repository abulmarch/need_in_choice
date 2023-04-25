import 'package:flutter/material.dart';



ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);
class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, currentIndex, _) => BottomNavigationBar(
          iconSize: 30,
          elevation: 20,
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          onTap: (value) {
            indexChangeNotifier.value = value;
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(label: 'Home',icon: Icon(Icons.home_outlined),activeIcon: Icon(Icons.home),),
            // BottomNavigationBarItem(label: '',icon: Icon(Icons.add,color: Colors.white),backgroundColor: Colors.white,),
            BottomNavigationBarItem(label: 'Chat',icon: Icon(Icons.sms_outlined),activeIcon: Icon(Icons.sms),)
          ],
        )
    );
  }
}