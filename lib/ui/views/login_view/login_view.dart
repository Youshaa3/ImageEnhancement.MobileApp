import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/core/data/repositories/shared_prefreance_repository.dart';
import 'package:image_enhancement/core/data/repositories/user_repository.dart';
import 'package:image_enhancement/core/enums/message_type.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_button.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text_button.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text_form.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/shared/utils.dart';
import 'package:image_enhancement/ui/views/login_view/login_view_controller.dart';
import 'package:image_enhancement/ui/views/sign_up_view/sign_up_view.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LoginController controller = Get.put(LoginController());
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.mainPurple));
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: controller.loginFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                child: CustomText(
                  textt: "Login",
                  textColor: AppColors.softBlack,
                  textSize: size.width * 0.08,
                ),
              ),
              CustomText(
                textt: "Add your details to login",
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.08),
                child: CustomTextForm(
                  hintTextt: "Your Email",
                  controller: controller.emailController,
                  validator: (value) {
                    return value!.isEmpty || !isEmail(value)
                        ? "please enter your email"
                        : null;
                  },
                ),
              ),
              CustomTextForm(
                hintTextt: "Password",
                controller: controller.passwordController,
                validator: (value) {
                  return value!.isEmpty || !isValidPassword(value)
                      ? "please enter your password"
                      : null;
                },
              ),
              (screenWidth(20)).ph,
              CustomButton(
                  text: 'Login',
                  onPressed: () {
                    if (controller.loginFormKey.currentState!.validate()) {
                      controller.login();
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(top: size.width * 0.13),
                child: CustomText(
                  textt: "-OR-",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.05, left: size.width * 0.13),
                child: Row(
                  children: [
                    CustomText(
                      textt: "Don't have an Account?",
                    ),
                    CustomTextButton(
                      text: "Sign Up",
                      textColor: AppColors.mainPurple,
                      onPressed: () {
                        Get.off(SignUp());
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
