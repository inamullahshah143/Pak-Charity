import 'package:flutter/material.dart';

import '../../constants/components/project_card.dart';

class Projects extends StatelessWidget {
  const Projects({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProjectCard(
          amountNeed: 1000.0,
          collectedPercentage: 75,
          details:
              'Lorem ipsum dolor sit amet. Et tenetur quod eos delectus numquam qui amet iste. Et aliquid minima et delectus perferendis sit quaerat similique id adipisci. Ab inventore culpa a ullam aliquam 33 velit tempora quo obcaecati pariatur est sunt nisi.',
          donate: () {},
          imageURL:
              'https://ofhsoupkitchen.org/wp-content/uploads/2020/11/charity-begins-at-home-1024x683-850x300.png',
          title: 'Any Title',
          viewDetails: () {},
        ),
      ],
    );
  }
}
