import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';

import 'package:image_enhancement/core/data/models/apis/category_model.dart';
import 'package:image_enhancement/core/data/repositories/all_photos_repository.dart';

import 'package:image_enhancement/core/data/repositories/category_repository.dart';

import 'package:image_enhancement/core/enums/message_type.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_button.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_category.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_container.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_shimmer.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/shared/utils.dart';
import 'package:image_enhancement/ui/views/main_view/main_view_widgets/categories/categories_view_controller.dart';
import 'package:image_enhancement/ui/views/main_view/main_view_widgets/home/home_view_controller.dart';
import 'package:lottie/lottie.dart';

class CategoriesView extends StatefulWidget {
  final Function onPressed;
  CategoriesView({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    CategoriesController controller = Get.put(CategoriesController());
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.mainPurple));
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.4, 0.7, 1.0],
            colors: [
              Color.fromARGB(255, 249, 234, 255),
              Color.fromARGB(255, 254, 245, 255),
              Color.fromARGB(255, 255, 248, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: size.width * 0.03,
                    top: size.width * 0.05,
                    bottom: size.width * 0.05),
                child: CustomText(
                  textt: "CATEGORIES",
                  textColor: AppColors.mainPurple,
                  textFontWieght: FontWeight.w500,
                  textSize: size.width * 0.04,
                ),
              ),
              Obx(() {
                return controller.isCategoryLoading
                    ? Customshimmer(isGrid: false, itemCount: 30)
                    : Container(
                        height: screenWidth(8),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: controller.allPhotosNamesList.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              return index == 0
                                  ? Obx(() {
                                      return InkWell(
                                        onTap: () {
                                          controller.catId.value = 0;
                                          controller.catColor.value = index;
                                        },
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: screenWidth(30)),
                                          child: Container(
                                            width: screenWidth(5),
                                            height: screenWidth(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: screenWidth(100),
                                                    color: controller.catColor
                                                                .value ==
                                                            index
                                                        ? AppColors.mainPurple
                                                        : AppColors.softBlue),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth(30))),
                                            child: Center(
                                              child: CustomText(
                                                textt: 'All',
                                                textSize: screenWidth(25),
                                                textColor:
                                                    controller.catColor.value ==
                                                            index
                                                        ? AppColors.mainPurple
                                                        : AppColors.softBlue,
                                                textFontWieght: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                  : Obx(() {
                                      return Padding(
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                                horizontal: screenWidth(30)),
                                        child: InkWell(
                                          onTap: () {
                                            controller.getCategoryPhotos(
                                                categoryId:
                                                    '${controller.allPhotosNamesList[index - 1].id}');
                                            controller.catId.value = 1;

                                            controller.catColor.value = index;
                                          },
                                          child: Container(
                                            width: screenWidth(5),
                                            height: screenWidth(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: screenWidth(100),
                                                    color: controller.catColor
                                                                .value ==
                                                            index
                                                        ? AppColors.mainPurple
                                                        : AppColors.softBlue),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth(30))),
                                            child: Center(
                                              child: CustomText(
                                                textt:
                                                    '${controller.allPhotosNamesList[index - 1].name}',
                                                textSize: screenWidth(25),
                                                textColor:
                                                    controller.catColor.value ==
                                                            index
                                                        ? AppColors.mainPurple
                                                        : AppColors.softBlue,
                                                textFontWieght: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                            }));
              }),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: size.width * 0.03,
                    top: size.width * 0.05,
                    bottom: size.width * 0.05),
                child: CustomText(
                  textt: "FILTERING",
                  textColor: AppColors.mainPurple,
                  textFontWieght: FontWeight.w500,
                  textSize: size.width * 0.04,
                ),
              ),
              Obx(() {
                return controller.isAllPhotosLoading ||
                        controller.isPhotosByCategoryIdLoading
                    ? Customshimmer(isGrid: true, itemCount: 30)
                    : AnimationLimiter(
                        child: GridView.count(
                          primary: false,
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          children: List.generate(
                            controller.catId.value == 0
                                ? controller.allPhotosList.length
                                : controller.categoryList.length,
                            (index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: Duration(seconds: 1),
                                columnCount: 3,
                                child: ScaleAnimation(
                                  duration: Duration(seconds: 2),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: FadeInAnimation(
                                      child: InkWell(
                                    onTap: () {
                                      controller.selectedImageIndex.value =
                                          index;
                                      Get.defaultDialog(
                                          title: 'DOWNLOAD NOW!',
                                          titleStyle: TextStyle(
                                              color: AppColors.mainPurple,
                                              fontSize: screenWidth(20)),
                                          content: Column(
                                            children: [
                                              CarouselSlider.builder(
                                                  carouselController: controller
                                                      .carouselController,
                                                  itemCount:
                                                      controller.catId.value ==
                                                              0
                                                          ? controller
                                                              .allPhotosList
                                                              .length
                                                          : controller
                                                              .categoryList
                                                              .length,
                                                  itemBuilder: (content, index,
                                                      realIndex) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .softBlue,
                                                              style: BorderStyle
                                                                  .solid,
                                                              width:
                                                                  screenWidth(
                                                                      100)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      23)),
                                                      height: screenHeight(3),
                                                      width: screenHeight(3),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: controller
                                                                      .catId
                                                                      .value ==
                                                                  0
                                                              ? '${photo_url}${controller.allPhotosList[index].image}'
                                                              : '${photo_url}${controller.categoryList[index].image}',
                                                          fit: BoxFit.fill,
                                                          placeholder: (context,
                                                                  url) =>
                                                              CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  options: CarouselOptions(
                                                    onPageChanged:
                                                        (index, reason) {
                                                      controller
                                                          .selectedImageIndex
                                                          .value = index;
                                                    },
                                                    initialPage: controller
                                                        .selectedImageIndex
                                                        .value = index,
                                                    reverse: false,
                                                    height: screenHeight(2.5),
                                                    enlargeCenterPage: true,
                                                    viewportFraction: 0.9,
                                                    enlargeStrategy:
                                                        CenterPageEnlargeStrategy
                                                            .scale,
                                                    animateToClosest: true,
                                                  )),
                                              screenWidth(20).ph,
                                              Obx(() {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          screenWidth(20)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        textt:
                                                            'Owned By: ${controller.catId.value == 0 ? controller.allPhotosList[controller.selectedImageIndex.value].owner : controller.categoryList[controller.selectedImageIndex.value].owner}',
                                                        textColor: AppColors
                                                            .mainPurple,
                                                        textSize:
                                                            screenWidth(25),
                                                        textFontWieght:
                                                            FontWeight.w700,
                                                      ),
                                                      CustomText(
                                                        textt:
                                                            'Related With: ${controller.catId.value == 0 ? controller.allPhotosList[controller.selectedImageIndex.value].category : controller.categoryList[controller.selectedImageIndex.value].category}',
                                                        textFontWieght:
                                                            FontWeight.w500,
                                                      ),
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            textt:
                                                                '${controller.catId.value == 0 ? controller.allPhotosList[controller.selectedImageIndex.value].rating : controller.categoryList[controller.selectedImageIndex.value].rating} Rating',
                                                            textFontWieght:
                                                                FontWeight.w500,
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .star_rate_rounded,
                                                            color: AppColors
                                                                .yellowColor,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                              AvatarGlow(
                                                glowColor: AppColors.mainPurple,
                                                endRadius: 50,
                                                duration: Duration(
                                                    milliseconds: 2000),
                                                repeat: true,
                                                showTwoGlows: true,
                                                curve: Curves.easeOutQuad,
                                                child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .mainPurple,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(99)),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .downloadImage();
                                                          showToastWidget(
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: ClipOval(
                                                                child: Lottie
                                                                    .asset(
                                                                  'assets/lottie/lottie5.json',
                                                                  width:
                                                                      screenWidth(
                                                                          5),
                                                                  height:
                                                                      screenWidth(
                                                                          5),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            animation:
                                                                StyledToastAnimation
                                                                    .scale,
                                                            reverseAnimation:
                                                                StyledToastAnimation
                                                                    .fade,
                                                            position:
                                                                StyledToastPosition
                                                                    .bottom,
                                                            animDuration:
                                                                Duration(
                                                                    seconds: 1),
                                                            duration: Duration(
                                                                seconds: 3),
                                                            curve: Curves
                                                                .elasticOut,
                                                            reverseCurve:
                                                                Curves.linear,
                                                          );
                                                          Future.delayed(
                                                              Duration(
                                                                  seconds: 2),
                                                              () {
                                                            Get.back();
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.download,
                                                          size: 30,
                                                          color: AppColors
                                                              .whiteColor,
                                                        ))),
                                              ),
                                            ],
                                          ));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(screenWidth(80)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            screenWidth(30)),
                                        child: CachedNetworkImage(
                                          imageUrl: controller.catId.value == 0
                                              ? '${photo_url}${controller.allPhotosList[index].image}'
                                              : '${photo_url}${controller.categoryList[index].image}',
                                          height: screenWidth(20),
                                          width: screenWidth(20),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  )),
                                ),
                              );
                            },
                          ),
                        ),
                      );
              })
            ],
          ),
        ),
      )),
    );
  }
}
