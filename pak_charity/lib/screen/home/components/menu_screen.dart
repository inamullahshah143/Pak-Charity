import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/auth/login_screen.dart';
import 'package:pak_charity/screen/home/about_us.dart';
import 'package:pak_charity/screen/home/menu_darwer.dart';
import 'package:pak_charity/utils/auth_helper.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key key}) : super(key: key);

  final isRecipient = false.obs;

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
              Obx(
                () {
                  return isRecipient.value
                      ? ListTile(
                          onTap: () {
                            CoolAlert.show(
                              context: context,
                              barrierDismissible: false,
                              type: CoolAlertType.info,
                              text:
                                  'Are you sure you want to switch your account',
                              onConfirmBtnTap: () {
                                ZoomDrawer.of(context).close();
                                isRecipient.value = false;
                                Get.off(
                                  MenuDrawer(
                                    userType: 'donor',
                                  ),
                                );
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
                              text:
                                  'Are you sure you want to switch your account',
                              onConfirmBtnTap: () {
                                ZoomDrawer.of(context).close();
                                isRecipient.value = true;
                                Get.off(
                                  MenuDrawer(
                                    userType: 'recipient',
                                  ),
                                );
                              },
                              confirmBtnText: 'Switch',
                              showCancelBtn: true,
                            );
                          },
                          leading: const Icon(
                            FontAwesome5.exchange_alt,
                          ),
                          title: const Text('Switch to Recipient'),
                        );
                },
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  FontAwesome5.file_invoice_dollar,
                ),
                title: const Text('Transaction'),
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
                    barrierDismissible: false,
                    type: CoolAlertType.warning,
                    text: 'Are you sure you want to Logout?',
                    onConfirmBtnTap: () {
                      AuthenticationHelper().signOut().whenComplete(() {
                        prefs.clear();
                        Get.off(LoginScreen());
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
