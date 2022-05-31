import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/components/components.dart';
import 'package:pak_charity/constants/components/project_card.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/model/recipient_model.dart';
import 'package:pak_charity/screen/home/components/donation_sheet.dart';
import 'package:pak_charity/screen/home/components/view_details_sheet.dart';
import 'package:path/path.dart';

class RecipientHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  Future uploadRequest(data) async {
    await FirebaseFirestore.instance.collection('donation_requests').add(data);
  }

  Future<String> uploadThumbnail(File? thumbnailPath) async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child('thumbnails')
        .child(FirebaseAuth.instance.currentUser!.uid +
            '_' +
            basename(thumbnailPath!.path))
        .putFile(File(thumbnailPath.path));
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
    yield x;
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
              recipientDetails: value.data()!,
              data: item.data(),
              email: value.data()!['email'],
              phoneNo: value.data()!['phoneNo'],
              recipientName: value.data()!['fullName'],
            ));
          });
        }
      },
    );
    yield x;
  }

  Stream<List<RecipientModel>> getDonationRequests(context) async* {
    List<RecipientModel> x = [];
    await FirebaseFirestore.instance
        .collection('donation_requests')
        .where('status', isEqualTo: '1')
        .get()
        .then(
      (value) async {
        for (var item in value.docs) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(item.data()['recipientId'])
              .get()
              .then((userData) {
            x.add(
              RecipientModel(
                requestId: item.id.toString(),
                imageURL: item.data()['image'],
                title: item.data()['projectTitle'],
                details: item.data()['projectDescription'],
                amountNeed: double.parse(item.data()['amountNeeded']),
                donationType: item.data()['donationType'],
                collectedPercentage:
                    (double.parse((item.data()['donationRecived'])) /
                            double.parse((item.data()['amountNeeded']))) *
                        100,
                viewDetails: () {
                  Get.to(ViewDetailSheet(
                    data: item.data(),
                    recipientDetails: userData.data()!,
                    requestId: item.id,
                  ));
                },
                donate: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: false,
                    useRootNavigator: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) => Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: DonationSheet(
                        data: item.data(),
                        requestId: item.id,
                      ),
                    ),
                  );
                },
              ),
            );
          });
        }
      },
    );
    yield x;
  }
}
