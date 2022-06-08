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
            title: "Introduction Slider 1",
            description: "This is a description of introduction slider 1.",
          ),
          IntroductionSliderItem(
            image: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/images/step-2.png'),
            ),
            title: "Introduction Slider 2",
            description: "This is a description of introduction slider 2.",
          ),
          IntroductionSliderItem(
            image: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/images/step-3.png'),
            ),
            title: "Introduction Slider 3",
            description: "This is a description of introduction slider 3.",
          ),
        ],
      ),
    );
  }

  Future introSeen() async {
    prefs.setBool('IntroSeen', true);
  }
}
