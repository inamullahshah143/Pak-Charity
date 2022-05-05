import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class RecipientDashboard extends StatelessWidget {
  const RecipientDashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(FontAwesome5.file_invoice_dollar),
      ),
    );
  }
}
