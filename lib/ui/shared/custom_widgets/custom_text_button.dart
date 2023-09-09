import 'package:flutter/material.dart';
import 'package:image_enhancement/ui/shared/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textWeight;
  final VoidCallback onPressed;
  const CustomTextButton(
      {super.key,
      required this.text,
      this.textColor,
      this.textSize,
      this.textWeight,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? AppColors.Grey,
            fontSize: textSize ?? size.width * 0.035,
            fontWeight: textWeight ?? FontWeight.w700,
          ),
        ));
  }
}
