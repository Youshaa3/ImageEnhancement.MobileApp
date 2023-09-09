import 'package:flutter/material.dart';

import 'package:image_enhancement/ui/shared/colors.dart';
import 'package:image_enhancement/ui/shared/utils.dart';
import 'package:image_enhancement/ui/views/main_view/main_view_widgets/categories/categories_view.dart';
import 'package:image_enhancement/ui/views/main_view/main_view_widgets/home/home_view.dart';
import 'package:image_enhancement/ui/views/main_view/main_view_widgets/tools/tools_view.dart';

import '../../shared/custom_widgets/custom_text.dart';

class MainView extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<MainView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              snap: false,
              pinned: false,
              floating: false,
              primary: true,
              forceElevated: true,
              flexibleSpace: FlexibleSpaceBar(
                  // titlePadding: EdgeInsets.only(bottom: size.width * 0.186),
                  centerTitle: true,
                  title: CustomText(
                    textt: 'Gallery',
                    textSize: screenWidth(15),
                    textColor: AppColors.whiteColor,
                  ) //Text
                  ),
              expandedHeight: size.width * 0.1,
              backgroundColor: AppColors.mainPurple,
            )
          ];
        },
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: AppColors.mainPurple,
              unselectedLabelColor: AppColors.Grey2,
              isScrollable: false,
              tabs: [
                Tab(
                  text: "HOME",
                ),
                Tab(
                  text: "CATEGORIES",
                ),
                Tab(
                  text: "SERVICES",
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  GestureDetector(
                    onHorizontalDragUpdate: (details) {},
                    child: HomeView(
                      onPressed: () {},
                    ),
                  ),
                  GestureDetector(
                      onHorizontalDragUpdate: (details) {},
                      child: CategoriesView(
                        onPressed: () {},
                      )),
                  GestureDetector(
                      onHorizontalDragUpdate: (details) {}, child: ToolsView()),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
