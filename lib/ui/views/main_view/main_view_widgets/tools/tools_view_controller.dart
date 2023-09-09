import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/core/data/models/apis/process_image_model.dart';
import 'package:image_enhancement/core/data/models/apis/services_model.dart';
import 'package:image_enhancement/core/data/repositories/services_repository.dart';
import 'package:image_enhancement/core/enums/message_type.dart';
import 'package:image_enhancement/core/services/base_controller.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/shared/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class ToolsViewController extends BaseController {
  bool isDialogOpen = Get.isDialogOpen!;
  int counter = 0;
  RxList<ProcessPhotoModel> processPhotoList = <ProcessPhotoModel>[].obs;
  RxInt selectedImageIndex = 0.obs;
  late XFile? image = null;
  final ImagePicker picker = ImagePicker();

  void getImage({required String serviceId}) async {
    image = await picker.pickImage(source: ImageSource.gallery);
    print(image!.path);
    if (image != null) {
      List<int> imageBytes = await image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      StringBuffer myStringBuffer = StringBuffer(base64Image);
      ServicesRepository()
          .processImage(
              userId: '12',
              serviceId: serviceId,
              img: myStringBuffer.toString())
          .then((value) {
        value.fold((l) {
          CustomToast.showMessage(
              message: l, messageType: MessageType.REJECTED);
        }, (r) {
          processPhotoList.add(r);
          print('${myStringBuffer.toString()}');
          myStringBuffer.clear();

          imageCache.clear();
          print("@@@@@@@@@@@@@@@@@@@");
          print('${photo_url}${r.img}');
          print("@@@@@@@@@@@@@@@@@@@");
          Get.defaultDialog(
            title: "YOUR IMAGE IS READY",
            titleStyle: TextStyle(color: AppColors.mainPurple),
            content: Column(
              children: [
                Container(
                  height: screenWidth(1.1),
                  width: screenWidth(1),
                  child: CachedNetworkImage(
                    imageUrl: '${photo_url}${processPhotoList.first.img}',
                    fit: BoxFit.fill,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                AvatarGlow(
                  glowColor: AppColors.mainPurple,
                  endRadius: 50,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  curve: Curves.easeOutQuad,
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColors.mainPurple,
                          borderRadius: BorderRadius.circular(99)),
                      child: IconButton(
                        onPressed: () {
                          if (processPhotoList.isNotEmpty) {
                            downloadImage();
                            showToastWidget(
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Lottie.asset(
                                    'assets/lottie/lottie5.json',
                                    width: screenWidth(5),
                                    height: screenWidth(5),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              animation: StyledToastAnimation.scale,
                              reverseAnimation: StyledToastAnimation.fade,
                              position: StyledToastPosition.bottom,
                              animDuration: Duration(seconds: 1),
                              duration: Duration(seconds: 3),
                              curve: Curves.elasticOut,
                              reverseCurve: Curves.linear,
                            );
                            processPhotoList.clear();

                            Future.delayed(Duration(seconds: 2), () {
                              Get.back();
                            });
                          } else {
                            showToastWidget(
                              Container(
                                width: screenWidth(2),
                                height: screenWidth(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.redColor,
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: Offset(0,
                                            3), // changes the shadow position
                                      ),
                                    ],
                                    color: AppColors.whiteColor),
                                child: Center(
                                  child: CustomText(
                                    textt: "Already Saved!",
                                    textSize: screenWidth(15),
                                    textColor: AppColors.redColor,
                                  ),
                                ),
                              ),
                            );
                            Future.delayed(Duration(seconds: 2), () {
                              Get.back();
                            });
                          }
                        },
                        icon: Icon(
                          Icons.download,
                          size: 30,
                          color: AppColors.whiteColor,
                        ),
                      )),
                ),
              ],
            ),
          );
        });
      });
    }
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

  String generateRandomFileName() {
    Random random = Random();
    String randomString = '';
    const String chars =
        'abcdefghijklmnopqrstuvwxyzAZQWSXEDCRFVTGBYHNUJMIKOLP0123456789';

    for (int i = 0; i < 20; i++) {
      randomString += chars[random.nextInt(chars.length)];
    }

    return randomString;
  }

  void downloadImage() {
    String fileName = generateRandomFileName();
    saveImageToDownloadFolder(
        '${photo_url}${processPhotoList.first.img}', '${fileName}.jpg');
  }
}
