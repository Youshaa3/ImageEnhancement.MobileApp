import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/utils.dart';

import 'package:shimmer/shimmer.dart';

class Customshimmer extends StatefulWidget {
  final isGrid;
  final int itemCount;
  const Customshimmer({super.key, required this.itemCount, this.isGrid});

  @override
  State<Customshimmer> createState() => _CustomshimmerState();
}

class _CustomshimmerState extends State<Customshimmer> {
  @override
  Widget build(BuildContext context) {
    return (widget.isGrid == false)
        ? SizedBox(
            width: screenWidth(1),
            height: screenWidth(3.8),
            child: Shimmer.fromColors(
                direction: ShimmerDirection.ttb,
                baseColor: AppColors.Grey1,
                highlightColor: AppColors.Grey2,
                child: Container(
                  height: screenWidth(4),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.itemCount,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: screenWidth(50)),
                          child: Container(
                            width: screenWidth(5),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }),
                )),
          )
        : Shimmer.fromColors(
            direction: ShimmerDirection.ttb,
            baseColor: AppColors.Grey1,
            highlightColor: AppColors.Grey2,
            child: AnimationLimiter(
              child: GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.all(screenWidth(50)),
                crossAxisCount: 3,
                children: List.generate(
                  widget.itemCount,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: Duration(seconds: 1),
                      columnCount: 3,
                      child: ScaleAnimation(
                        duration: Duration(seconds: 2),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          child: Container(
                            margin: EdgeInsetsDirectional.only(
                                bottom: screenWidth(40),
                                start: screenWidth(70),
                                end: screenWidth(70)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(screenWidth(30))),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
