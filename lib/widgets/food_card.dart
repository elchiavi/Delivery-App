import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/producto_model.dart';

class FoodCard extends StatelessWidget {

  final ProductoModel producto;

  const FoodCard({ @required this.producto});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          left: defaultPadding, 
          right: defaultPadding,
          top: defaultPadding / 2,
          bottom: defaultPadding * 2
        ),
        width: size.width * 0.5,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'detalle', arguments: producto);
          },
          child: Column(
            children: <Widget> [
              Hero(
                tag: producto.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                  child: FadeInImage(
                    image: NetworkImage(producto.imagen),
                    placeholder: AssetImage('assets/loading-blue.gif'),
                    fit: BoxFit.cover,
                    height: 200.0, 
                    width: 400.0,
                  )
                ),
              ),
              Container(
                padding: EdgeInsets.all(defaultPadding / 2 ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(offset: Offset(0, 10),
                    blurRadius: 20,
                    color: primaryColor.withOpacity(0.23)
                    )
                  ]
                ),
                child: Row(
                  children:<Widget> [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: "${producto.nombre}\n", style: Theme.of(context).textTheme.button,),
                          TextSpan(text: "${producto.tipo}" , style: TextStyle(color: primaryColor.withOpacity(0.5))),
                        ]

                      )
                    ),
                    Spacer(),
                    Text('\$${producto.precio}', style: Theme.of(context).textTheme.button.copyWith(color: primaryColor),)
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}