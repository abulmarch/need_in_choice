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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          Future.delayed(const Duration(seconds: 3));
          Navigator.pushReplacementNamed(
            context,
            mainNavigationScreen,
          );
        }
      },
      child: Scaffold(
        backgroundColor: kWhiteColor,
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
              top: screenHeight / 2 - 75,
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
              top: screenHeight / 4 - 45,
              right: screenWidth / 3 - 85,
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
              top: screenHeight / 2 - 75,
              right: screenWidth / 7 - 85,
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
              top: screenHeight / 2,
              left: MediaQuery.of(context).size.height / 5 - 65,
              child: Image.asset('assets/images/profile/nic.png'),
            ),
            Positioned(
              top: screenHeight / 1.25,
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
                      if (state is AuthLoading) {
                        return SizedBox(
                          height: screenHeight * 0.085,
                          width: screenWidth * .8,
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                            ),
                          ),
                        );
                      } else if (state is AuthError ||
                          state is AuthNotVerified ||
                          state is AuthSignoutState ||
                          state is AuthNotLoggedIn) {
                        return StartButton(
                          screenWidth: screenWidth,
                          boldText: 'Get Started',
                          lightText: ' Now',
                          circle: kWhiteColor,
                          button: kPrimaryColor,
                          ontap: () async {
                            checklogin(context);
                            if (state is AuthNotLoggedIn) {
                              openSignInModalSheet(context);
                            }
                          },
                          arrow: kPrimaryColor,
                        );
                      }
                      return Container();
                    },
                  ),
                  kHeight20
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  checklogin(
    BuildContext context,
  ) {
    context.read<AuthBloc>().add(AuthLoginEvent());
  }

  Future<dynamic> openSignInModalSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) => SingleChildScrollView(
        reverse: false,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const SigninModalSheet(),
      ),
    );
  }
}
