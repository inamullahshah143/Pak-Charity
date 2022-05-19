import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/admin/request_details.dart';
import 'package:pak_charity/screen/auth/spalsh_screen.dart';
import 'package:pak_charity/screen/home/recipient/recipient_form.dart';
import 'package:pak_charity/utils/auth_helper.dart';

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
                                  Text(
                                    activeCount.toString(),
                                    style: TextStyle(
                                      color: AppColor.fonts,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                  Text(
                                    approvedCount.toString(),
                                    style: TextStyle(
                                      color: AppColor.fonts,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.to(const RequestDetails());
                      },
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: 0,
                            child: Text('Accept'),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Text('Decline'),
                          ),
                        ],
                        onSelected: (index) {},
                      ),
                      isThreeLine: true,
                      title: const Text('Recipient Name'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.phone,
                                    color: AppColor.primary,
                                    size: 16,
                                  ),
                                ),
                                const TextSpan(text: ' '),
                                const WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Text('XXXX-XXXXXXX'),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.mail,
                                    color: AppColor.primary,
                                    size: 16,
                                  ),
                                ),
                                const TextSpan(text: ' '),
                                const WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Text('email@email.com'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
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
