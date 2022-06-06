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
    var result = await FirebaseFirestore.instance.collection('chat_list').get();

    for (var item in result.docs) {
      if (item['donor_id'] == user.uid || item['recipient_id'] == user.uid) {
        x.add(
          Card(
            child: ListTile(
              onTap: () {
                Get.to(
                  ChatRoom(
                    recipientId: item.data()['recipient_id'],
                    userMap: item.data(),
                    chatRoomId: item.data()['chat_room_id'],
                    phoneNumber: item.data()['phone_no'],
                  ),
                );
              },
              leading: CircleAvatar(child: Text(item.data()['username'][0])),
              title: Text(item.data()['username']),
              subtitle: Text(item.data()['email']),
              trailing: IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () async {
                  Helper().callNumber(context, item.data()['phone_no']);
                },
              ),
            ),
          ),
        );
      }
    }

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
