import 'package:flutter/material.dart';
import 'package:image_enhancement/ui/shared/colors.dart';

class CustomTextForm extends StatefulWidget {
  const CustomTextForm(
      {super.key,
      required this.hintTextt,
      required this.controller,
      this.validator});
  final String hintTextt;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      style: TextStyle(color: AppColors.softBlack),
      decoration: InputDecoration(
          errorStyle: TextStyle(color: AppColors.mainOrangeColor),
          fillColor: AppColors.Grey1,
          filled: true,
          hintText: widget.hintTextt,
          hintStyle:
              TextStyle(color: AppColors.Grey2, fontSize: size.width * 0.035),
          contentPadding: EdgeInsets.only(left: size.width * 0.08),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainPurple),
              borderRadius: BorderRadius.circular(size.width * 0.1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.width * 0.1),
              borderSide: BorderSide(
                  color: AppColors.mainPurple, width: size.width * 0.008))),
    );
  }
}
