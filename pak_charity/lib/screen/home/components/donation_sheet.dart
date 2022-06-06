import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/utils/stripe_helper.dart';

class DonationSheet extends StatelessWidget {
  final String requestId;
  final Map<String, dynamic> data;
  DonationSheet({Key key, @required this.data, @required this.requestId})
      : super(key: key);

  final paymentController = Get.put(PaymentController());
  final donationMoney = ''.obs;
  final otheramount = ''.obs;
  final paymentMethod = ''.obs;
  final accountNo = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              color: AppColor.appThemeColor,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'How much payment do you want to donate',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: AppColor.white.withOpacity(0.8),
                child: RadioListTile(
                  value: '500',
                  groupValue: donationMoney.value,
                  onChanged: (value) {
                    donationMoney.value = value;
                  },
                  title: const Text('500 PKR'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: AppColor.white.withOpacity(0.8),
                child: RadioListTile(
                  value: '1000',
                  groupValue: donationMoney.value,
                  onChanged: (value) {
                    donationMoney.value = value;
                  },
                  title: const Text('1000 PKR'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: AppColor.white.withOpacity(0.8),
                child: RadioListTile(
                  value: '2500',
                  groupValue: donationMoney.value,
                  onChanged: (value) {
                    donationMoney.value = value;
                  },
                  title: const Text('2500 PKR'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: AppColor.white.withOpacity(0.8),
                child: RadioListTile(
                  value: '5000',
                  groupValue: donationMoney.value,
                  onChanged: (value) {
                    donationMoney.value = value;
                  },
                  title: const Text('5000 PKR'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'or',
                style: TextStyle(color: AppColor.fonts.withOpacity(0.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: AppColor.white.withOpacity(0.8),
                child: RadioListTile(
                  value: 'other',
                  groupValue: donationMoney.value,
                  onChanged: (value) {
                    donationMoney.value = value;
                  },
                  title: const Text('Other Amount'),
                ),
              ),
            ),
            donationMoney.value == 'other'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      color: AppColor.white,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "0.00 PKR",
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                        ),
                        onChanged: (value) {
                          otheramount.value = value;
                        },
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColor.primary),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    AppColor.white,
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery.of(context).size.width, 50),
                  ),
                  overlayColor: MaterialStateProperty.all<Color>(
                      AppColor.white.withOpacity(0.1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  paymentController
                      .makePayment(
                    amount: donationMoney.value == 'other'
                        ? otheramount.value
                        : donationMoney.value,
                    currency: 'PKR',
                  )
                      .then(
                    (value) async {
                      if (value == null) {
                        await FirebaseFirestore.instance
                            .collection('donation_requests')
                            .doc(requestId)
                            .get()
                            .then(
                          (value) async {
                            double totalReceved =
                                double.parse(value.data()['donationRecived']) +
                                    double.parse(donationMoney.value == 'other'
                                        ? otheramount.value
                                        : donationMoney.value);
                            await FirebaseFirestore.instance
                                .collection('donation_requests')
                                .doc(requestId)
                                .update(
                              {
                                'donationRecived': totalReceved.toString(),
                              },
                            ).whenComplete(
                              () async {
                                await FirebaseFirestore.instance
                                    .collection('donations')
                                    .doc()
                                    .set(
                                  {
                                    'donor_id': user.uid,
                                    'request_id': requestId,
                                    'amount_donated':
                                        donationMoney.value == 'other'
                                            ? otheramount.value
                                            : donationMoney.value,
                                  },
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  );
                },
                child: const Text('Proceed to Pay'),
              ),
            ),
          ],
        );
      },
    );
  }
}
