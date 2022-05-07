import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pak_charity/constants/components/project_card.dart';
import 'package:path/path.dart';

class RecipientHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  Future uploadRequest(data) async {
    await FirebaseFirestore.instance.collection('donation_requests').add(data);
  }

  Future<String> uploadThumbnail(File thumbnailPath) async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child('thumbnails')
        .child(FirebaseAuth.instance.currentUser.uid +
            '_' +
            basename(thumbnailPath.path))
        .putFile(File(thumbnailPath.path));
    return taskSnapshot.ref.getDownloadURL();
  }

  Stream<List<Widget>> getRequestRecords(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('donation_requests')
        .where('recipientId', isEqualTo: user.uid)
        .get()
        .then(
      (value) {
        for (var item in value.docs) {
          x.add(
            InkWell(
              onTap: () {},
              child: RecipientProjectCard(
                amountNeed: double.parse(item['amountNeeded']),
                collectedPercentage: (double.parse((item['donationRecived'])) /
                        double.parse((item['amountNeeded']))) *
                    100,
                details: item['projectDescription'],
                imageURL: item['image'],
                title: item['projectTitle'],
              ),
            ),
          );
        }
      },
    );
    yield x;
  }
}
