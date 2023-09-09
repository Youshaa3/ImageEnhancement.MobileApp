import 'package:dartz/dartz.dart';
import 'package:image_enhancement/core/data/models/apis/confirm_password_model.dart';
import 'package:image_enhancement/core/data/models/apis/login_model.dart';
import 'package:image_enhancement/core/data/models/apis/token_info.dart';
import 'package:image_enhancement/core/data/models/common_response.dart';
import 'package:image_enhancement/core/data/network/end_points/user_endpoints.dart';
import 'package:image_enhancement/core/data/network/network_config.dart';
import 'package:image_enhancement/core/enums/request_type.dart';
import 'package:image_enhancement/core/utils/network_util.dart';

class UserRepository {
  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndpoints.login,
        body: {
          'email': email,
          'password': password,
        },
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(LoginModel.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> signup({
    required String email,
    required String name,
    required String age,
    required String city,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndpoints.signup,
        body: {
          "email": email,
          "name": name,
          "age": age,
          "city": city,
          "password": password
        },
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Left(commonResponse.message ?? '');
        } else {
          return Right(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ConfirmPasswordModel>> confirmPassword({
    required String email,
    required String code,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndpoints.confirmPassword,
        body: {
          'email': email,
          'code': code,
        },
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(
              ConfirmPasswordModel.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
