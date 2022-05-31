import 'package:flutter/material.dart';
import 'package:pak_charity/constants/components/components.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/utils/auth_helper.dart';
import 'package:pak_charity/utils/helper.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pagesColor,
      appBar: AppBar(
        backgroundColor: AppColor.pagesColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: AppColor.fonts,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/background.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.secondary,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text(
                              'Reset Password',
                              style: TextStyle(
                                color: AppColor.fonts,
                                fontSize: 28,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Please enter your email to recieve a link to create a new password via email",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.fonts,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: email,
                              validator: (value) => Helper.validateEmail(value!),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Your email address',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColor.white),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColor.white.withOpacity(0.1)),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    Components.showAlertDialog(context);
                                    AuthenticationHelper()
                                        .resetPassword(context, email.text)
                                        .then((res) {
                                      if (res == null) {
                                        Navigator.of(context).pop();
                                        Components.showSnackBar(context,
                                            'Your password rest link has been send to your repective email, please have a look');
                                      }
                                    });
                                  }
                                },
                                child: const Text('Send'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
