import 'package:dartz/dartz.dart';
import 'package:image_enhancement/core/data/models/apis/process_image_model.dart';

import 'package:image_enhancement/core/data/models/apis/services_model.dart';
import 'package:image_enhancement/core/data/models/common_response.dart';
import 'package:image_enhancement/core/data/network/end_points/services_endpoints.dart';
import 'package:image_enhancement/core/enums/request_type.dart';
import 'package:image_enhancement/core/utils/network_util.dart';

class ServicesRepository {
  Future<Either<String, ServicesModel>> getServices() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ServicesEndPoints.getServices,
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(ServicesModel.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProcessPhotoModel>> processImage({
    required String userId,
    required String serviceId,
    required String img,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: ServicesEndPoints.processImage,
        body: {
          "user": userId,
          "service_type": serviceId,
          "img": img,
        },
      ).then((response) {
        print(response);
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(ProcessPhotoModel.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
