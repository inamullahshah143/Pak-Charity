import 'package:flutter/material.dart';

class DonationDetails extends StatelessWidget {
  final Map<String, dynamic> data;
  const DonationDetails({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(data['accountNumber']),
      ],
    );
  }
}
