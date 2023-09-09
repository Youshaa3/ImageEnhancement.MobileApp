import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/core/data/repositories/shared_prefreance_repository.dart';
import 'package:image_enhancement/ui/shared/colors.dart';

bool isEmail(String value) {
  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regExp.hasMatch(value);
}

bool isValidPassword(String value) {
  RegExp regExp = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  return regExp.hasMatch(value);
}

bool isValidName(String value) {
  RegExp nameRegex = RegExp(r"^[a-zA-Z]+(([',\.\-\s])?[a-zA-Z ])*[a-zA-Z]+$");
  return nameRegex.hasMatch(value);
}

bool isValidMobileNo(value) {
  RegExp syrianMobileRegex = RegExp(r'^(!?(\+|00)963|0)?9\d{8}$');
  return syrianMobileRegex.hasMatch(value);
}

bool isValidAddress(value) {
  RegExp addressRegex = RegExp(r'^[a-zA-Z0-9\s\-\,\#\.]+$');
  return addressRegex.hasMatch(value);
}

double screenWidth(double percent) {
  return Get.size.width / percent;
}

double screenHeight(double percent) {
  return Get.size.height / percent;
}

void customLoader() {
  BotToast.showCustomLoading(
    toastBuilder: (cancelFunc) {
      return Container(
        width: screenWidth(5),
        height: screenWidth(5),
        decoration: BoxDecoration(
            color: AppColors.greencolor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15)),
        child: SpinKitCircle(color: AppColors.mainOrangeColor),
      );
    },
  );
}

void customLoader2() {
  ToastFuture toast = showToastWidget(
    Container(
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SpinKitCircle(color: Colors.orange),
    ),
    position: StyledToastPosition.center,
    duration: Duration(seconds: 3),
    animDuration: Duration(milliseconds: 250),
    curve: Curves.easeInOut,
    reverseCurve: Curves.easeInOut,
  );
  activeToasts.add(toast);
}

List<ToastFuture> activeToasts = [];
void removeAllToasts() {
  for (var toast in activeToasts) {
    toast.dismiss();
  }
  activeToasts.clear();
}

SharedPrefreanceRepositories get storage =>
    Get.find<SharedPrefreanceRepositories>();
const String photo_url = "http://192.168.43.28:8000/photoapp";
