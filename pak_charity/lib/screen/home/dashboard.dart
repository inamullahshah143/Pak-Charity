import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:pak_charity/constants/components/project_card.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/constants/widgets/consts.dart';
import 'package:pak_charity/utils/recipient_helper.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              alignment: Alignment.center,
              child: const ChipsFilter(
                selected: 0,
                filters: [
                  Filter(label: "All", index: 1),
                  Filter(label: "Helath", index: 2),
                  Filter(label: "Humanity", index: 3),
                  Filter(label: "Food", index: 4),
                  Filter(label: "Education", index: 5),
                  Filter(label: "Religion", index: 6),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List>(
                stream: RecipientHelper().getDonationRequests(context),
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
                                return ProjectCard(
                                  requestId: snapshot.data[index].requestId,
                                  amountNeed: snapshot.data[index].amountNeed,
                                  collectedPercentage:
                                      snapshot.data[index].collectedPercentage,
                                  details: snapshot.data[index].details,
                                  imageURL: snapshot.data[index].imageURL,
                                  title: snapshot.data[index].title,
                                  donate: snapshot.data[index].donate,
                                  viewDetails:
                                      snapshot.data[index].viewDetails,
                                );
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Filter {
  final String label;
  final int index;
  const Filter({this.label, this.index});
}

class ChipsFilter extends StatefulWidget {
  final List<Filter> filters;
  final int selected;
  const ChipsFilter({Key key, this.filters, this.selected}) : super(key: key);

  @override
  _ChipsFilterState createState() => _ChipsFilterState();
}

class _ChipsFilterState extends State<ChipsFilter> {
  int selectedIndex;

  @override
  void initState() {
    if (widget.selected != null &&
        widget.selected >= 0 &&
        widget.selected < widget.filters.length) {
      selectedIndex = widget.selected;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: chipBuilder,
      itemCount: widget.filters.length,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget chipBuilder(context, currentIndex) {
    Filter filter = widget.filters[currentIndex];
    bool isActive = selectedIndex == currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = currentIndex;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColor.appThemeColor : AppColor.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.25,
                blurRadius: 0.25,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Text(
            filter.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color:
                  isActive ? AppColor.white : AppColor.fonts.withOpacity(0.75),
            ),
          ),
        ),
      ),
    );
  }
}
