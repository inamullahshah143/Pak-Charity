import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pak_charity/constants/components/components.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/utils/recipient_helper.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class RecipientForm extends StatefulWidget {
  const RecipientForm({Key key}) : super(key: key);

  @override
  State<RecipientForm> createState() => _RecipientFormState();
}

class _RecipientFormState extends State<RecipientForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  final formKey = GlobalKey<FormState>();
  final formData = <String, dynamic>{}.obs;
  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK', dialCode: '0');
  final TextEditingController phoneNo = TextEditingController();
  final isValidNo = true.obs;

  File thumbnail;
  @override
  void initState() {
    super.initState();
    formData['estimatedDelivery'] =
        DateFormat('dd-mm-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 1,
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
          'Donation Request',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter project title';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      formData['projectTitle'] = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.pagesColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Donation Title",
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: TextFormField(
                    maxLines: 5,
                    maxLength: 1500,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter project description';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      formData['projectDescription'] = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.pagesColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Description",
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter amount you need';
                      } else if (double.parse(value) > 100000) {
                        return 'Amount must be in between 1 lac';
                      }
                      return null;
                    },
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      formData['amountNeeded'] = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      helperText: 'Amount must be less than 1 lac',
                      counter: const SizedBox(),
                      fillColor: AppColor.pagesColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Amount Needed",
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: DropdownButtonFormField(
                    focusColor: AppColor.fonts,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please select donation type';
                      }
                      return null;
                    },
                    dropdownColor: AppColor.white,
                    hint: const Text("Donation Type"),
                    onChanged: (value) {
                      formData['donationType'] = value;
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'Helath',
                        child: Text(
                          'Helath',
                          style: TextStyle(color: AppColor.fonts),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Humanity',
                        child: Text(
                          'Humanity',
                          style: TextStyle(color: AppColor.fonts),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Food',
                        child: Text(
                          'Food',
                          style: TextStyle(color: AppColor.fonts),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Education',
                        child: Text(
                          'Education',
                          style: TextStyle(color: AppColor.fonts),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Religion',
                        child: Text(
                          'Religion',
                          style: TextStyle(color: AppColor.fonts),
                        ),
                      ),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: AppColor.pagesColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Obx(() {
                    return TextFormField(
                      controller: TextEditingController(
                          text: formData['estimatedDelivery'].toString()),
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        ).then((value) {
                          formData['estimatedDelivery'] =
                              DateFormat('dd-MM-yyyy').format(value);
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please set estimated delivery';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        formData['estimatedDelivery'] = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.pagesColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Estimated Delivery",
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Text(
                    'Thumbnails',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.fonts,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      pickThumbnail();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      decoration: BoxDecoration(
                        color: AppColor.pagesColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Feature Image',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColor.fonts,
                            ),
                          ),
                          thumbnail == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 35,
                                    color: AppColor.fonts.withOpacity(0.5),
                                  ),
                                )
                              : Container(
                                  height: 150,
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColor.pagesColor,
                                    image: DecorationImage(
                                      image: Image.file(thumbnail).image,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Text(
                    'Account Details',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.fonts,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter account title';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      formData['accountTitle'] = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.pagesColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Account Title",
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: DropdownButtonFormField(
                    dropdownColor: AppColor.white,
                    hint: const Text("Account Type"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please select account type';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      formData['accountType'] = value;
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'Easypaisa',
                        child: Text(
                          'Easypaisa',
                          style: TextStyle(color: AppColor.fonts),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Jazzcash',
                        child: Text(
                          'Jazzcash',
                          style: TextStyle(color: AppColor.fonts),
                        ),
                      ),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: AppColor.pagesColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      formData['accountNumber'] = number.toString();
                    },
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
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: phoneNo,
                    formatInput: false,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputDecoration: InputDecoration(
                      hintText: 'Account No.',
                      filled: true,
                      isDense: true,
                      fillColor: AppColor.pagesColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 45),
            ),
            foregroundColor: MaterialStateProperty.all(
              AppColor.white,
            ),
          ),
          onPressed: () async {
            Components.showAlertDialog(context);
            formData['recipientId'] = user.uid;
            formData['donationRecived'] = '0';
            formData['status'] = '0';
            formData['fcm_token'] = token;
            if (thumbnail != null) {
              if (formKey.currentState.validate()) {
                await RecipientHelper()
                    .uploadThumbnail(thumbnail)
                    .then((value) {
                  formData['image'] = value;
                }).whenComplete(() async {
                  await FirebaseFirestore.instance
                      .collection('donation_requests')
                      .add(formData)
                      .whenComplete(
                    () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Components.showSnackBar(
                          context, 'Your request posted successfully');
                    },
                  ).catchError((e) {
                    Navigator.of(context).pop();
                    Components.showSnackBar(context, e.toString());
                  });
                });
              } else {
                Navigator.of(context).pop();
              }
            } else {
              Navigator.of(context).pop();
              Components.showSnackBar(context, 'Please upload picture');
            }
          },
          child: const Text('Submit Request'),
        ),
      ),
    );
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );
    return result;
  }

  Future pickThumbnail() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    final pickedFile = File(result.files.single.path);
    if (pickedFile == null) {
      Navigator.of(context).pop();
      return;
    } else {
      thumbnail = await compressImage(pickedFile.path, 35);
      setState(() {});
    }
  }
}
