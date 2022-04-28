import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:pak_charity/constants/color.dart';

CoolStep step3(donationMoney, paymentMethod) {
  return CoolStep(
    title: 'Verify Your Details',
    subtitle: 'Please verify the give details, is correct',
    content: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Amount Total',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.fonts,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColor.secondary,
            boxShadow: [
              BoxShadow(
                color: AppColor.fonts,
                blurRadius: 1.0,
                spreadRadius: 1.0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Text(
            donationMoney,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.fonts,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColor.secondary,
            boxShadow: [
              BoxShadow(
                color: AppColor.fonts,
                blurRadius: 1.0,
                spreadRadius: 1.0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Text(
            donationMoney,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Account No.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.fonts,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColor.secondary,
            boxShadow: [
              BoxShadow(
                color: AppColor.fonts,
                blurRadius: 1.0,
                spreadRadius: 1.0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Text(
            donationMoney,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    validation: () {
      return null;
    },
  );
}
