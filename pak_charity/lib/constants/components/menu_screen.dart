import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pak_charity/constants/color.dart';

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
              Card(
                child: ListTile(
                  onTap: () {},
                  leading: const Icon(
                    FontAwesome5.home,
                  ),
                  title: const Text('Home'),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {},
                  leading: const Icon(
                    FontAwesome5.file_invoice_dollar,
                  ),
                  title: const Text('Transaction'),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.person,
                  ),
                  title: const Text('Profile'),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {},
                  leading: const Icon(
                    FontAwesome.cog_alt,
                  ),
                  title: const Text('Home'),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {},
                  iconColor: AppColor.red,
                  textColor: AppColor.red,
                  leading: const Icon(
                    Icons.power_settings_new,
                  ),
                  title: const Text('Logout'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
