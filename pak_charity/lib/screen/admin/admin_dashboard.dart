import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/screen/home/recipient/recipient_form.dart';
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
        backgroundColor: AppColor.fonts,
        foregroundColor: AppColor.white,
        child: const Icon(
          FontAwesome5.hand_holding_usd,
        ),
      ),
    );
  }
}
