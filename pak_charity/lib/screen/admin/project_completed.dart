import 'package:flutter/material.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/utils/recipient_helper.dart';

class ProjectCompleted extends StatelessWidget {
  const ProjectCompleted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Text(
            "Completed Projects",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.fonts),
          ),
        ),
        StreamBuilder(
          stream: RecipientHelper().getAllCompletedProjects(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : snapshot.hasData
                    ? Expanded(
                        child: snapshot.data,
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
        ),
      ],
    );
  }
}
