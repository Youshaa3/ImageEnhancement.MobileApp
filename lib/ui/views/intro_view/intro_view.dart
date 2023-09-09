import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_button.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/shared/utils.dart';
import 'package:image_enhancement/ui/views/landing_view/landing_view.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  List<String> titleList = [
    "Choose Image You Love",
    "Image Compression",
    "Raise Accuracy",
    "Enhance Noisy Image"
  ];
  List<String> descriptionList = [
    'Discover the best images from over 10,000 \n photogragher with alot of tools to enhance your image',
    "Fast image Compression to \n reduceyour image size",
    "Raise your image accuracy \n to get the best performance",
    "Remove noise from your image \n to enhace it and see results"
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.mainPurple));
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.width * 0.07),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: screenWidth(200), color: AppColors.mainPurple),
            borderRadius: BorderRadius.all(Radius.circular(screenWidth(10))),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.4, 0.7, 1.0],
              colors: [
                Color.fromARGB(255, 243, 218, 253),
                Color.fromARGB(255, 250, 229, 253),
                Color.fromARGB(255, 255, 241, 255),
                Color.fromARGB(255, 255, 255, 255),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(25)),
            child: Column(
              children: [
                Image.asset('assets/images/robot.png'),
                (size.width * 0.07).ph,
                DotsIndicator(
                  dotsCount: 4,
                  position: currentIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: AppColors.softBlack, // Inactive color
                    activeColor: AppColors.mainPurple,
                    size: Size(size.width * 0.03, size.width * 0.03),
                    activeSize: Size(size.width * 0.04, size.width * 0.04),
                  ),
                ),
                screenHeight(20).ph,
                Text(
                  titleList[currentIndex],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.softBlack, fontSize: screenWidth(20)),
                ),
                (size.width * 0.07).ph,
                Text(
                  descriptionList[currentIndex],
                  textAlign: TextAlign.center,
                ),
                (size.width * 0.07).ph,
                CustomButton(
                    backgroundColor: AppColors.mainPurple,
                    text: currentIndex != 3 ? "Next" : "Finish",
                    onPressed: () {
                      if (currentIndex != 3)
                        setState(() {
                          currentIndex = currentIndex + 1;
                        });
                      else
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return LandingView();
                        }));
                    })
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
