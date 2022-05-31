import 'package:flutter/material.dart';
import 'package:pak_charity/constants/components/project_card.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/utils/recipient_helper.dart';

class Projects extends StatelessWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
      stream: RecipientHelper().getDonationRequests(context),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : snapshot.hasData
                ? Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ProjectCard(
                          requestId: snapshot.data![index].requestId,
                          amountNeed: snapshot.data![index].amountNeed,
                          collectedPercentage:
                              snapshot.data![index].collectedPercentage,
                          details: snapshot.data![index].details,
                          imageURL: snapshot.data![index].imageURL,
                          title: snapshot.data![index].title,
                          donate: snapshot.data![index].donate,
                          viewDetails: snapshot.data![index].viewDetails,
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        'No Record Found',
                        style: TextStyle(
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
