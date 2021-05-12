import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {

  final String title;

  const CustomIcon({
    Key key, 
    @required this.title
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: 200,
          margin: EdgeInsets.only(top: 40),
          child: SafeArea(
            child: Column(
              children: <Widget> [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(image: AssetImage('assets/logo2.png'))
                ),
              ],),
          ),

        ),
    );
  }
}