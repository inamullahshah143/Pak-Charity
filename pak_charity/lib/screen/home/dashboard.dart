import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:get/get.dart';
import 'package:pak_charity/constants/color.dart';
import 'package:pak_charity/constants/consts.dart';
import '../../constants/components/project_card.dart';
import 'components/filters_sheet.dart';
import 'components/donation_sheet.dart';
import 'components/view_details_sheet.dart';

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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter the project name",
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Icon(WebSymbols.search),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColor.primary,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              isDismissible: false,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) => Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                ),
                                child: const FlitersSheet(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.tune,
                            size: 18,
                            color: AppColor.white,
                          ),
                        ),
                      ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProjectCard(
                      amountNeed: 1000.0,
                      collectedPercentage: 75,
                      details:
                          'Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi.',
                      donate: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: false,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) => Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                              ),
                            ),
                            child: const DonationSheet(),
                          ),
                        );
                      },
                      imageURL:
                          'https://ofhsoupkitchen.org/wp-content/uploads/2020/11/charity-begins-at-home-1024x683-850x300.png',
                      title: 'Any Title',
                      viewDetails: () {
                        Get.to(const ViewDetailSheet());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
