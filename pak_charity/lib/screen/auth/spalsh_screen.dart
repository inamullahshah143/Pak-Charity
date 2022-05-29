import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/admin/admin.dart';
import 'package:pak_charity/screen/auth/intro_screen.dart';
import 'package:pak_charity/screen/auth/login_screen.dart';
import 'package:pak_charity/screen/home/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    Timer(const Duration(seconds: 3), () async {
      if (user == null) {
        bool _seen = (prefs.getBool('IntroSeen') ?? false);
        if (_seen) {
          Get.off(LoginScreen());
        } else {
          Get.off(IntroScreen());
        }
      } else {
        if (prefs.getString('UserType') == 'admin') {
          Get.off(const AdminDashboard());
        } else {
          Get.off(const Dashboard());
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pagesColor,
      appBar: AppBar(
        backgroundColor: AppColor.pagesColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        foregroundColor: AppColor.fonts,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/background.png',
              ),
              fit: BoxFit.cover),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 75,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/logo.png'),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Pak ',
                      style: TextStyle(
                        color: AppColor.fonts,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    TextSpan(
                      text: 'Charity',
                      style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
