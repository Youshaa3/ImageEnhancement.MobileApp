import 'package:flutter/material.dart';
import 'package:image_enhancement/app/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? globalSharedPrefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  globalSharedPrefs = await SharedPreferences.getInstance();
  runApp(const MainApp());
}
