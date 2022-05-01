import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';

CoolStep step1(context, donationMoney, otheramount) {
  return CoolStep(
    title: 'How much wanna donate?',
    subtitle: 'Please select or enter amount to get started',
    content: Obx(
      () {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                    padding: const EdgeInsets.all(8.0),
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
          ],
        );
      },
    ),
    validation: () {
      return null;
    },
  );
}
