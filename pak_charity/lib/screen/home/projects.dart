import 'package:flutter/material.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/utils/recipient_helper.dart';

class Projects extends StatelessWidget {
  const Projects({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RecipientHelper().getFavoriteDonationRequests(context),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : snapshot.hasData
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return snapshot.data[index];
                    },
                  )
                : Center(
                    child: Text(
                      'No Record Found',
                      style: TextStyle(
                        color: AppColor.secondary,
                      ),
                    ),
                  );
      },
    );
  }
}
