import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/screen/admin/donation_details.dart';
import 'package:pak_charity/utils/helper.dart';

class DonationHelper {
  Stream<Widget> getAllDonations(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance.collection('donations').get().then(
      (value) async {
        for (var item in value.docs) {
          await FirebaseFirestore.instance
              .collection('donation_requests')
              .doc(item.data()['request_id'])
              .get()
              .then((request) async {
            await FirebaseFirestore.instance
                .collection('user')
                .doc(item.data()['donor_id'])
                .get()
                .then((user) {
              x.add(
                ListTile(
                  onTap: () {},
                  title: Text(user.data()['username']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Donation : RS ' +
                          item.data()['amount_donated'] +
                          '.00'),
                      ButtonBar(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                AppColor.white,
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  decoration: BoxDecoration(
                                    color: AppColor.secondary,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0),
                                    ),
                                  ),
                                  child: DonationDetails(
                                    data: request.data(),
                                  ),
                                ),
                              );
                            },
                            child: const Text('View Details'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.call),
                            onPressed: () {
                              Helper()
                                  .callNumber(context, user.data()['phone_no']);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
          });
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
}
