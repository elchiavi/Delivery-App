import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/item_cat_model.dart';
import 'package:food_delivery/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class ItemCategory extends StatelessWidget {

  final String title; 

  const ItemCategory({
    this.title, 
 
  });

  @override
  Widget build(BuildContext context) {

    final itemCatModel = Provider.of<ItemCat>(context);
    final uiProvider = Provider.of<UiProvider>(context);


    return GestureDetector(
      onTap: () {
        final itemCatModel = Provider.of<ItemCat>(context,listen: false);
        itemCatModel.title = this.title;

        switch(this.title) {

          case "Hamburguesas":
            return uiProvider.selectedMenuOpt = 0;

          case "Pastas":
            return uiProvider.selectedMenuOpt = 1;

          case "Pizzas":
            return uiProvider.selectedMenuOpt = 2;

          case "Milanesas":
            return uiProvider.selectedMenuOpt = 3;

          case "Postres":
            return uiProvider.selectedMenuOpt = 4;

        }
        
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget> [
            Text(this.title, 
              style: (this.title == itemCatModel.title)   
              ? TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold
                )
              : TextStyle(fontSize: 12)
            ),
            if (this.title == itemCatModel.title)
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 3,
                width: 20,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
              )
          ],
        ),
      ),
    );
  }
}
