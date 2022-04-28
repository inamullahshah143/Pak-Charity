import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/color.dart';
import 'package:pak_charity/screen/home/about_us.dart';

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
                    'Username',
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
                    'mail@email.com',
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
              ListTile(
                onTap: () {},
                leading: const Icon(
                  FontAwesome5.file_invoice_dollar,
                ),
                title: const Text('Switch to Recipient'),
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
                onTap: () {},
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
