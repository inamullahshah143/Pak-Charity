import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/color.dart';

CoolStep step2(context, paymentMethod) {
  return CoolStep(
    title: 'Select Payment Method',
    subtitle: 'Payment method by which you have to transfer your money.',
    content: Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Payment Methods',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.fonts,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              child: RadioListTile(
                value: 'JazzCash',
                title: const Text('JazzCash'),
                groupValue: paymentMethod.value,
                onChanged: (value) {
                  paymentMethod.value = value;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              child: RadioListTile(
                value: 'EasyPaisa',
                title: const Text('EasyPaisa'),
                toggleable: true,
                groupValue: paymentMethod.value,
                onChanged: (value) {
                  paymentMethod.value = value;
                },
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: AppColor.white,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "3XX XXXXXXX",
                  prefix: Text('+92 '),
                  hintStyle: TextStyle(
                    fontSize: 16,
                  ),
                  contentPadding: EdgeInsets.all(15),
                ),
                style: const TextStyle(
                  fontSize: 16,
                ),
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
