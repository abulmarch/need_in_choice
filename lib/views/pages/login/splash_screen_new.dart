import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:need_in_choice/services/model/account_model.dart';

import '../../../config/routes/route_names.dart';
import '../../../config/theme/screen_size.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/lottie_widget.dart';
import 'bloc/auth_bloc.dart';
import 'widgets/signin_modelsheet.dart';
import 'widgets/start_button.dart';

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
    AccountSingleton().resetAccountModel();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.setMediaQuery(context);
    final double screenHeight = ScreenSize.height;
    final double screenWidth = ScreenSize.width;
    return Scaffold(
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
            left: ScreenSize.size.width / 9 - 85,
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
            left: 0,
            right: 0,
            child: SvgPicture.asset('assets/images/profile/nic.svg')
          ),
          Positioned(
            top: screenHeight / 1.25,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'search and buy everything with nic now',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                kHeight20,
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is NoInternet) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No internet or poor connectivity'),
                        ),
                      );
                    }else if (state is AuthLoggedIn) {
                      Navigator.pushReplacementNamed(context, mainNavigationScreen,);
                    }else if(state is UserDataNotFound){
                      log('state.currentUser!.phoneNumber: ${state.phoneNo.runtimeType}');
                      openAddressBottomModalSheet(
                        context: context, 
                        phoneNo: state.phoneNo,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading || state is AuthLoggedIn) {
                      return SizedBox(
                        height: screenHeight * 0.085,
                        width: screenWidth * .8,
                        child: LottieWidget.loading(),
                      );
                    }else if (state is NoInternet || state is UserDataNotFound) {
                      return SizedBox(
                        height: screenHeight * 0.085,
                        width: screenWidth * .8,
                        child: InkWell(
                          onTap: () {
                            context.read<AuthBloc>().add(AuthLoginEvent());
                          },
                          child: const Icon(Icons.replay_outlined,size: 35,color: kGreyColor,),
                        ),
                      );
                    }
                    return StartButton(
                      screenWidth: screenWidth,
                      boldText: 'Get Started',
                      lightText: ' Now',
                      circle: kWhiteColor,
                      button: kPrimaryColor,
                      ontap: () async {
                        openSignInModalSheet(context);
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
