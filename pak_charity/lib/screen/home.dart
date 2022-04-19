import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/color.dart';
import 'home/dashboard.dart';
import 'home/profile.dart';
import 'home/projects.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  final bottomIndex = 1.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            if (ZoomDrawer.of(context).isOpen()) {
              ZoomDrawer.of(context).close();
            } else {
              ZoomDrawer.of(context).open();
            }
          },
          icon: Icon(
            Icons.menu,
            color: AppColor.fonts,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: AppColor.fonts,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            return bottomIndex.value == 0
                ? const Projects()
                : bottomIndex.value == 1
                    ? const Dashboard()
                    : bottomIndex.value == 2
                        ? const Profile()
                        : Container();
          },
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 1,
        tabs: [
          TabData(iconData: Icons.favorite, title: "Projects"),
          TabData(iconData: FontAwesome.home, title: "Home"),
          TabData(iconData: Icons.person, title: "Profile")
        ],
        onTabChangedListener: (position) {
          bottomIndex.value = position;
        },
      ),
    );
  }
}
