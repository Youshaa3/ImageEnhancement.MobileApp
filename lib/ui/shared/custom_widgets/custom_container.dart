import 'package:flutter/material.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text.dart';
import 'package:image_enhancement/ui/shared/utils.dart';

class CustomContainer extends StatefulWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final String text;
  const CustomContainer(
      {super.key, this.child, this.width, this.height, required this.text});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? screenWidth(3),
      height: widget.height ?? screenWidth(7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.4, 0.7, 1.0],
          colors: [
            Color.fromARGB(255, 245, 219, 255),
            Color.fromARGB(255, 253, 237, 255),
            Color.fromARGB(255, 253, 238, 253),
            Color.fromARGB(255, 255, 255, 255),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainPurple,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes the shadow position
          ),
        ],
      ),
      child: Center(
        child: widget.child ??
            CustomText(
              textt: widget.text,
              textSize: screenWidth(25),
              textFontWieght: FontWeight.w700,
              textColor: AppColors.softBlue,
            ),
      ),
    );
  }
}
