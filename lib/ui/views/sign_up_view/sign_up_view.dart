import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/core/data/repositories/user_repository.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text_button.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/shared/utils.dart';
import 'package:image_enhancement/ui/views/login_view/login_view.dart';
import 'package:image_enhancement/ui/views/mobile_verfiction_view/mobile_verfiction_view.dart';
import 'package:image_enhancement/ui/views/sign_up_view/sign_up_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_text.dart';
import '../../shared/custom_widgets/custom_text_form.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  // final ImagePicker picker = ImagePicker();

  // int index = 0;

  // late XFile? image = null;

  // late FilePickerResult? result = null;

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.mainPurple));
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: controller.signUpFormkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.only(top: size.width * 0.15),
                child: Center(
                  child: CustomText(
                    textt: "Sign Up",
                    textColor: AppColors.softBlack,
                    textSize: size.width * 0.08,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.04, bottom: size.width * 0.03),
                child: CustomText(
                  textt: "Add your details to sign up",
                  textColor: AppColors.softBlack,
                ),
              ),
              // CircleAvatar(
              //   backgroundColor: AppColors.mainPurple,
              //   radius: size.width * 0.2,
              //   child: InkWell(
              //     onTap: index == 0
              //         ? () {
              //             setState(() {
              //               index = 2;
              //             });
              //           }
              //         : null,
              //     child: CircleAvatar(
              //         radius: size.width * 0.195,
              //         backgroundColor: Colors.white,
              //         child: AspectRatio(
              //           aspectRatio: 1.0,
              //           child: ClipOval(
              //               child: (image != null)
              //                   ? Image.file(
              //                       File(image!.path),
              //                       fit: BoxFit.cover,
              //                     )
              //                   : (result != null)
              //                       ? Icon(Icons.file_copy_outlined,
              //                           size: size.width * 0.15)
              //                       : Icon((Icons.edit))),
              //         )),
              //   ),
              // ),
              // (size.width * 0.03).ph,
              // index == 1
              //     ? InkWell(
              //         onTap: () {
              //           setState(() {
              //             index = 2;
              //           });
              //         },
              //         child: Padding(
              //           padding: EdgeInsetsDirectional.only(
              //               start: size.width * 0.38),
              //           child: Row(children: [
              //             CustomText(
              //               textt: "Edit",
              //               textSize: size.width * 0.047,
              //               textColor: AppColors.facebookButtonColor,
              //             ),
              //             (size.width * 0.03).pw,
              //             Icon(
              //               Icons.edit,
              //               color: AppColors.facebookButtonColor,
              //               size: size.width * 0.05,
              //             )
              //           ]),
              //         ),
              //       )
              //     : Container(),
              // (size.width * 0.03).ph,
              // (index == 2)
              //     ? Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: [
              //           CustomButton(
              //               text: "Camera",
              //               s: Size(size.width * 0.25, size.width * 0.14),
              //               onPressed: () async {
              //                 image = await picker.pickImage(
              //                     source: ImageSource.camera);
              //                 setState(() {
              //                   index = 1;
              //                 });
              //               }),
              //           (size.width * 0.05).ph,
              //           CustomButton(
              //               text: "Galley",
              //               s: Size(size.width * 0.25, size.width * 0.14),
              //               onPressed: () async {
              //                 image = await picker.pickImage(
              //                     source: ImageSource.gallery);
              //                 setState(() {
              //                   index = 1;
              //                 });
              //               }),
              //           (size.width * 0.05).ph,
              //           CustomButton(
              //               text: "File",
              //               s: Size(size.width * 0.25, size.width * 0.14),
              //               onPressed: () async {
              //                 result = await FilePicker.platform.pickFiles();
              //                 setState(() {
              //                   image = null;
              //                   index = 1;
              //                 });
              //               }),
              //         ],
              //       )
              //     : SizedBox.shrink(),
              // (size.width * 0.05).ph,
              CustomTextForm(
                hintTextt: "Name",
                controller: controller.nameController,
                validator: (value) {
                  return value!.isEmpty || !isValidName(value)
                      ? "please enter your name"
                      : null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                child: CustomTextForm(
                  hintTextt: "Email",
                  controller: controller.emailController,
                  validator: (value) {
                    return value!.isEmpty || !isEmail(value)
                        ? "please enter your Email"
                        : null;
                  },
                ),
              ),
              CustomTextForm(
                  hintTextt: "Age",
                  controller: controller.ageController,
                  validator: (value) {
                    return value!.isEmpty ? "please enter your Age" : null;
                  }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                child: CustomTextForm(
                    hintTextt: "City",
                    controller: controller.cityController,
                    validator: (value) {
                      return value!.isEmpty || !isValidName(value)
                          ? "please enter your city name"
                          : null;
                    }),
              ),
              CustomTextForm(
                  hintTextt: "Password",
                  controller: controller.passwordController,
                  validator: (value) {
                    return value!.isEmpty || !isValidPassword(value)
                        ? "please enter your password"
                        : null;
                  }),
              screenWidth(20).ph,
              isLoading
                  ? SpinKitCircle(
                      color: AppColors.mainOrangeColor,
                    )
                  : CustomButton(
                      text: "Sign Up",
                      onPressed: () {
                        if (controller.signUpFormkey.currentState!.validate()) {
                          UserRepository()
                              .signup(
                                  email: controller.emailController.text,
                                  name: controller.nameController.text,
                                  age: '${controller.ageController.text}',
                                  city: controller.cityController.text,
                                  password: controller.passwordController.text)
                              .then((value) {
                            Get.to(MobileVerifiction(
                              email: controller.emailController.text,
                            ));
                          });
                        }
                      }),
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.05, left: size.width * 0.1),
                child: Row(
                  children: [
                    CustomText(
                      textt: "Already have an Account?",
                    ),
                    CustomTextButton(
                        text: "Login",
                        textColor: AppColors.mainPurple,
                        onPressed: () {
                          Get.off(LoginView());
                        })
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
