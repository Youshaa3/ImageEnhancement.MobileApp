import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/core/data/models/apis/all_photos_model.dart';
import 'package:image_enhancement/core/data/models/apis/category_model.dart';
import 'package:image_enhancement/core/data/models/apis/photos_by_category_id_model.dart';

import 'package:image_enhancement/core/data/models/apis/top10_photos_model.dart';
import 'package:image_enhancement/core/data/repositories/all_photos_repository.dart';
import 'package:image_enhancement/core/data/repositories/category_repository.dart';
import 'package:image_enhancement/core/data/repositories/services_repository.dart';
import 'package:image_enhancement/core/enums/message_type.dart';
import 'package:image_enhancement/core/enums/operation_type.dart';
import 'package:image_enhancement/core/enums/request_status.dart';
import 'package:image_enhancement/core/services/base_controller.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/shared/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class CategoriesController extends BaseController {
  RxList<PhotosByCategoryIdModel> categoryList =
      <PhotosByCategoryIdModel>[].obs;

  CarouselController carouselController = CarouselController();
  RxList<AllPhotosModel> allPhotosList = <AllPhotosModel>[].obs;
  RxList<CategoryModel> allPhotosNamesList = <CategoryModel>[].obs;
  CategoryModel allCategory = CategoryModel(name: "All", id: 0);

  RxInt selectedImageIndex = 0.obs;
  bool get isCategoryLoading =>
      requestStatus.value == RequestStatus.LOADING &&
      listType.contains(OperationType.CATEGORY);

  bool get isAllPhotosLoading =>
      requestStatus.value == RequestStatus.LOADING &&
      listType.contains(OperationType.ALLPHOTOS);
  bool get isPhotosByCategoryIdLoading =>
      requestStatus.value == RequestStatus.LOADING &&
      listType.contains(OperationType.PHOTOSBYCATEGORYID);

  RxInt catId = 0.obs;
  RxInt catColor = 0.obs;

  @override
  void onInit() {
    getPhotosNames();
    getAllPhotos();
    super.onInit();
  }

  void getCategoryPhotos({required String categoryId}) {
    categoryList.clear();
    runLoadingFutureFunction(
        type: OperationType.PHOTOSBYCATEGORYID,
        function: AllPhotosRepository()
            .getPhotosByCategoryId(categoryId: categoryId)
            .then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            categoryList.addAll(r);
          });
        }));
  }

  void getAllPhotos() {
    runLoadingFutureFunction(
        type: OperationType.ALLPHOTOS,
        function: AllPhotosRepository().getAllPhotos().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            allPhotosList.addAll(r);
          });
        }));
  }

  void getPhotosNames() {
    runLoadingFutureFunction(
        type: OperationType.CATEGORY,
        function: CategoriesRepository().getCategories().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            allPhotosNamesList.addAll(r);
          });
        }));
  }

  Future<void> saveImageToDownloadFolder(
      String imageUrl, String fileName) async {
    // Get the directory for the Download folder
    final Directory? downloadDir = await getExternalStorageDirectory();
    final String downloadPath = '${downloadDir!.path}/Download';

    // Create the Download folder if it doesn't exist
    if (!await Directory(downloadPath).exists()) {
      await Directory(downloadPath).create(recursive: true);
    }

    // Download the image
    final HttpClient httpClient = HttpClient();
    final Uri uri = Uri.parse(imageUrl);
    final HttpClientRequest request = await httpClient.getUrl(uri);
    final HttpClientResponse response = await request.close();
    final File file = File('$downloadPath/$fileName');
    await response.pipe(file.openWrite());

    // Show a toast or a message to indicate that the image has been saved
    // You can use a package like fluttertoast or snackbar for this

    // Release the resources
    httpClient.close();
  }

  void downloadImage() {
    saveImageToDownloadFolder(
        '${photo_url}${allPhotosList[selectedImageIndex.value].image}',
        '${allPhotosList[selectedImageIndex.value].id}.jpg');
  }
}
