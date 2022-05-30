import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pak_charity/constants/components/components.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/auth/login_screen.dart';
import 'package:pak_charity/screen/home/menu_darwer.dart';
import 'package:pak_charity/utils/auth_helper.dart';
import 'package:pak_charity/utils/helper.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key key}) : super(key: key);
  String initialCountry = 'PK';
  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  final isVisible = true.obs;
  final isValidNo = true.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  //Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
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
            child: Form(
              key: formKey,
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
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullName,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'please enter your full name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                                hintText: 'Your full name',
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: email,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => Helper.validateEmail(value),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Your email address',
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {},
                              onInputValidated: (bool value) {
                                isValidNo.value = value;
                              },
                              selectorConfig: const SelectorConfig(
                                selectorType: PhoneInputSelectorType.DIALOG,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter your phone number';
                                } else if (isValidNo.value == false) {
                                  return 'please enter valid phone number';
                                } else {
                                  return null;
                                }
                              },
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: phoneNo,
                              formatInput: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputDecoration: const InputDecoration(
                                labelText: 'Phone No.',
                                hintText: 'Your phone no.',
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) =>
                                      Helper.validatePassword(value),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Your secret password',
                                    helperMaxLines: 6,
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
                              height: 5,
                            ),
                            Obx(
                              () {
                                return TextFormField(
                                  controller: confirmPassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: isVisible.value,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'please enter your confirm password';
                                    } else if (value != password.text) {
                                      return 'password doesn\'t match';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    hintText: 'Confirm your password',
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
                                  if (formKey.currentState.validate()) {
                                    Components.showAlertDialog(context);
                                    AuthenticationHelper()
                                        .signUp(
                                      email: email.text,
                                      password: confirmPassword.text,
                                      context: context,
                                    )
                                        .then((result) {
                                      if (result != null) {
                                        FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(result.user.uid)
                                            .set({
                                          'fullName': fullName.text,
                                          'email': email.text,
                                          'phoneNo': phoneNo.text,
                                          'userType': 'donor'
                                        }).whenComplete(() {
                                          prefs.setString(
                                              'Username', fullName.text);
                                          prefs.setString(
                                              'UserID', result.user.uid);
                                          prefs.setString('Email', email.text);
                                          prefs.setString(
                                              'PhoneNo', phoneNo.text);
                                          prefs.setString('UserType', 'donor');
                                          Navigator.of(context).pop();
                                          Components.showSnackBar(context,
                                              'Wellcome ${fullName.text}');
                                          Get.off(MenuDrawer());
                                        }).catchError((e) {
                                          Navigator.of(context).pop();
                                          Components.showSnackBar(context, e);
                                        });
                                      } else {
                                        Navigator.of(context).pop();
                                        Components.showSnackBar(
                                            context, result);
                                      }
                                    }).catchError((e) {
                                      Navigator.of(context).pop();
                                      Components.showSnackBar(context, e);
                                    });
                                  }
                                },
                                child: const Text('Sign Up'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('OR'),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Components.showAlertDialog(context);
                                  AuthenticationHelper()
                                      .signInWithGoogle()
                                      .then((value) {
                                    if (value != null) {
                                      final FirebaseAuth _auth =
                                          FirebaseAuth.instance;
                                      FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(_auth.currentUser.uid)
                                          .set({
                                        'fullName': value.displayName,
                                        'email': value.email,
                                        'phoneNo': value.phoneNumber,
                                        'userType': 'donor'
                                      }).whenComplete(() {});
                                      Navigator.of(context).pop();
                                      Components.showSnackBar(context,
                                          'Wellcome ${value.displayName}');
                                      Get.off(MenuDrawer());
                                    }
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColor.primary),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColor.primary.withOpacity(0.1)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: BorderSide(color: AppColor.primary),
                                    ),
                                  ),
                                ),
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(
                                          FontAwesome.google,
                                        ),
                                      ),
                                      TextSpan(text: '  '),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Text('Sign up with Google'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: AppColor.fonts,
                              ),
                            ),
                          ),
                          const TextSpan(text: '  '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: InkWell(
                              onTap: () {
                                Get.to(LoginScreen());
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
