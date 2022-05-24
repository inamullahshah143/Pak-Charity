import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/constants/widgets/consts.dart';
import 'package:pak_charity/utils/recipient_helper.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            Text(
              "Welcome to Pak Charity",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontWeight: FontWeight.w500, color: AppColor.fonts),
            ),
            const Text(
              "explore over projects",
              style: TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: defaultPadding),
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.5)),
                ),
                elevation: 2,
                child: TextFormField(
                  onSaved: (value) {},
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter the project name",
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(14),
                      child: Icon(WebSymbols.search),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBar(
                labelColor: AppColor.white,
                unselectedLabelColor: AppColor.fonts,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primary,
                ),
                tabs: const [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Helath',
                  ),
                  Tab(
                    text: 'Humanity',
                  ),
                  Tab(
                    text: 'Food',
                  ),
                  Tab(
                    text: 'Education',
                  ),
                  Tab(
                    text: 'Religion',
                  )
                ],
                isScrollable: true,
              ),
            ),
            StreamBuilder(
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
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return snapshot.data[index];
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
            ),
          ],
        ),
      ),
    );
  }
}
