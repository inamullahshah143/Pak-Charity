import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/auth/spalsh_screen.dart';
import 'package:pak_charity/screen/home/recipient/recipient_form.dart';
import 'package:pak_charity/utils/auth_helper.dart';
import 'package:pak_charity/utils/recipient_helper.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int approvedCount = 0;
  int activeCount = 0;
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
                    Get.off(const SplashScreen());
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 75,
                            decoration: BoxDecoration(
                              color: AppColor.pagesColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Icon(
                                            Icons.live_help,
                                            size: 14,
                                            color: AppColor.fonts,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '  ',
                                        ),
                                        TextSpan(
                                          text: 'Active Requests',
                                          style: TextStyle(
                                            color: AppColor.fonts,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('donation_requests')
                                        .where('status', isEqualTo: '0')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      return snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? const CircularProgressIndicator()
                                          : snapshot.hasData
                                              ? Text(
                                                  snapshot.data.size.toString(),
                                                  style: TextStyle(
                                                    color: AppColor.fonts,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Text(
                                                  '00',
                                                  style: TextStyle(
                                                    color: AppColor.fonts,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 75,
                            decoration: BoxDecoration(
                              color: AppColor.pagesColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Icon(
                                            FontAwesome5.file_contract,
                                            size: 14,
                                            color: AppColor.fonts,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '  ',
                                        ),
                                        TextSpan(
                                          text: 'Approved Total',
                                          style: TextStyle(
                                            color: AppColor.fonts,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                   StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('donation_requests')
                                        .where('status', isEqualTo: '1')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      return snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? const CircularProgressIndicator()
                                          : snapshot.hasData
                                              ? Text(
                                                  snapshot.data.size.toString(),
                                                  style: TextStyle(
                                                    color: AppColor.fonts,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Text(
                                                  '00',
                                                  style: TextStyle(
                                                    color: AppColor.fonts,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Donation Requests',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.fonts,
                ),
              ),
            ),
            StreamBuilder(
              stream: RecipientHelper().getDonationRequestRecords(context),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : snapshot.data.length == 0
                        ? Expanded(
                            child: Center(
                              child: Text(
                                'No request Found',
                                style: TextStyle(
                                  color: AppColor.secondary,
                                ),
                              ),
                            ),
                          )
                        : snapshot.hasData
                            ? Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    activeCount = snapshot.data.length;
                                    return snapshot.data[index];
                                  },
                                ),
                              )
                            : Expanded(
                                child: Center(
                                  child: Text(
                                    'No request Found',
                                    style: TextStyle(
                                      color: AppColor.secondary,
                                    ),
                                  ),
                                ),
                              );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const RecipientForm());
        },
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        child: const Icon(
          FontAwesome5.hand_holding_usd,
        ),
      ),
    );
  }
}
