import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_enhancement/ui/shared/colors.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_button.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text_button.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/shared/utils.dart';

import 'package:image_enhancement/ui/views/login_view/login_view.dart';
import 'package:image_enhancement/ui/views/main_view/main_view.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.mainPurple));
    return Scaffold(
      body: Container(
        color: AppColors.whiteColor,
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/images/Robot.svg",
                width: size.width * 0.9,
                height: size.width * 0.9,
              ),
            ),
            Container(
              width: screenWidth(1),
              height: screenHeight(2),
              child: CustomPaint(
                painter: RPSC2ustomPainter(),
              ),
            ),
            Container(
              width: screenWidth(1),
              height: screenHeight(2),
              child: CustomPaint(
                painter: RPSCustomPainter(),
              ),
            ),
            Positioned(
              top: size.height * 0.7,
              left: size.width * 0.05,
              child: Column(
                children: [
                  CustomText(
                    textt:
                        'Discover the best images from over 10,000 \n photogragher with alot of tools to enhance your image',
                    textColor: AppColors.softBlack,
                  ),
                  (size.width * 0.05).ph,
                  CustomButton(
                      text: 'Login',
                      backgroundColor: AppColors.mainPurple,
                      textColor: AppColors.whiteColor,
                      textFontWeight: FontWeight.w500,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return LoginView();
                          },
                        ));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColors.mainPurple
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width * 0.6250000, size.height * 0.0014620);
    path0.quadraticBezierTo(size.width * 0.8600250, size.height * 0.3632018,
        size.width * 0.4700500, size.height * 0.4195029);
    path0.quadraticBezierTo(size.width * 0.5498000, size.height * 0.8463596, 0,
        size.height * 0.9975731);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSC2ustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColors.softBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width * 0.3700000, size.height * 0.0014620);
    path0.quadraticBezierTo(size.width * 0.2464000, size.height * 0.2702924,
        size.width * 0.4414500, size.height * 0.4909064);
    path0.quadraticBezierTo(size.width * 0.7209000, size.height * 0.7372222,
        size.width, size.height * 0.8732895);
    path0.lineTo(size.width, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
