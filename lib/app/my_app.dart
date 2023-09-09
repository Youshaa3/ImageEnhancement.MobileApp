import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/ui/views/login_view/login_view.dart';
import 'package:image_enhancement/ui/views/splash_screen_view/splash_Screen_view.dart';

import '../ui/views/main_view/main_view.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledToast(
        locale: const Locale('en', 'US'),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreenView(),
          defaultTransition: Transition.upToDown,
        ));
  }
}
