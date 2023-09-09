import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/core/data/repositories/shared_prefreance_repository.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_enhancement/ui/shared/utils.dart';

import 'package:image_enhancement/ui/views/intro_view/intro_view.dart';
import 'package:image_enhancement/ui/views/landing_view/landing_view.dart';
import 'package:image_enhancement/ui/views/login_view/login_view.dart';
import 'package:image_enhancement/ui/views/main_view/main_view.dart';
import 'package:image_enhancement/ui/views/main_view/main_view_widgets/home/home_view.dart';
import 'package:particles_flutter/particles_flutter.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value) {
      if (SharedPrefreanceRepositories.getFirstLunch()) {
        Get.to(IntroView());
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return SharedPrefreanceRepositories.getFirstLogin()
              ? MainView()
              : LandingView();
        }));
      }
      SharedPrefreanceRepositories.setFirstLunch(false);
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      color: AppColors.whiteColor,
      child: Stack(
        children: [
          CircularParticle(
            width: screenWidth(1),
            height: screenHeight(1),
            awayRadius: screenWidth(5),
            numberOfParticles: 150,
            speedOfParticles: 1.5,
            maxParticleSize: 7,
            particleColor: AppColors.softBlue,
            awayAnimationDuration: Duration(milliseconds: 600),
            awayAnimationCurve: Curves.easeInOutBack,
            onTapAnimation: true,
            isRandSize: true,
            isRandomColor: false,
            connectDots: true,
            // randColorList: [
            // Colors.red.withAlpha(210),
            // Colors.white.withAlpha(210),
            // Colors.yellow.withAlpha(210),
            // Colors.green.withAlpha(210),
            // ],
            enableHover: true,
            hoverColor: Colors.black,
            hoverRadius: 90,
          ),
          Center(child: Image.asset('assets/images/robot.png')),
        ],
      ),
    )));
  }
}
