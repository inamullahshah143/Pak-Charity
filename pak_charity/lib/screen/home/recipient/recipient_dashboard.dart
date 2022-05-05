import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/screen/home/recipient/recipient_form.dart';

class RecipientDashboard extends StatelessWidget {
  const RecipientDashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const RecipientForm());
        },
        backgroundColor: AppColor.fonts,
        foregroundColor: AppColor.white,
        child: const Icon(
          FontAwesome5.hand_holding_usd,
        ),
      ),
    );
  }
}
