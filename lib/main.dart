import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes/page_routes.dart';
import 'config/theme/theme_data_class.dart';
import 'views/pages/login/bloc/auth_bloc.dart';
import 'services/repositories/auth_repo.dart';
import 'blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import 'services/repositories/ad_create_or_update_service.dart';
import 'views/pages/login/splash_screen_new.dart';




@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FireBaseApi().initNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(authrepo: Authrepo())..add(AuthLoginEvent()),
        ),
        BlocProvider(
          create: (context) => AdCreateOrUpdateBloc(CreateOrUpdateAdsRepo()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Need In Choice',
        theme: ThemeDataPrimary.primaryTheme,
        onGenerateRoute: PageRoutes.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
