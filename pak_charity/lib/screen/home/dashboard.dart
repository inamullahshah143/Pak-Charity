import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:pak_charity/constants/widgets/color.dart';
import 'package:pak_charity/constants/widgets/consts.dart';
import 'package:pak_charity/utils/recipient_helper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _value = 0;
  String search = '';
  List<String> filters = [
    'All',
    'Health',
    'Humanity',
    'Food',
    'Education',
    'Religion',
  ];

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
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
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
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChoiceChip(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.transparent,
                    selectedColor: AppColor.appThemeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(
                      color: _value == index ? AppColor.white : AppColor.fonts,
                    ),
                    label: Text(filters[index].toString()),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                      });
                    },
                  );
                },
              ),
            ),
            StreamBuilder(
              stream: RecipientHelper().getDonationRequests(context, _value,search),
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
