import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/home/recipient/recipient_form.dart';
import 'package:pak_charity/utils/recipient_helper.dart';

class RecipientDashboard extends StatelessWidget {
  const RecipientDashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 1,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                              height: 35, width: 35, child: Icon(Icons.person)),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello,",
                                  style: TextStyle(
                                    color: AppColor.fonts.withOpacity(0.75),
                                    height: 1,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  prefs.getString('Username'),
                                  style: TextStyle(
                                    color: AppColor.fonts,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 75,
                              decoration: BoxDecoration(
                                color: AppColor.secondary.withOpacity(0.5),
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
                                              FontAwesome5.chart_line,
                                              size: 14,
                                              color: AppColor.fonts,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '  ',
                                          ),
                                          TextSpan(
                                            text: 'No. of Projects',
                                            style: TextStyle(
                                              color: AppColor.fonts,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '00',
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
                                color: AppColor.secondary.withOpacity(0.5),
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
                                              FontAwesome5.dolly,
                                              size: 14,
                                              color: AppColor.fonts,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '  ',
                                          ),
                                          TextSpan(
                                            text: 'Projects Completed',
                                            style: TextStyle(
                                              color: AppColor.fonts,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '00',
                                      style: TextStyle(
                                          color: AppColor.fonts,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 75,
                              decoration: BoxDecoration(
                                color: AppColor.secondary.withOpacity(0.5),
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
                                              Typicons.upload,
                                              size: 14,
                                              color: AppColor.fonts,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '  ',
                                          ),
                                          TextSpan(
                                            text: 'Total Donations',
                                            style: TextStyle(
                                              color: AppColor.fonts,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '00.00 RS',
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
                                color: AppColor.secondary.withOpacity(0.5),
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
                                              Typicons.download,
                                              size: 14,
                                              color: AppColor.fonts,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '  ',
                                          ),
                                          TextSpan(
                                            text: 'Expected Donation',
                                            style: TextStyle(
                                              color: AppColor.fonts,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '00.00 RS',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "My Projects",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.fonts),
                ),
              ),
              StreamBuilder(
                stream: RecipientHelper().getRequestRecords(context),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : snapshot.hasData
                          ? Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return snapshot.data[index];
                                },
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Text(
                                  'No Record Found',
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
