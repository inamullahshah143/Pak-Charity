import 'package:flutter/material.dart';
class ViewDetailSheet extends StatelessWidget {
  const ViewDetailSheet({Key key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
            leading:IconButton(onPressed:(){},icon:Icon(Icons.arrow_back_ios,),),
          backgroundColor: Colors.transparent,
          leadingWidth: 100,
          elevation: 0.0,
          title: const Text('Project Title'),
          centerTitle: true,
        ),
      ],
    );
  }
}
