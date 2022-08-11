import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

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
          'Privacy Policy',
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
              'Privacy Policy',
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
              'F & A built the Pak Charity app as a Free app. This SERVICE is provided by F & A at no cost and is intended for use as is This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Pak Charity unless otherwise defined in this Privacy Policy.',
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
              'Information Collection and Use',
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
              'For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Charity, Helping. The information that I request will be retained on your device and is not collected by me in any way. The app does use third-party services that may collect information used to identify you. Link to the privacy policy of third-party service providers used by the app.',
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
                left: 18.0, top: 0.0, right: 0.0, bottom: 5.0),
            child: Text(
              '•	Google Play Services',
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
              'Security',
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
              'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.',
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
              'Stripe (Agreement)',
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
              'This Agreement provides a general description of the Services that Stripe may provide to you, including those that allow you to accept payments from purchasers of your goods or services or donors to your organization (your “Customers”). We provide you with a more detailed description of the Services through published software libraries and application programming interfaces that may be used to access the Services (the “API”) and additional resources we make available to you on our website.',
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
              'Changes to This Privacy Policy',
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
              'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page. This policy is effective as of July 06, 2022',
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
              'Contact Us',
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
              'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact us at mailto:pakcharity31@gmail.com.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                height: 1.25,
                color: AppColor.fonts,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
