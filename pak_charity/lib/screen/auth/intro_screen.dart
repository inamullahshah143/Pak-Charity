import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_slider/introduction_slider.dart';
import 'package:pak_charity/main.dart';

import 'login_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionSlider(
        onDone: LoginScreen(),
        skip: MaterialButton(
          child: const Text('Skip'),
          onPressed: () {
            introSeen();
            Get.offAll(LoginScreen());
          },
        ),
        items: [
          IntroductionSliderItem(
            image: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/images/step-1.png'),
            ),
            title: "Donation",
            description:
                "Always give without remembering and \n   always receive without forgetting.",
          ),
          IntroductionSliderItem(
            image: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/images/step-2.png'),
            ),
            title: "Change Lives",
            description:
                "Charity helping people facing challenging \n times to make positive change for good.",
          ),
          IntroductionSliderItem(
            image: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/images/step-3.png'),
            ),
            title: "Safe Payment",
            description:
                "Happiness doesn’t result from what we \n         get, but from what we give.",
          ),
        ],
      ),
    );
  }

  Future introSeen() async {
    prefs.setBool('IntroSeen', true);
  }
}
