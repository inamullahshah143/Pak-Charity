import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/screen/auth/sign_up_screen.dart';
import 'package:pak_charity/screen/home/menu_darwer.dart';
import 'package:pak_charity/utils/helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  final isVisible = true.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          validator: (value) => Helper.validateEmail(value),
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Your email address'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(() {
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
                        },),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  AppColor.white),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  AppColor.white.withOpacity(0.1)),
                            ),
                            onPressed: () {
                              Get.off(MenuDrawer());
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
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent,),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  AppColor.primary,),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  AppColor.primary.withOpacity(0.1),),
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
                                    child: Text('Sign In with Google'),
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
      ),
    );
  }
}
