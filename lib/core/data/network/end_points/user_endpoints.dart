import 'package:image_enhancement/core/data/network/network_config.dart';

class UserEndpoints {
  static String login = NetworkConfig.getFulApiUrl('login/');
  static String signup = NetworkConfig.getFulApiUrl('signup/');
  static String confirmPassword = NetworkConfig.getFulApiUrl('confirm/');
}
