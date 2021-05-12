import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';


class CustomLabel extends StatelessWidget {

  final String route;
  final String question;
  final String text;

  const CustomLabel({
    Key key, 
    @required this.route,
    @required this.question,
    @required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
            Text(this.question, style: TextStyle( color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),),
            SizedBox(height: 10),
            GestureDetector(
              child: Text(this.text, style: TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold )),
              onTap: () {
                Navigator.pushReplacementNamed(context, this.route);
              },
            )

        ],
      ),
    );
  }
}