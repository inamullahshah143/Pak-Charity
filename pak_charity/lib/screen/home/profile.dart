import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pak_charity/main.dart';

import '../../constants/widgets/color.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const ClipOval(
                  child: SizedBox(
                      height: 80, width: 80, child: Icon(Icons.person)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesome5.edit,
                      color: AppColor.appThemeColor,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Edit Profile",
                      style: TextStyle(color: AppColor.appThemeColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hi there ${prefs.getString('Username')}!",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.fonts),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(left: 40),
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: AppColor.secondary.withOpacity(0.25),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Name",
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                    ),
                    initialValue: prefs.getString('Username'),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(left: 40),
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: AppColor.secondary.withOpacity(0.25),
                  ),
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Email",
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                    ),
                    initialValue: prefs.getString('Email'),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(left: 40),
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: AppColor.secondary.withOpacity(0.25),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Mobile No",
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                    ),
                    initialValue: prefs.getString('PhoneNo'),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(left: 40),
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: AppColor.secondary.withOpacity(0.25),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Address",
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                    ),
                    initialValue: prefs.getString('Address'),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(left: 40),
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: AppColor.secondary.withOpacity(0.25),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '••••••••',
                      labelText: "New Password",
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(left: 40),
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: AppColor.secondary.withOpacity(0.25),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '••••••••',
                      labelText: "Confirm Password",
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.primary),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(AppColor.white),
                      overlayColor: MaterialStateProperty.all<Color>(
                          AppColor.primary.withOpacity(0.1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: AppColor.primary),
                        ),
                      ),
                    ),
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomFormImput extends StatelessWidget {
  const CustomFormImput({
    Key key,
    String label,
    String value,
    bool isPassword = false,
  })  : _label = label,
        _value = value,
        _isPassword = isPassword,
        super(key: key);

  final String _label;
  final String _value;
  final bool _isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: AppColor.secondary.withOpacity(0.25),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: _label,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
        ),
        obscureText: _isPassword,
        initialValue: _value,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
