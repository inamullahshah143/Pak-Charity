import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';

CoolStep step3(donationMoney, paymentMethod, accountNo, otheramount) {
  return CoolStep(
    title: 'Verify Your Details',
    subtitle: 'Please verify the give details, is correct',
    content: Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
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
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColor.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primary.withOpacity(0.5),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Text(
              donationMoney.value == 'other'
                  ? '${otheramount.value.toString()}.00 PKR'
                  : '${donationMoney.value.toString()}.00 PKR',
              style: TextStyle(
                fontSize: 24,
                color: AppColor.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
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
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColor.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primary.withOpacity(0.5),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Text(
              paymentMethod.value.toString(),
              style: TextStyle(
                fontSize: 24,
                color: AppColor.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
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
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColor.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primary.withOpacity(0.5),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Text(
              '+92${accountNo.toString()}',
              style: TextStyle(
                fontSize: 24,
                color: AppColor.white,
              ),
            ),
          ),
        ],
      );
    }),
    validation: () {
      return null;
    },
  );
}
