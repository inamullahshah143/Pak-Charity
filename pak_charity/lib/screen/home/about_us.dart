import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 14.0, top: 20.0, right: 0.0, bottom: 0.0),
            child: Text(
              'Who We Are?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.fonts,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              'We have been delivering aid and development programmes to transform lives.\n \nMotivated by our faith, Pak Charity seeks a world of hope, tolerance and social justice where poverty has been overcome and people live in dignity.\n \nWe serve the poor and impoverished as a demonstration of God’s unconditional love for all people regardless of race, religion or gender.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                height: 1.25,
                color: AppColor.fonts,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 14.0, top: 20.0, right: 0.0, bottom: 0.0),
            child: Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.fonts,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              'To create a world of harmony where people of all backgrounds can appreciate life with good health, education and a livelihood.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                height: 1.25,
                color: AppColor.fonts,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 14.0, top: 20.0, right: 0.0, bottom: 0.0),
            child: Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.fonts,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              'Our mission is saving lives in emergencies and to help the needy by adopting practical ways to root out poverty from the world through provision of education and a livelihood.\n\nOur mission is carried out by developing health and educational infrastructures along with providing access to safe water and creating opportunities for livelihoods. We also have as our mission to provide long-term sustainable assistance to the vulnerable communities and facilitating them towards self-reliance.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                height: 1.25,
                color: AppColor.fonts,
              ),
            ),
          )
        ],
      ),
    );
  }
}
