import 'package:background_app_bar/background_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pak_charity/constants/widgets/color.dart';

class RequestDetails extends StatelessWidget {
  const RequestDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            collapsedHeight: MediaQuery.of(context).size.height * 0.075,
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
                  subtitle: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.person,
                            color: AppColor.white,
                            size: 16,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Text(
                            'Username',
                            style: TextStyle(
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ],
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
                    image: NetworkImage(
                        'https://ofhsoupkitchen.org/wp-content/uploads/2020/11/charity-begins-at-home-1024x683-850x300.png'),
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
                'Project Details',
                style: TextStyle(
                  color: AppColor.fonts,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text(
                'Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi. Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi.',
                style: TextStyle(
                  color: AppColor.fonts,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.primary),
          foregroundColor: MaterialStateProperty.all<Color>(
            AppColor.white,
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(MediaQuery.of(context).size.width * 0.4, 50),
          ),
          overlayColor:
              MaterialStateProperty.all<Color>(AppColor.white.withOpacity(0.1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: () {},
        child: RichText(
          text: const TextSpan(
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text('Donate'),
              ),
              TextSpan(text: '   '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(FontAwesome5.long_arrow_alt_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
