import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/components/project_card.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/home/components/donation_sheet.dart';
import 'package:pak_charity/screen/home/components/view_details_sheet.dart';
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
        .putFile(thumbnailPath);
    return taskSnapshot.ref.getDownloadURL();
  }

  Stream<Widget> getRequestRecords(context) async* {
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

  Stream<Widget> getCompletedProjects(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('project_completed')
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

  Stream<List<Widget>> getDonationRequests(context, index, search) async* {
    List<Widget> x = [];
    List<String> filters = [
      'All',
      'Health',
      'Humanity',
      'Food',
      'Education',
      'Religion',
    ];
    if (search == '') {
      if (index != 0) {
        await FirebaseFirestore.instance
            .collection('donation_requests')
            .where('status', isEqualTo: '1')
            .where('donationType', isEqualTo: filters[index])
            .get()
            .then(
          (value) async {
            for (var item in value.docs) {
              if (item['recipientId'] != user.uid) {
                await FirebaseFirestore.instance
                    .collection('user')
                    .doc(item.data()['recipientId'])
                    .get()
                    .then((value) {
                  x.add(
                    ProjectCard(
                      requestId: item.id,
                      amountNeed: double.parse(item.data()['amountNeeded']),
                      collectedPercentage:
                          (double.parse((item.data()['donationRecived'])) /
                                  double.parse((item.data()['amountNeeded']))) *
                              100,
                      details: item.data()['projectDescription'],
                      imageURL: item.data()['image'],
                      title: item.data()['projectTitle'],
                      donate: () {
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
                              data: item.data(),
                              requestId: item.id,
                            ),
                          ),
                        );
                      },
                      viewDetails: () {
                        Get.to(ViewDetailSheet(
                          recipientId: value.id,
                          data: item.data(),
                          recipientDetails: value.data(),
                          requestId: item.id,
                        ));
                      },
                    ),
                  );
                });
              }
            }
          },
        );
      } else {
        await FirebaseFirestore.instance
            .collection('donation_requests')
            .where('status', isEqualTo: '1')
            .get()
            .then(
          (value) async {
            for (var item = 0; item < value.docs.length; item++) {
              if (double.parse(value.docs[item]['donationRecived']) >=
                  double.parse(value.docs[item]['amountNeeded'])) {
                await FirebaseFirestore.instance
                    .collection('project_completed')
                    .doc()
                    .set(value.docs[item].data())
                    .whenComplete(() async {
                  await FirebaseFirestore.instance
                      .collection('donation_requests')
                      .doc(value.docs[item].id)
                      .delete();
                });
              } else {
                if (value.docs[item]['recipientId'] != user.uid) {
                  await FirebaseFirestore.instance
                      .collection('user')
                      .doc(value.docs[item].data()['recipientId'])
                      .get()
                      .then((user) {
                    x.add(
                      ProjectCard(
                        requestId: value.docs[item].id,
                        amountNeed: double.parse(
                            value.docs[item].data()['amountNeeded']),
                        collectedPercentage: (double.parse((value.docs[item]
                                    .data()['donationRecived'])) /
                                double.parse((value.docs[item]
                                    .data()['amountNeeded']))) *
                            100,
                        details: value.docs[item].data()['projectDescription'],
                        imageURL: value.docs[item].data()['image'],
                        title: value.docs[item].data()['projectTitle'],
                        donate: () {
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
                                data: value.docs[item].data(),
                                requestId: value.docs[item].id,
                              ),
                            ),
                          );
                        },
                        viewDetails: () {
                          Get.to(
                            ViewDetailSheet(
                              recipientId: user.id,
                              data: value.docs[item].data(),
                              recipientDetails: user.data(),
                              requestId: value.docs[item].id,
                            ),
                          );
                        },
                      ),
                    );
                  });
                }
              }
            }
          },
        );
      }
    } else {
      await FirebaseFirestore.instance
          .collection('donation_requests')
          .where('status', isEqualTo: '1')
          .get()
          .then(
        (value) async {
          for (var item in value.docs) {
            if (item['projectTitle'].contains(search.toString())) {
              if (item['recipientId'] != user.uid) {
                await FirebaseFirestore.instance
                    .collection('user')
                    .doc(item.data()['recipientId'])
                    .get()
                    .then((value) {
                  x.add(
                    ProjectCard(
                      requestId: item.id,
                      amountNeed: double.parse(item.data()['amountNeeded']),
                      collectedPercentage:
                          (double.parse((item.data()['donationRecived'])) /
                                  double.parse((item.data()['amountNeeded']))) *
                              100,
                      details: item.data()['projectDescription'],
                      imageURL: item.data()['image'],
                      title: item.data()['projectTitle'],
                      donate: () {
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
                              data: item.data(),
                              requestId: item.id,
                            ),
                          ),
                        );
                      },
                      viewDetails: () {
                        Get.to(ViewDetailSheet(
                          recipientId: value.id,
                          data: item.data(),
                          recipientDetails: value.data(),
                          requestId: item.id,
                        ));
                      },
                    ),
                  );
                });
              }
            }
          }
        },
      );
    }
    yield x;
  }

  Stream<List<Widget>> getFavoriteDonationRequests(context) async* {
    List<Widget> x = [];
    for (var req in prefs.getStringList('favorites')) {
      await FirebaseFirestore.instance
          .collection('donation_requests')
          .doc(req)
          .get()
          .then(
        (value) async {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(value.data()['recipientId'])
              .get()
              .then((userData) {
            x.add(
              ProjectCard(
                requestId: value.id,
                amountNeed: double.parse(value.data()['amountNeeded']),
                collectedPercentage:
                    (double.parse((value.data()['donationRecived'])) /
                            double.parse((value.data()['amountNeeded']))) *
                        100,
                details: value.data()['projectDescription'],
                imageURL: value.data()['image'],
                title: value.data()['projectTitle'],
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
                        data: value.data(),
                        requestId: value.id,
                      ),
                    ),
                  );
                },
                viewDetails: () {
                  Get.to(ViewDetailSheet(
                    recipientId: userData.id,
                    data: value.data(),
                    recipientDetails: userData.data(),
                    requestId: value.id,
                  ));
                },
              ),
            );
          });
        },
      );
    }
    yield x;
  }

  Stream<String> donationNeed() async* {
    double donations = 0.0;
    await FirebaseFirestore.instance
        .collection('donation_requests')
        .where('recipientId', isEqualTo: user.uid)
        .get()
        .then((value) {
      for (var item in value.docs) {
        donations = double.parse(item['amountNeeded']) + donations;
      }
    });
    yield donations.toString();
  }

  Stream<String> donationRecived() async* {
    double recivedDonations = 0.0;
    double expectedDonations = 0.0;
    await FirebaseFirestore.instance
        .collection('donation_requests')
        .where('recipientId', isEqualTo: user.uid)
        .get()
        .then((value) {
      for (var item in value.docs) {
        recivedDonations =
            double.parse(item['donationRecived']) + recivedDonations;
        expectedDonations =
            double.parse(item['amountNeeded']) + expectedDonations;
      }
    });
    yield (expectedDonations - recivedDonations).toString();
  }
}
