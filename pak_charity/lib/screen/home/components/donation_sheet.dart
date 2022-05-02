import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/screen/home/donaton_steps/step_1.dart';
import 'package:pak_charity/screen/home/donaton_steps/step_2.dart';
import 'package:pak_charity/screen/home/donaton_steps/step_3.dart';
import 'package:pak_charity/utils/jazz_cash_helper.dart';

class DonationSheet extends StatefulWidget {
  const DonationSheet({Key key}) : super(key: key);

  @override
  State<DonationSheet> createState() => _DonationSheetState();
}

class _DonationSheetState extends State<DonationSheet> {
  final donationMoney = ''.obs;
  final otheramount = ''.obs;
  final paymentMethod = ''.obs;
  final accountNo = ''.obs;
  @override
  Widget build(BuildContext context) {
    List<CoolStep> steps = [
      step1(context, donationMoney, otheramount),
      step2(context, paymentMethod, accountNo),
      step3(donationMoney, paymentMethod, accountNo, otheramount),
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: CoolStepper(
        showErrorSnackbar: false,
        onCompleted: () {
          JazzCashHelper().payment(donationMoney, accountNo, otheramount);
        },
        steps: steps,
        config: CoolStepperConfig(
          titleTextStyle: TextStyle(
            color: AppColor.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          subtitleTextStyle: TextStyle(color: AppColor.white),
          headerColor: AppColor.primary,
          iconColor: AppColor.white,
          backText: 'Back',
          finalText: 'Proceed',
          nextText: 'Next',
        ),
      ),
    );
  }
}
