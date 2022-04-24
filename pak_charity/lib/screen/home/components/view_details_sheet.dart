import 'package:background_app_bar/background_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:pak_charity/constants/color.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ViewDetailSheet extends StatelessWidget {
  const ViewDetailSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            collapsedHeight: MediaQuery.of(context).size.height * 0.2,
            elevation: 0,
            backgroundColor: AppColor.secondary,
            automaticallyImplyLeading: false,
            pinned: true,
            leadingWidth: 50,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: AppColor.white,
                textColor: AppColor.fonts,
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.arrow_back,
                  size: 18,
                ),
                shape: const CircleBorder(),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.height, 75),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  dense: true,
                  isThreeLine: true,
                  title: Text(
                    'Project Title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  subtitle: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LinearPercentIndicator(
              leading: Text(
                '1000.0 PKR',
                style: TextStyle(color: AppColor.primary),
              ),
              trailing: Text(
                '250.0 PKR',
                style: TextStyle(color: AppColor.primary),
              ),
              animation: true,
              animationDuration: 1000,
              lineHeight: 20.0,
              percent: collectedPercentage / 100,
              center: Text("75%",
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
                ),
              ),
            ),
            flexibleSpace: BackgroundFlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  image: DecorationImage(
                    image: NetworkImage('https://ofhsoupkitchen.org/wp-content/uploads/2020/11/charity-begins-at-home-1024x683-850x300.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.secondary.withOpacity(0.25),
                        AppColor.primary,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text(
                'Exercises',
                style: TextStyle(
                  color: AppColor.fonts,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
