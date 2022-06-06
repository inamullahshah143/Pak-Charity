class ChatHelper {
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "${user1.replaceAll(' ', '_')}_${user2.replaceAll(' ', '_')}";
    } else {
      return "${user2.replaceAll(' ', '_')}_${user1.replaceAll(' ', '_')}";
    }
  }
}


//  String roomId = ChatHelper().chatRoomId(
//                                       value.docs.first.data()['username'],
//                                       prefs.getString('Username').toString());
//                                   Get.to(
//                                     ChatRoom(
//                                       holderId: value.docs.first.id,
//                                       userMap: value.docs.first.data(),
//                                       chatRoomId: roomId,
//                                       phoneNumber: contactList[index]
//                                           ['phone_no'],
//                                     ),
//                                   );