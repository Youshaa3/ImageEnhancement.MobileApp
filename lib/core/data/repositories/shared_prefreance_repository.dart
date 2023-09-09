import 'dart:convert';

import 'package:image_enhancement/core/data/models/apis/login_model.dart';
import 'package:image_enhancement/core/data/models/apis/token_info.dart';
import 'package:image_enhancement/core/enums/data_type.dart';
import 'package:image_enhancement/main.dart';

class SharedPrefreanceRepositories {
  static String PREF_FIRST_LANUCH = "first_lanuch";
  static String PREF_FIRS_LOGIN = "first_login";
  static String PREF_TOKEN_INFO = 'token_info';

  static setFirstLogin(bool value) {
    setPrefrance(dataType: DataType.BOOL, key: PREF_FIRS_LOGIN, value: value);
  }

  static bool getFirstLogin() {
    if (globalSharedPrefs!.containsKey(PREF_FIRS_LOGIN))
      return getPrefrance(key: PREF_FIRS_LOGIN);
    else
      return false;
  }

  static setFirstLunch(bool value) {
    setPrefrance(
      dataType: DataType.BOOL,
      key: PREF_FIRST_LANUCH,
      value: value,
    );
  }

  static bool getFirstLunch() {
    if (globalSharedPrefs!.containsKey(PREF_FIRST_LANUCH))
      return getPrefrance(key: PREF_FIRST_LANUCH);
    else {
      return true;
    }
  }

  static setLoginModel(LoginModel value) {
    setPrefrance(
      dataType: DataType.STRING,
      key: PREF_TOKEN_INFO,
      value: jsonEncode(value),
    );
  }

  static LoginModel? getTokenInfo() {
    if (globalSharedPrefs!.containsKey(PREF_TOKEN_INFO)) {
      return LoginModel.fromJson(
          jsonDecode(getPrefrance(key: PREF_TOKEN_INFO)));
    } else {
      return null;
    }
  }

  static setPrefrance(
      {required DataType dataType,
      required String key,
      required dynamic value}) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedPrefs!.setInt(key, value);
        break;
      case DataType.BOOL:
        await globalSharedPrefs!.setBool(key, value);
        break;
      case DataType.STRING:
        await globalSharedPrefs!.setString(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedPrefs!.setDouble(key, value);
        break;
      case DataType.LISTSTRING:
        await globalSharedPrefs!.setStringList(key, value);
        break;
    }
  }

  static dynamic getPrefrance({required String key}) {
    return globalSharedPrefs!.get(key);
  }
}
