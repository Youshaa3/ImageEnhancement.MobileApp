import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/app/my_app.dart';
import 'package:image_enhancement/core/data/repositories/user_repository.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_button.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text_button.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/views/sign_up_view/sign_up_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/enums/message_type.dart';
import '../main_view/main_view.dart';

class MobileVerifiction extends StatefulWidget {
  String? email;
  MobileVerifiction({super.key, required this.email});

  @override
  State<MobileVerifiction> createState() => _MobileVerifictionState();
}

class _MobileVerifictionState extends State<MobileVerifiction> {
  TextEditingController controller = TextEditingController();
  SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.mainPurple));
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        60.ph,
        CustomText(
          textt: "We have sent an OTP to \n your Email",
          textSize: size.width * 0.06,
          textColor: AppColors.softBlack,
        ),
        15.ph,
        CustomText(textt: "Please check your Email"),
        50.ph,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: PinCodeTextField(
                appContext: context,
                controller: controller,
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                cursorHeight: 18,
                enableActiveFill: true,

                animationDuration: Duration(seconds: 1),
                backgroundColor: AppColors.whiteColor,
                textStyle: TextStyle(fontSize: size.width * 0.03),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
                ],
                hintCharacter: "*",
                hintStyle: TextStyle(fontSize: size.width * 0.05),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldWidth: size.width * 0.15,
                  inactiveColor: AppColors.Grey,
                  selectedColor: AppColors.mainPurple,
                  activeColor: AppColors.Grey,
                  selectedFillColor: AppColors.mainPurple,
                  inactiveFillColor: AppColors.Grey1,
                  borderWidth: 1,
                  borderRadius: BorderRadius.circular(8),
                ),
                onChanged: ((value) {}),
                onCompleted: (value) {
                  UserRepository()
                      .confirmPassword(
                          email: widget.email!, code: controller.text)
                      .then((value) {
                    value.fold(
                        (l) => CustomToast.showMessage(
                            message: l, messageType: MessageType.REJECTED),
                        (r) => Get.off(MainView()));
                  });
                },
                //beforeTextPaste: ,
              ),
            ),
          ],
        ),
        25.ph,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.24),
          child: Row(
            children: [
              CustomText(
                textt: "Didn't Receive?",
              ),
              CustomTextButton(
                text: " Click Here",
                textColor: AppColors.mainPurple,
                onPressed: () {
                  UserRepository().confirmPassword(
                      email: signUpController.emailController.text,
                      code: controller.text);
                },
              )
            ],
          ),
        ),
      ]),
    ));
  }
}
