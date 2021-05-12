import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';

class SectionTitle extends StatelessWidget {

  final String title;

  const SectionTitle({
    @required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 4) ,
            child: Text(this.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ,),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only( right: defaultPadding / 4),
              height: 7,
              color: primaryColor.withOpacity(0.2),
            ),
          )

        ],
      ),
    );
  }
}