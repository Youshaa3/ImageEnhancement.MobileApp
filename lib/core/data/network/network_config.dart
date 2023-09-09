import 'package:image_enhancement/core/data/repositories/shared_prefreance_repository.dart';
import 'package:image_enhancement/core/enums/request_type.dart';

class NetworkConfig {
  static String BASE_API = '/photoapp/';
  static String getFulApiUrl(String api) {
    return BASE_API + api;
  }

  static Map<String, String> getHeaders(
      {bool? needAuth = true,
      RequestType? type = RequestType.POST,
      Map<String, String>? extraHeaders = const {}}) {
    return {
      if (needAuth!)
        'Authorization':
            'Bearer ${SharedPrefreanceRepositories.getTokenInfo()?.password ?? ''}',
      if (type != RequestType.GET) 'Content-Type': 'application/json',
      ...extraHeaders!
    };
  }
}
