import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' show Lottie;



class LottieCollections{
  // static String loading = 'assets/images/lotties/333.json';
  // static String noData = 'assets/images/lotties/222.json';
  // static String comingsoon = 'assets/images/lotties/333.json';
  static String loading = 'assets/images/lotties/loading.json';
  static String noData = 'assets/images/lotties/no_data.json';
  static String comingsoon = 'assets/images/lotties/comingsoon.json';
}


class LottieWidget extends StatelessWidget {
  const LottieWidget({
    super.key, 
    required this.lottiePathName,
    required this.size,
  });
  LottieWidget.loading({super.key, this.size = 200}) : lottiePathName = LottieCollections.loading;
  LottieWidget.noData({super.key, this.size = 200}) : lottiePathName = LottieCollections.noData;
  LottieWidget.comingsoon({super.key, this.size = 200}) : lottiePathName = LottieCollections.comingsoon;

  final double size;
  final String lottiePathName;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        lottiePathName,
        width: size,
        height: size,
      ),
    );
  }
}

