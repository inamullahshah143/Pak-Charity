import 'package:background_app_bar/background_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/chat/chat_room.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/home/components/donation_sheet.dart';
import 'package:pak_charity/utils/chat_helper.dart';
import 'package:pak_charity/utils/helper.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ViewDetailSheet extends StatelessWidget {
  final String requestId;
  final String recipientId;
  final Map<String, dynamic> data;
  final Map<String, dynamic> recipientDetails;
  const ViewDetailSheet({
    Key key,
    @required this.data,
    @required this.recipientDetails,
    @required this.requestId,
    @required this.recipientId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pagesColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            collapsedHeight: MediaQuery.of(context).size.height * 0.075,
            elevation: 0,
            backgroundColor: AppColor.pagesColor,
            automaticallyImplyLeading: false,
            pinned: true,
            leadingWidth: 50,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: AppColor.white,
                textColor: AppColor.fonts,
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.arrow_back,
                  size: 18,
                ),
                shape: const CircleBorder(),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.height, 75),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  dense: true,
                  isThreeLine: true,
                  title: Text(
                    data['projectTitle'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: LinearPercentIndicator(
                      leading: Text(
                        '${data['amountNeeded']} PKR',
                        style: TextStyle(color: AppColor.white),
                      ),
                      trailing: Text(
                        '${data['donationRecived']} PKR',
                        style: TextStyle(color: AppColor.white),
                      ),
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 20.0,
                      percent: ((double.parse((data['donationRecived'])) /
                                  double.parse((data['amountNeeded']))) *
                              100) /
                          100,
                      center: Text(
                        ((double.parse((data['donationRecived'])) /
                                        double.parse((data['amountNeeded']))) *
                                    100)
                                .toStringAsFixed(1) +
                            '%',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: AppColor.fonts),
                      ),
                      barRadius: const Radius.circular(100),
                      progressColor: AppColor.white,
                      backgroundColor: AppColor.secondary.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            flexibleSpace: BackgroundFlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(data['image']),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.secondary.withOpacity(0.25),
                        AppColor.primary,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10),
                  child: Text(
                    'Recipient Details',
                    style: TextStyle(
                      color: AppColor.fonts,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    dense: true,
                    leading: CircleAvatar(
                        child: Text(recipientDetails['fullName'][0])),
                    title: Text(recipientDetails['fullName']),
                    subtitle: Text(recipientDetails['email']),
                    trailing: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: IconButton(
                              icon: const Icon(Icons.phone),
                              onPressed: () async {
                                Helper().callNumber(
                                    context, recipientDetails['phoneNo']);
                              },
                            ),
                          ),
                          const TextSpan(text: ' '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: IconButton(
                              icon: const Icon(FontAwesome.chat_empty),
                              onPressed: () {
                                String roomId = ChatHelper().chatRoomId(
                                    recipientDetails['fullName'],
                                    prefs.getString('Username').toString());
                                Get.to(
                                  ChatRoom(
                                    recipientId: recipientId,
                                    userMap: recipientDetails,
                                    chatRoomId: roomId,
                                    phoneNumber: recipientDetails['phoneNo'],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text(
                'Project Details',
                style: TextStyle(
                  color: AppColor.fonts,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text(
                data['projectDescription'],
                style: TextStyle(
                  color: AppColor.fonts,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text(
                'Estimated Deadline',
                style: TextStyle(
                  color: AppColor.fonts,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text(
                data['estimatedDelivery'],
                style: TextStyle(
                  color: AppColor.fonts,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.primary),
          foregroundColor: MaterialStateProperty.all<Color>(
            AppColor.white,
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(MediaQuery.of(context).size.width * 0.4, 50),
          ),
          overlayColor:
              MaterialStateProperty.all<Color>(AppColor.white.withOpacity(0.1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            useRootNavigator: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) => Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: DonationSheet(
                data: data,
                requestId: requestId,
              ),
            ),
          );
        },
        child: RichText(
          text: const TextSpan(
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text('Donate'),
              ),
              TextSpan(text: '   '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(FontAwesome5.long_arrow_alt_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
