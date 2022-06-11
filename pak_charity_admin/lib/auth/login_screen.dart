import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity_admin/admin/admin_home.dart';
import 'package:pak_charity_admin/auth/forget_password.dart';
import 'package:pak_charity_admin/constants/components/components.dart';
import 'package:pak_charity_admin/constants/widgets/color.dart';
import 'package:pak_charity_admin/main.dart';
import 'package:pak_charity_admin/utils/auth_helper.dart';
import 'package:pak_charity_admin/utils/helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  final isVisible = true.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pagesColor,
      appBar: AppBar(
        backgroundColor: AppColor.pagesColor,
        elevation: 0,
        automaticallyImplyLeading: false,
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
                              'Admin Login',
                              style: TextStyle(
                                color: AppColor.fonts,
                                fontSize: 28,
                              ),
                            ),
                            TextFormField(
                              controller: email,
                              validator: (value) => Helper.validateEmail(value),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Your email address',
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () {
                                return TextFormField(
                                  controller: password,
                                  obscureText: isVisible.value,
                                  validator: (value) =>
                                      Helper.validatePassword(value),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Your secret password',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        isVisible.value = !isVisible.value;
                                      },
                                      icon: isVisible.value
                                          ? const Icon(
                                              Icons.visibility_off,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(ForgetPassword());
                                },
                                child: Text(
                                  "Forget your password?",
                                  style: TextStyle(
                                    color: AppColor.fonts,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
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
                                  if (formKey.currentState.validate()) {
                                    Components.showAlertDialog(context);
                                    AuthenticationHelper()
                                        .signIn(
                                      email: email.text,
                                      password: password.text,
                                      context: context,
                                    )
                                        .then((result) {
                                      if (result != null) {
                                        FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(result.user.uid)
                                            .get()
                                            .then((value) async {
                                          if (value.data()['userType'] ==
                                              'admin') {
                                            prefs.setString('Username',
                                                value.data()['fullName']);
                                            prefs.setString(
                                                'UserID', result.user.uid);
                                            prefs.setString(
                                                'Email', value.data()['email']);
                                            prefs.setString('PhoneNo',
                                                value.data()['phoneNo']);
                                            prefs.setString('UserType',
                                                value.data()['userType']);

                                            Navigator.of(context).pop();
                                            Components.showSnackBar(
                                                context, 'Welcome back');
                                            Get.offAll(const AdminHome());
                                          } else {
                                            Navigator.of(context).pop();
                                            Components.showSnackBar(context,
                                                'Your are not allowed to enter from this panel');
                                          }
                                        });
                                      }
                                    }).catchError((e) {
                                      Components.showSnackBar(context, e);
                                      Navigator.of(context).pop();
                                    });
                                  }
                                },
                                child: const Text('Sign In'),
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
