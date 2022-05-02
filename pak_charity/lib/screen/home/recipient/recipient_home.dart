import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/screen/home/profile.dart';

import 'completed_cases.dart';
import 'recipient_dashboard.dart';

class RecipientHome extends StatefulWidget {
  const RecipientHome({Key key}) : super(key: key);

  @override
  State<RecipientHome> createState() => _RecipientHomeState();
}

class _RecipientHomeState extends State<RecipientHome> {
  int bottomIndex;

  @override
  void initState() {
    bottomIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context).open();
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
        child: bottomIndex == 0
            ? const CompletedCases()
            : bottomIndex == 1
                ? const RecipientDashboard()
                : bottomIndex == 2
                    ? const Profile()
                    : Container(),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 1,
        tabs: [
          TabData(
              iconData: FontAwesome5.file_invoice_dollar, title: "Completed"),
          TabData(iconData: FontAwesome.home, title: "Home"),
          TabData(iconData: Icons.person, title: "Profile")
        ],
        onTabChangedListener: (position) {
          setState(() {
            bottomIndex = position;
          });
        },
      ),
    );
  }
}
