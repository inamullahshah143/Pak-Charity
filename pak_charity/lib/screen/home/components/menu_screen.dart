import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/components/components.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/auth/spalsh_screen.dart';
import 'package:pak_charity/screen/home/about_us.dart';
import 'package:pak_charity/screen/home/inbox_screen.dart';
import 'package:pak_charity/utils/auth_helper.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    '${prefs.getString('Username')} ',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.fonts,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    '${prefs.getString('Email')} ',
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context).close();
                },
                leading: const Icon(
                  FontAwesome.gauge,
                ),
                title: const Text('Dashboard'),
              ),
              prefs.getString('UserType') != 'donor'
                  ? ListTile(
                      onTap: () {
                        CoolAlert.show(
                          context: context,
                          barrierDismissible: false,
                          type: CoolAlertType.info,
                          text: 'Are you sure you want to switch your account',
                          onConfirmBtnTap: () {
                            Components.showAlertDialog(context);
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(prefs.getString('UserID'))
                                .update({'userType': 'donor'}).whenComplete(() {
                              Navigator.of(context).pop();
                              prefs.setString('UserType', 'donor');
                              Get.off(const SplashScreen());
                            });
                          },
                          confirmBtnText: 'Switch',
                          showCancelBtn: true,
                        );
                      },
                      leading: const Icon(
                        FontAwesome5.exchange_alt,
                      ),
                      title: const Text('Switch to Donor'),
                    )
                  : ListTile(
                      onTap: () {
                        CoolAlert.show(
                          context: context,
                          barrierDismissible: false,
                          type: CoolAlertType.info,
                          text: 'Are you sure you want to switch your account',
                          onConfirmBtnTap: () {
                            Components.showAlertDialog(context);
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(prefs.getString('UserID'))
                                .update({'userType': 'recipient'}).whenComplete(
                                    () {
                              Navigator.of(context).pop();
                              prefs.setString('UserType', 'recipient');
                              Get.off(const SplashScreen());
                            });
                          },
                          confirmBtnText: 'Switch',
                          showCancelBtn: true,
                        );
                      },
                      leading: const Icon(
                        FontAwesome5.exchange_alt,
                      ),
                      title: const Text('Switch to Recipient'),
                    ),
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context).close();
                  Get.to(const InboxScreen());
                },
                leading: const Icon(
                  FontAwesome.chat_empty,
                ),
                title: const Text('Messages'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.security,
                ),
                title: const Text('Privacy Policy'),
              ),
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context).close();
                  Get.to(const AboutUs());
                },
                leading: const Icon(
                  Entypo.info,
                ),
                title: const Text('About Us'),
              ),
              ListTile(
                onTap: () {
                  CoolAlert.show(
                    context: context,
                    backgroundColor: AppColor.fonts,
                    confirmBtnColor: AppColor.appThemeColor,
                    barrierDismissible: false,
                    type: CoolAlertType.confirm,
                    text: 'you want to Logout?',
                    onConfirmBtnTap: () async {
                      Components.showAlertDialog(context);
                      await AuthenticationHelper().signOut().whenComplete(() {
                        Timer(const Duration(seconds: 3), () {
                          Navigator.of(context).pop();
                          prefs.clear();
                          Get.offAll(const SplashScreen());
                        });
                      });
                    },
                    confirmBtnText: 'Logout',
                    showCancelBtn: true,
                  );
                },
                iconColor: AppColor.red,
                textColor: AppColor.red,
                leading: const Icon(
                  Icons.power_settings_new,
                ),
                title: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
