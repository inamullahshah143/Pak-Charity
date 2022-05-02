// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/screen/home/components/menu_screen.dart';
import 'package:pak_charity/screen/home.dart';

class MenuDrawer extends StatelessWidget {
  String userType;
  MenuDrawer({Key key, @required this.userType}) : super(key: key);
  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      borderRadius: 24.0,
      showShadow: true,
      menuBackgroundColor: AppColor.secondary,
      shadowLayer2Color: AppColor.appThemeColor,
      shadowLayer1Color: AppColor.appThemeColor.withOpacity(0.5),
      angle: 0.0,
      drawerShadowsBackgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width * 0.75,
      menuScreenWidth: MediaQuery.of(context).size.width * 0.75,
      mainScreen: const HomeScreen(),
      menuScreen: MenuScreen(),
      style: DrawerStyle.defaultStyle,
      moveMenuScreen: false,
    );
  }
}
