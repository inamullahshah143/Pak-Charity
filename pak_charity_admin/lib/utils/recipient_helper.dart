import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pak_charity_admin/constants/components/components.dart';
import 'package:pak_charity_admin/constants/components/project_card.dart';
import 'package:pak_charity_admin/constants/widgets/color.dart';
import 'package:path/path.dart';

class RecipientHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
 

  Future<String> uploadThumbnail(File thumbnailPath) async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child('thumbnails')
        .child(FirebaseAuth.instance.currentUser.uid +
            '_' +
            basename(thumbnailPath.path))
        .putFile(thumbnailPath);
    return taskSnapshot.ref.getDownloadURL();
  }

  Future requestAction(context, requestId, status) async {
    await FirebaseFirestore.instance
        .collection('donation_requests')
        .doc(requestId)
        .update({'status': status}).catchError((e) {
      Components.showSnackBar(context, e.toString());
    });
  }

  Stream<Widget> getAllCompletedProjects(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance.collection('project_completed').get().then(
      (value) {
        for (var item in value.docs) {
          x.add(
            InkWell(
              onTap: () {},
              child: RecipientProjectCard(
                amountNeed: double.parse(item.data()['amountNeeded']),
                collectedPercentage:
                    (double.parse((item.data()['donationRecived'])) /
                            double.parse((item.data()['amountNeeded']))) *
                        100,
                details: item.data()['projectDescription'],
                imageURL: item.data()['image'],
                title: item.data()['projectTitle'],
                status: item.data()['status'],
              ),
            ),
          );
        }
      },
    );
    yield x.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: x.length,
            itemBuilder: (context, index) {
              return x[index];
            },
          )
        : Center(
            child: Text(
              'No Record Found',
              style: TextStyle(
                color: AppColor.secondary,
              ),
            ),
          );
  }

  Stream<List<Widget>> getDonationRequestRecords(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('donation_requests')
        .where('status', isEqualTo: '0')
        .get()
        .then(
      (value) async {
        for (var item in value.docs) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(item.data()['recipientId'])
              .get()
              .then((value) {
            x.add(RequestApprovelCard(
              requestId: item.id,
              recipientDetails: value.data(),
              data: item.data(),
              email: value.data()['email'],
              phoneNo: value.data()['phone_no'],
              recipientName: value.data()['username'],
            ));
          });
        }
      },
    );
    yield x;
  }
}
