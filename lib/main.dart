import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';

import 'config/routes/page_routes.dart';
import 'config/routes/route_names.dart';

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
      theme: ThemeData(
        scaffoldBackgroundColor: kOffWhiteColor,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: kWhiteColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          bodySmall: TextStyle(
            color: kLightGreyColor,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          displayLarge: TextStyle(
            color: kWhiteColor,
            fontSize: 27,
            fontWeight: FontWeight.w500,
          ),
          displaySmall: TextStyle(
            color: kWhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )
        ),
      ),
      onGenerateRoute: PageRoutes.generateRoute,
      initialRoute: detailScreen,
    );
  }
}
