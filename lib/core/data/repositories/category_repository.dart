import 'package:dartz/dartz.dart';
import 'package:image_enhancement/core/data/models/apis/category_model.dart';

import 'package:image_enhancement/core/data/models/common_response.dart';
import 'package:image_enhancement/core/data/network/end_points/category_endpoints.dart';

import 'package:image_enhancement/core/data/network/network_config.dart';
import 'package:image_enhancement/core/enums/request_type.dart';
import 'package:image_enhancement/core/utils/network_util.dart';

class CategoriesRepository {
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: CategoryEndPoints.getCategories,
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<CategoryModel> result = [];
          commonResponse.data!.forEach(
            (element) {
              result.add(CategoryModel.fromJson(element));
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
