import 'package:flutter/material.dart';

import 'package:food_delivery/constants.dart';
import 'package:food_delivery/providers/cart_counter_provider.dart';
import 'package:provider/provider.dart';


class CartCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  int cantidad = Provider.of<CartCounterProvider>(context).cantidad;
  return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: <Widget> [

          _buildOutlineButton(icon: Icons.remove,press: () {
            if (cantidad > 1) {
              cantidad --;
              Provider.of<CartCounterProvider>(context, listen: false ).cantidad = cantidad;
            }
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Text(cantidad.toString(), style: Theme.of(context).textTheme.headline6),
          ),
          _buildOutlineButton(icon: Icons.add,press: () {
              cantidad ++;
              Provider.of<CartCounterProvider>(context, listen: false ).cantidad = cantidad;
          }),
          
        ],
      ),
    );
  }
}

Widget _buildOutlineButton({IconData icon, Function press}) { 
return SizedBox(
      width: 32,
      height: 32,
      child: OutlinedButton(
        onPressed: press,
        child: Icon(icon,),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: primaryColor,
          side: BorderSide(color: primaryColor, width: 1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40))),
        ),
    );
}