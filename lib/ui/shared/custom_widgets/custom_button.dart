import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_enhancement/ui/shared/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textFontWeight;
  final Color? borderColor;
  final Color? backgroundColor;
  final Function onPressed;
  final String? svgName;
  final Size? s;

  const CustomButton({
    Key? key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textFontWeight,
    this.borderColor,
    this.backgroundColor,
    required this.onPressed,
    this.svgName,
    this.s,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svgName != null) ...[
            SvgPicture.asset(
              'assets/images/$svgName.svg',
              width: size.width * 0.1,
              height: size.width * 0.1,
            ),
            SizedBox(
              width: size.width * 0.02,
            )
          ],
          Text(
            text,
            style: TextStyle(
                color: textColor ?? AppColors.whiteColor,
                fontSize: textSize ?? size.width * 0.035,
                fontWeight: textFontWeight ?? FontWeight.w400),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
          side: borderColor != null
              ? BorderSide(width: 1, color: borderColor ?? AppColors.mainPurple)
              : null,
          backgroundColor: backgroundColor ?? AppColors.mainPurple,
          shape: StadiumBorder(),
          fixedSize: s ?? Size(size.width * 0.9, size.width * 0.14)),
    );
  }
}
