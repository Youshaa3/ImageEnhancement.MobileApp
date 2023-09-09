import 'package:flutter/material.dart';
import 'package:image_enhancement/ui/shared/colors.dart';

class CustomText extends StatelessWidget {
  final String textt;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textFontWieght;
  const CustomText(
      {super.key,
      required this.textt,
      this.textColor,
      this.textSize,
      this.textFontWieght});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(
      textt,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor ?? AppColors.Grey,
        fontSize: textSize ?? size.width * 0.035,
        fontWeight: textFontWieght ?? FontWeight.w400,
      ),
    );
  }
}
