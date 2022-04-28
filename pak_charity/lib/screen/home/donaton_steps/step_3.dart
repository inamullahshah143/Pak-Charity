import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/cupertino.dart';

CoolStep step3() {
  return CoolStep(
    title: 'Verify Your Details',
    subtitle: 'Please checkout the give details, is correct',
    content: Column(
      children: const [],
    ),
    validation: () {
      return null;
    },
  );
}
