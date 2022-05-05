import 'package:flutter/material.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key key,
    @required this.imageURL,
    @required this.title,
    @required this.details,
    @required this.amountNeed,
    @required this.collectedPercentage,
    @required this.viewDetails,
    @required this.donate,
    @required this.isFavorite,
  }) : super(key: key);
  final String imageURL;
  final String title;
  final String details;
  final double amountNeed;
  final double collectedPercentage;
  final Function viewDetails;
  final Function donate;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(
            imageURL,
          ),
          ListTile(
            isThreeLine: true,
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              details,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: isFavorite
                  ? Icon(
                      Icons.favorite,
                      color: AppColor.primary,
                    )
                  : Icon(
                      Icons.favorite_outline,
                      color: AppColor.primary,
                    ),
              onPressed: () {
                isFavorite != isFavorite;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: LinearPercentIndicator(
              leading: Text(
                '${amountNeed.toString()} PKR',
                style: TextStyle(color: AppColor.primary),
              ),
              trailing: Text(
                '${(amountNeed - (amountNeed * (collectedPercentage / 100))).toString()} PKR',
                style: TextStyle(color: AppColor.primary),
              ),
              animation: true,
              animationDuration: 1000,
              lineHeight: 20.0,
              percent: collectedPercentage / 100,
              center: Text(
                collectedPercentage.toString() + "%",
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white),
              ),
              barRadius: const Radius.circular(100),
              progressColor: AppColor.primary,
              backgroundColor: AppColor.secondary.withOpacity(0.5),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppColor.primary),
                  overlayColor: MaterialStateProperty.all<Color>(
                      AppColor.primary.withOpacity(0.1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: AppColor.primary),
                    ),
                  ),
                ),
                onPressed: viewDetails,
                child: const Text('View Details'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColor.primary),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppColor.white),
                  overlayColor: MaterialStateProperty.all<Color>(
                      AppColor.primary.withOpacity(0.1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: AppColor.primary),
                    ),
                  ),
                ),
                onPressed: donate,
                child: const Text('Donate'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
