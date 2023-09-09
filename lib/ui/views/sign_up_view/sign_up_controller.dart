import 'package:flutter/material.dart';
import 'package:image_enhancement/core/services/base_controller.dart';

class SignUpController extends BaseController {
  GlobalKey<FormState> signUpFormkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}
