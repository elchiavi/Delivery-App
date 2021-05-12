import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/widgets/custom_all_widgets.dart';

class ListItemCategory extends StatelessWidget {
  const ListItemCategory({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: defaultPadding  ),
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          ItemCategory(title: 'Hamburguesas'),
          ItemCategory(title: 'Milanesas'),
          ItemCategory(title: 'Pastas'),
          ItemCategory(title: 'Pizzas'),
          ItemCategory(title: 'Postres')
        ],
      ),
    );
  }
}