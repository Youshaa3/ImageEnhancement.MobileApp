import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/core/data/repositories/shared_prefreance_repository.dart';
import 'package:image_enhancement/core/data/repositories/user_repository.dart';
import 'package:image_enhancement/core/enums/message_type.dart';
import 'package:image_enhancement/core/services/base_controller.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/views/main_view/main_view.dart';

class LoginController extends BaseController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void login() {
    UserRepository()
        .login(email: emailController.text, password: passwordController.text)
        .then((value) {
      value.fold((l) {
        print("error from login controller");
        Get.defaultDialog(title: 'ERROR', content: Text("$l"));
      }, (r) {
        SharedPrefreanceRepositories.setFirstLogin(true);
        SharedPrefreanceRepositories.setLoginModel(r);
        Get.off(MainView());
      });
    });
  }
}
