import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';
import 'package:need_in_choice/views/pages/login/widgets/signin_modelsheet.dart';
import 'package:need_in_choice/views/pages/login/widgets/start_button.dart';
import '../../../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -30, end: 30).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            top: -30,
            left: 0,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: Image.asset('assets/images/profile/Ellipse 95.png'),
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 75,
            left: MediaQuery.of(context).size.width / 9 - 85,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: kSecondaryColor,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 4 - 45,
            right: MediaQuery.of(context).size.width / 3 - 85,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(0, -_animation.value),
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: kPrimaryColor,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 75,
            right: MediaQuery.of(context).size.width / 7 - 85,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundColor: kLightGreyColor,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            left: MediaQuery.of(context).size.height / 5 - 65,
            child: Image.asset('assets/images/profile/nic.png'),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.25,
            left: MediaQuery.of(context).size.height / 8 - 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'search and buy everything with nic now',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                kHeight20,
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return StartButton(
                      screenWidth: screenWidth,
                      boldText: 'Get Started',
                      lightText: ' Now',
                      circle: kWhiteColor,
                      button: kPrimaryColor,
                      ontap: () async {
                        if (user != null) {
                          await Navigator.pushNamed(
                              context, mainNavigationScreen);
                        } else if (user == null) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              reverse: false,
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: const SigninModalSheet(),
                            ),
                          );
                        } else {
                          const CircularProgressIndicator();
                        }
                      },
                      arrow: kPrimaryColor,
                    );
                  },
                ),
                kHeight20
              ],
            ),
          ),
        ],
      ),
    );
  }
}
