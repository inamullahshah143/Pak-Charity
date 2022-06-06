import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/main.dart';
import 'package:pak_charity/screen/admin/request_details.dart';
import 'package:pak_charity/utils/recipient_helper.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    Key key,
    @required this.requestId,
    @required this.imageURL,
    @required this.title,
    @required this.details,
    @required this.amountNeed,
    @required this.collectedPercentage,
    @required this.viewDetails,
    @required this.donate,
  }) : super(key: key);
  final String requestId;
  final String imageURL;
  final String title;
  final String details;
  final double amountNeed;
  final double collectedPercentage;
  final Function viewDetails;
  final Function donate;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  List<String> favoriteList = prefs.getStringList('favorites') ?? [];
  final isFavorite = false.obs;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                widget.imageURL,
                height: 150,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Obx(() {
                return Card(
                  shape: const CircleBorder(),
                  color: AppColor.white,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      isFavorite.value = !isFavorite.value;
                      if (isFavorite.value == true) {
                        favoriteList.add(widget.requestId);
                        prefs.setStringList('requestId', favoriteList);
                      } else {
                        favoriteList.remove(widget.requestId);
                        prefs.setStringList('requestId', favoriteList);
                      }
                    },
                    color: AppColor.primary,
                    icon: Icon(
                      isFavorite.value
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      size: 18,
                    ),
                  ),
                );
              }),
            ],
          ),
          ListTile(
            isThreeLine: true,
            title: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              widget.details,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: LinearPercentIndicator(
              leading: Text(
                '${widget.amountNeed.toString()} PKR',
                style: TextStyle(color: AppColor.primary),
              ),
              trailing: Text(
                '${(widget.amountNeed - (widget.amountNeed * (widget.collectedPercentage / 100))).toString()} PKR',
                style: TextStyle(color: AppColor.primary),
              ),
              animation: true,
              animationDuration: 1000,
              lineHeight: 20.0,
              percent: widget.collectedPercentage / 100,
              center: Text(
                widget.collectedPercentage.toStringAsFixed(1) + "%",
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fonts),
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
                onPressed: widget.viewDetails,
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
                onPressed: widget.donate,
                child: const Text('Donate'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RecipientProjectCard extends StatelessWidget {
  const RecipientProjectCard({
    Key key,
    @required this.status,
    @required this.imageURL,
    @required this.title,
    @required this.details,
    @required this.amountNeed,
    @required this.collectedPercentage,
  }) : super(key: key);
  final String status;
  final String imageURL;
  final String title;
  final String details;
  final double amountNeed;
  final double collectedPercentage;

  @override
  Widget build(BuildContext context) {
    return status != '1'
        ? Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.network(
                  imageURL,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    status == '0'
                        ? 'Request is pending for admin approvel'
                        : 'Your request has been decline by the admin',
                    style: TextStyle(
                      color: AppColor.red,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.network(
                  imageURL,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
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
                      collectedPercentage.toStringAsFixed(1) + "%",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: AppColor.fonts,
                      ),
                    ),
                    barRadius: const Radius.circular(100),
                    progressColor: AppColor.primary,
                    backgroundColor: AppColor.secondary.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          );
  }
}

class RequestApprovelCard extends StatefulWidget {
  final String requestId;
  final String recipientName;
  final String phoneNo;
  final String email;
  final Map<String, dynamic> data;
  final Map<String, dynamic> recipientDetails;

  const RequestApprovelCard({
    Key key,
    @required this.requestId,
    @required this.recipientName,
    @required this.phoneNo,
    @required this.email,
    @required this.data,
    @required this.recipientDetails,
  }) : super(key: key);

  @override
  State<RequestApprovelCard> createState() => _RequestApprovelCardState();
}

class _RequestApprovelCardState extends State<RequestApprovelCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Get.to(RequestDetails(
            requestId: widget.requestId,
            data: widget.data,
            recipientDetails: widget.recipientDetails,
          ));
        },
        trailing: PopupMenuButton(
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 0,
              child: Text('Accept'),
            ),
            PopupMenuItem(
              value: 1,
              child: Text('Decline'),
            ),
          ],
          onSelected: (index) {
            if (index == 0) {
              RecipientHelper()
                  .requestAction(context, widget.requestId, '1')
                  .whenComplete(() {
                setState(() {});
              });
            } else {
              RecipientHelper()
                  .requestAction(context, widget.requestId, '2')
                  .whenComplete(() {
                setState(() {});
              });
            }
          },
        ),
        isThreeLine: true,
        title: Text(widget.recipientName.toString()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      Icons.phone,
                      color: AppColor.primary,
                      size: 16,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text(widget.phoneNo.toString()),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      Icons.mail,
                      color: AppColor.primary,
                      size: 16,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text(widget.email.toString()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
