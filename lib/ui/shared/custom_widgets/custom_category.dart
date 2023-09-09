import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/shared/utils.dart';

class CustomCategory extends StatelessWidget {
  final String svgName;
  final String text;
  const CustomCategory({super.key, required this.svgName, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/$svgName.svg',
            width: screenWidth(15),
            height: screenWidth(15),
          ),
          screenWidth(20).ph,
          CustomText(textt: text)
        ],
      ),
    );
  }
}
