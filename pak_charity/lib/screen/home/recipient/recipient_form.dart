import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:path/path.dart' as path;

class RecipientForm extends StatefulWidget {
  const RecipientForm({Key key}) : super(key: key);

  @override
  State<RecipientForm> createState() => _RecipientFormState();
}

class _RecipientFormState extends State<RecipientForm> {
  double val = 0;

  CollectionReference imgRef;

  firebase_storage.Reference ref;

  final List<File> _image = [];

  final picker = ImagePicker();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.75),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  maxLines: 5,
                  maxLength: 1500,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.75),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.75),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: DropdownButtonFormField(
                  dropdownColor: AppColor.fonts,
                  hint: const Text("Donation Type"),
                  onChanged: (value) => {},
                  items: const [
                    DropdownMenuItem(
                      value: 'Helath',
                      child: Text('Helath'),
                    ),
                    DropdownMenuItem(
                      value: 'Humanity',
                      child: Text('Humanity'),
                    ),
                    DropdownMenuItem(
                      value: 'Food',
                      child: Text('Food'),
                    ),
                    DropdownMenuItem(
                      value: 'Education',
                      child: Text('Education'),
                    ),
                    DropdownMenuItem(
                      value: 'Religion',
                      child: Text('Religion'),
                    ),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: AppColor.secondary.withOpacity(0.75),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.75),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Estimated Delivery",
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  'Thumbnails',
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColor.fonts,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _image.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColor.secondary.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => chooseImage(),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: FileImage(_image[index - 1]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  'Account Details',
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColor.fonts,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.75),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: DropdownButtonFormField(
                  dropdownColor: AppColor.fonts,
                  hint: const Text("Account Type"),
                  onChanged: (value) => {},
                  items: const [
                    DropdownMenuItem(
                      value: 'Easypaisa',
                      child: Text('Easypaisa'),
                    ),
                    DropdownMenuItem(
                      value: 'Jazzcash',
                      child: Text('Jazzcash'),
                    ),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: AppColor.secondary.withOpacity(0.75),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.75),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Account Number",
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
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
          onPressed: () {},
          child: const Text('Submit Request'),
        ),
      ),
    );
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = (await picker.retrieveLostData()) as LostData;
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
          i++;
        });
      });
    }
  }
}
