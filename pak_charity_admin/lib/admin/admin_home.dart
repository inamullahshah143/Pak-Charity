import 'package:cool_alert/cool_alert.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity_admin/constants/widgets/color.dart';
import 'package:pak_charity_admin/main.dart';
import 'package:pak_charity_admin/utils/auth_helper.dart';

import '../auth/spalsh_screen.dart';
import 'admin_dashboard.dart';
import 'donations_data.dart';
import 'project_completed.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int bottomIndex;

  @override
  void initState() {
    bottomIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pagesColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.fonts,
        toolbarHeight: 75,
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Wellcome to Pak Charity',
                style: TextStyle(
                  color: AppColor.fonts,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Admin Dashboard',
                style: TextStyle(
                  color: AppColor.fonts,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              CoolAlert.show(
                context: context,
                barrierDismissible: false,
                type: CoolAlertType.confirm,
                text: 'Logout?',
                onConfirmBtnTap: () {
                  AuthenticationHelper().signOut().whenComplete(() {
                    prefs.clear();
                    Get.offAll(const SplashScreen());
                  });
                },
                confirmBtnText: 'Logout',
                showCancelBtn: true,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: bottomIndex == 0
            ? const ProjectCompleted()
            : bottomIndex == 1
                ? const AdminDashboard()
                : bottomIndex == 2
                    ? const DonationsData()
                    : Container(),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 1,
        tabs: [
          TabData(iconData: Icons.done_all, title: "Completed"),
          TabData(iconData: FontAwesome.home, title: "Home"),
          TabData(iconData: FontAwesome5.donate, title: "Donations")
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
