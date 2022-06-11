import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/chat/chat_room.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/utils/helper.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColor.fonts,
          ),
        ),
        title: Text(
          'Messages',
          style: TextStyle(
            fontSize: 18,
            color: AppColor.fonts,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: getChat(context),
          builder: ((context, snapshot) {
            return snapshot.data ?? Container();
          }),
        ),
      ),
    );
  }

  Stream<Widget> getChat(context) async* {
    List x = <Widget>[];
    await FirebaseFirestore.instance
        .collection('chat_list')
        .where('donor_id', isEqualTo: user.uid)
        .get()
        .then((value) async {
      for (var item in value.docs) {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(item['recipient_id'])
            .get()
            .then((user) {
          x.add(
            Card(
              child: ListTile(
                onTap: () {
                  Get.to(
                    ChatRoom(
                      recipientId: item.data()['recipient_id'],
                      userMap: user.data(),
                      chatRoomId: item.data()['chat_room_id'],
                      phoneNumber: user.data()['phoneNo'],
                    ),
                  );
                },
                leading: CircleAvatar(child: Text(user.data()['fullName'][0])),
                title: Text(user.data()['fullName']),
                trailing: IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () async {
                    Helper().callNumber(context, user.data()['phoneNo']);
                  },
                ),
              ),
            ),
          );
        });
      }
    });

    yield Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: x.length,
        itemBuilder: (context, index) {
          return x[index];
        },
      ),
    );
  }
}
