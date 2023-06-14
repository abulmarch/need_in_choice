import 'package:flutter/material.dart';

import 'config/routes/page_routes.dart';
import 'config/routes/route_names.dart';
import 'config/theme/theme_data_class.dart';
import 'package:firebase_core/firebase_core.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Need In Choice',
      theme: ThemeDataPrimary.primaryTheme,
      onGenerateRoute: PageRoutes.generateRoute,
      initialRoute: splashScreen,
      // initialRoute: mainNavigationScreen,
    );
  }
}
