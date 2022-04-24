import 'package:flutter/material.dart';

class FlitersSheet extends StatelessWidget {
  const FlitersSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: 100,
          elevation: 0.0,
          leading: MaterialButton(
            child: const Text('Clear'),
            onPressed: () {},
          ),
          title: const Text('Filters'),
          centerTitle: true,
        ),
      ],
    );
  }
}
