import 'package:image_enhancement/core/data/network/network_config.dart';

class AllPhotosEndPoints {
  static String getTopImages = NetworkConfig.getFulApiUrl('getTopImages/');
  static String getAllImages = NetworkConfig.getFulApiUrl('getAllImages/');
  static String getImagesByCategoryId =
      NetworkConfig.getFulApiUrl('getImagesByCategoryId/');
  static String getImageById = NetworkConfig.getFulApiUrl('getImageById/');
}
