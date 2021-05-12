import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';

class CustomCircularProgressIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: primaryColor,
      valueColor: new AlwaysStoppedAnimation<Color>(secondaryColor),
    );
  }
}