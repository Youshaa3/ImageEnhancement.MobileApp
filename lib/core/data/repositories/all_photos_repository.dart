import 'package:dartz/dartz.dart';
import 'package:image_enhancement/core/data/models/apis/all_photos_model.dart';
import 'package:image_enhancement/core/data/models/apis/photos_by_category_id_model.dart';
import 'package:image_enhancement/core/data/models/apis/photos_by_id_model.dart';
import 'package:image_enhancement/core/data/models/apis/top10_photos_model.dart';
import 'package:image_enhancement/core/data/models/common_response.dart';
import 'package:image_enhancement/core/data/network/end_points/all_photos_endpoints.dart.dart';
import 'package:image_enhancement/core/enums/request_type.dart';
import 'package:image_enhancement/core/utils/network_util.dart';

class AllPhotosRepository {
  Future<Either<String, List<Top10Model>>> getTop10() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: AllPhotosEndPoints.getTopImages,
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<Top10Model> result = [];
          commonResponse.data!.forEach(
            (element) {
              result.add(Top10Model.fromJson(element));
            },
          );
          return Right(result);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<AllPhotosModel>>> getAllPhotos() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: AllPhotosEndPoints.getAllImages,
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<AllPhotosModel> result = [];
          commonResponse.data!.forEach(
            (element) {
              result.add(AllPhotosModel.fromJson(element));
            },
          );
          return Right(result);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<PhotosByCategoryIdModel>>> getPhotosByCategoryId(
      {required String categoryId}) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          url: AllPhotosEndPoints.getImagesByCategoryId,
          body: {"cat_id": categoryId}).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<PhotosByCategoryIdModel> result = [];
          commonResponse.data!.forEach(
            (element) {
              result.add(PhotosByCategoryIdModel.fromJson(element));
            },
          );
          return Right(result);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<PhotosByIdModel>>> getPhotosById(
      {required int imageId}) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.GET,
          url: AllPhotosEndPoints.getImageById,
          body: {"img_id": imageId.toString()}).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<PhotosByIdModel> result = [];
          commonResponse.data!.forEach(
            (element) {
              result.add(PhotosByIdModel.fromJson(element));
            },
          );
          return Right(result);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
