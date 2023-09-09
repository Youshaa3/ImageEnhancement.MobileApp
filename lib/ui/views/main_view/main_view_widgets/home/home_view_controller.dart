import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/core/data/models/apis/all_photos_model.dart';
import 'package:image_enhancement/core/data/models/apis/top10_photos_model.dart';
import 'package:image_enhancement/core/data/repositories/all_photos_repository.dart';
import 'package:image_enhancement/core/enums/message_type.dart';
import 'package:image_enhancement/core/enums/operation_type.dart';
import 'package:image_enhancement/core/enums/request_status.dart';
import 'package:image_enhancement/core/services/base_controller.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/shared/utils.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends BaseController {
  CarouselController carouselController = CarouselController();
  RxList<Top10Model> top10List = <Top10Model>[].obs;
  RxInt selectedImageIndex = 0.obs;

  RxList<AllPhotosModel> allPhotosList = <AllPhotosModel>[].obs;

  bool get isTop10Loading =>
      requestStatus.value == RequestStatus.LOADING &&
      listType.contains(OperationType.TOP10);

  bool get isAllPhotosLoading =>
      requestStatus.value == RequestStatus.LOADING &&
      listType.contains(OperationType.ALLPHOTOS);

  @override
  void onInit() {
    getTopPhotos();
    getAllPhotos();
    super.onInit();
  }

  void getTopPhotos() {
    runLoadingFutureFunction(
        type: OperationType.TOP10,
        function: AllPhotosRepository().getTop10().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            top10List.addAll(r);
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
