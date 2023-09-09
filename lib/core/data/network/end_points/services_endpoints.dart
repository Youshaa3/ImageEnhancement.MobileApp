import 'package:image_enhancement/core/data/network/network_config.dart';

class ServicesEndPoints {
  static String getServices = NetworkConfig.getFulApiUrl('getServices/');
  static String processImage = NetworkConfig.getFulApiUrl('processImage/');
}
