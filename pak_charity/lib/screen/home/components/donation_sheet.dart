import 'package:flutter/material.dart';
class DonationSheet extends StatefulWidget {
  DonationSheet({Key key}) : super(key: key);

  @override
  State<DonationSheet> createState() => _DonationSheetState();
}

class _DonationSheetState extends State<DonationSheet> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: 100,
          elevation: 0.0,
            leading:IconButton(onPressed:(){},icon:Icon(Icons.arrow_back_ios,size:16),),
          title: const Text('How much wanna donate?',style:TextStyle(fontSize:14,fontWeight:FontWeight.w600),),
          centerTitle: true,
        ),
        
      ],

    );
  }
}
