import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_container.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_shimmer.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_text.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_enhancement/ui/shared/utils.dart';
import 'package:image_enhancement/ui/views/main_view/main_view_widgets/home/home_view_controller.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  final Function onPressed;
  HomeView({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.mainPurple));
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
                  start: screenWidth(30),
                  top: screenWidth(30),
                  bottom: screenWidth(30),
                ),
                child: CustomText(
                  textt: "TOP IMAGES RATE ",
                  textColor: AppColors.mainPurple,
                  textFontWieght: FontWeight.w700,
                  textSize: screenWidth(25),
                ),
              ),
              Obx(() {
                return controller.isTop10Loading
                    ? Customshimmer(isGrid: false, itemCount: 4)
                    : Container(
                        height: screenWidth(3.4),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: controller.top10List.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth(50)),
                              child: Column(
                                children: [
                                  InkWell(
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
                                                  itemCount: controller
                                                      .top10List.length,
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
                                                          imageUrl:
                                                              '${photo_url}${controller.top10List[index].image}',
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
                                                            'Owned By: ${controller.top10List[controller.selectedImageIndex.value].owner}',
                                                        textColor: AppColors
                                                            .mainPurple,
                                                        textSize:
                                                            screenWidth(25),
                                                        textFontWieght:
                                                            FontWeight.w700,
                                                      ),
                                                      CustomText(
                                                        textt:
                                                            'Related With: ${controller.top10List[controller.selectedImageIndex.value].category}',
                                                        textFontWieght:
                                                            FontWeight.w500,
                                                      ),
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            textt:
                                                                '${controller.top10List[controller.selectedImageIndex.value].rating} Rating',
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth(40)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${photo_url}${controller.top10List[index].image}',
                                        height: screenWidth(4.5),
                                        width: screenWidth(5),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  screenWidth(60).ph,
                                  CustomText(
                                    textt:
                                        controller.top10List[index].owner ?? '',
                                    textSize: screenWidth(25),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
              }),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: screenWidth(30),
                  top: screenWidth(30),
                  bottom: screenWidth(30),
                ),
                child: CustomText(
                  textt: "POPULAR PHOTOS",
                  textColor: AppColors.mainPurple,
                  textFontWieght: FontWeight.w700,
                  textSize: screenWidth(25),
                ),
              ),
              Obx(() {
                return controller.isAllPhotosLoading
                    ? Customshimmer(isGrid: true, itemCount: 32)
                    : AnimationLimiter(
                        child: GridView.count(
                          primary: false,
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          children: List.generate(
                            controller.allPhotosList.length,
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
                                                  itemCount: controller
                                                      .allPhotosList.length,
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
                                                          imageUrl:
                                                              '${photo_url}${controller.allPhotosList[index].image}',
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
                                                            'Owned By: ${controller.allPhotosList[controller.selectedImageIndex.value].owner}',
                                                        textColor: AppColors
                                                            .mainPurple,
                                                        textSize:
                                                            screenWidth(25),
                                                        textFontWieght:
                                                            FontWeight.w700,
                                                      ),
                                                      CustomText(
                                                        textt:
                                                            'Related With: ${controller.allPhotosList[controller.selectedImageIndex.value].category}',
                                                        textFontWieght:
                                                            FontWeight.w500,
                                                      ),
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            textt:
                                                                '${controller.allPhotosList[controller.selectedImageIndex.value].rating} Rating',
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
                                          imageUrl:
                                              '${photo_url}${controller.allPhotosList[index].image}',
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
