import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/custom_widgets/custom_container.dart';
import 'package:image_enhancement/ui/shared/utils.dart';
import 'package:image_enhancement/ui/views/main_view/main_view_widgets/tools/tools_view_controller.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ToolsView extends StatefulWidget {
  const ToolsView({super.key});

  @override
  State<ToolsView> createState() => _ToolsViewState();
}

class _ToolsViewState extends State<ToolsView> {
  ToolsViewController controller = Get.put(ToolsViewController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.mainPurple));
    return Scaffold(
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
          width: screenWidth(1),
          height: screenHeight(1),
          child: ListView(
            children: [
              Lottie.asset('assets/lottie/lottie6.json'),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.getImage(serviceId: '1');
                        },
                        child: CustomContainer(
                          text: 'Remove Noise',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.getImage(serviceId: '2');
                        },
                        child: CustomContainer(
                          text: 'Compress Image',
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: screenWidth(12)),
                    child: InkWell(
                      onTap: () {
                        controller.getImage(serviceId: '3');
                      },
                      child: CustomContainer(
                        text: 'Raise Accuracy',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
