import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/components/components.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/admin/admin.dart';
import 'package:pak_charity/screen/auth/forget_password.dart';
import 'package:pak_charity/screen/auth/sign_up_screen.dart';
import 'package:pak_charity/screen/home/menu_darwer.dart';
import 'package:pak_charity/utils/auth_helper.dart';
import 'package:pak_charity/utils/helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  final isVisible = true.obs;
  final userType = 0.obs;
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
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 0,
                child: Text('Default'),
              ),
              PopupMenuItem(
                value: 1,
                child: Text('Admin'),
              ),
            ],
            onSelected: (int index) {
              userType.value = index;
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/background.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Obx(
          () {
            return userType.value == 0
                ? Center(
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
                                      TextFormField(
                                        controller: email,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) =>
                                            Helper.validateEmail(value),
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
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            obscureText: isVisible.value,
                                            validator: (value) =>
                                                Helper.validatePassword(value),
                                            decoration: InputDecoration(
                                              labelText: 'Password',
                                              hintText: 'Your secret password',
                                              helperMaxLines: 6,
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  isVisible.value =
                                                      !isVisible.value;
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(AppColor.white),
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(AppColor.white
                                                    .withOpacity(0.1)),
                                          ),
                                          onPressed: () {
                                            if (formKey.currentState
                                                .validate()) {
                                              Components.showAlertDialog(
                                                  context);
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
                                                    if (value.data()[
                                                            'userType'] !=
                                                        'admin') {
                                                      prefs.setString(
                                                          'Username',
                                                          value.data()[
                                                              'fullName']);
                                                      prefs.setString('UserID',
                                                          result.user.uid);
                                                      prefs.setString(
                                                          'Email',
                                                          value
                                                              .data()['email']);
                                                      prefs.setString(
                                                          'PhoneNo',
                                                          value.data()[
                                                              'phoneNo']);
                                                      prefs.setString(
                                                          'UserType',
                                                          value.data()[
                                                              'userType']);
                                                      Navigator.of(context)
                                                          .pop();
                                                      Components.showSnackBar(
                                                          context,
                                                          'Welcome back');
                                                      Get.off(MenuDrawer());
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Components.showSnackBar(
                                                          context,
                                                          'Your are not allowed to enter from this panel');
                                                    }
                                                  });
                                                }
                                              }).catchError((e) {
                                                Components.showSnackBar(
                                                    context, e);
                                                Navigator.of(context).pop();
                                              });
                                            }
                                          },
                                          child: const Text('Sign In'),
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Components.showAlertDialog(context);
                                            AuthenticationHelper()
                                                .signInWithGoogle()
                                                .then((value) {
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
                                              }).whenComplete(() async {
                                                prefs.setString('Username',
                                                    value.displayName);
                                                prefs.setString(
                                                    'UserID', value.uid);
                                                prefs.setString(
                                                    'Email', value.email);
                                                prefs.setString('PhoneNo',
                                                    value.phoneNumber);
                                                prefs.setString(
                                                    'UserType', 'donor');
                                                Navigator.of(context).pop();
                                                Components.showSnackBar(
                                                    context, 'Welcome back');
                                                Get.off(MenuDrawer());
                                              });
                                            });
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Colors.transparent,
                                            ),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              AppColor.primary,
                                            ),
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(
                                              AppColor.primary.withOpacity(0.1),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                side: BorderSide(
                                                    color: AppColor.primary),
                                              ),
                                            ),
                                          ),
                                          child: RichText(
                                            text: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .middle,
                                                  child: Icon(
                                                    FontAwesome.google,
                                                  ),
                                                ),
                                                TextSpan(text: '  '),
                                                WidgetSpan(
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .middle,
                                                  child: Text(
                                                      'Sign In with Google'),
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
                                        Get.to(SignupScreen());
                                      },
                                      child: Text(
                                        'Sign Up',
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
                  )
                : Center(
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
                                        validator: (value) =>
                                            Helper.validateEmail(value),
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
                                                  isVisible.value =
                                                      !isVisible.value;
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(AppColor.white),
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(AppColor.white
                                                    .withOpacity(0.1)),
                                          ),
                                          onPressed: () {
                                            if (formKey.currentState
                                                .validate()) {
                                              Components.showAlertDialog(
                                                  context);
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
                                                    if (value.data()[
                                                            'userType'] ==
                                                        'admin') {
                                                      prefs.setString(
                                                          'Username',
                                                          value.data()[
                                                              'fullName']);
                                                      prefs.setString('UserID',
                                                          result.user.uid);
                                                      prefs.setString(
                                                          'Email',
                                                          value
                                                              .data()['email']);
                                                      prefs.setString(
                                                          'PhoneNo',
                                                          value.data()[
                                                              'phoneNo']);
                                                      prefs.setString(
                                                          'UserType',
                                                          value.data()[
                                                              'userType']);

                                                      Navigator.of(context)
                                                          .pop();
                                                      Components.showSnackBar(
                                                          context,
                                                          'Welcome back');
                                                      Get.off(
                                                          const AdminDashboard());
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Components.showSnackBar(
                                                          context,
                                                          'Your are not allowed to enter from this panel');
                                                    }
                                                  });
                                                }
                                              }).catchError((e) {
                                                Components.showSnackBar(
                                                    context, e);
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
                  );
          },
        ),
      ),
    );
  }
}
