import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pak_charity_admin/constants/widgets/color.dart';
import 'package:pak_charity_admin/utils/helper.dart';

class DonationHelper {
  Stream<Widget> getAllDonations(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance.collection('donations').get().then(
      (value) async {
        for (var item in value.docs) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(item.data()['donor_id'])
              .get()
              .then((user) {
            x.add(
              ListTile(
                title: Text(user.data()['username'].toString() ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () {
                    Helper().callNumber(context, user.data()['phone_no'] ?? '');
                  },
                ),
                subtitle: Text(
                    'Donation : RS ' + item.data()['amount_donated'] + '.00'),
              ),
            );
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
