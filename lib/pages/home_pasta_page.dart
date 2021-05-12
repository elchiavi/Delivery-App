import 'package:flutter/material.dart';
import 'package:food_delivery/models/producto_model.dart';
import 'package:food_delivery/providers/producto_provider.dart';
import 'package:food_delivery/widgets/custom_all_widgets.dart';

class HomePagePasta extends StatelessWidget {

  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

   return Container(
      child: Column(
        children: <Widget> [
          SectionTitle(title: 'Nuestras Pastas'),
          Container(
            child: FutureBuilder(
              future: productosProvider.getPastas(),
              builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListFoodCards(productos: snapshot.data);
                } else {
                  return Container(
                    height: 200.0,
                    child: Center(
                    child: CustomCircularProgressIndicator(),
                    ),
                  );
                }
              } ,
            ),
          ), 
        ],
      ),
    );
  }
}
