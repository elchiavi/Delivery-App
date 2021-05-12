import 'package:flutter/material.dart';
import 'package:food_delivery/models/producto_model.dart';
import 'package:food_delivery/widgets/custom_all_widgets.dart';

class ListFoodCards extends StatelessWidget {

  final List<ProductoModel> productos;

  const ListFoodCards({this.productos});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.40,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false, // "suelta las imagenes para que no queden como pegadas/imantadas"
        itemCount: productos.length,
        itemBuilder: (context, i) {
            return FoodCard(producto: productos[i]);
        },
      ),

    );
  }

    
}