import 'package:flutter/material.dart';

import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/producto_model.dart';
import 'package:food_delivery/utils/utils.dart';
import 'package:food_delivery/widgets/custom_all_widgets.dart';

class DetalleProductoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductoModel producto = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: customAppBar(context),
      drawer: Menu(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _imageFood(producto, size),
            _titlePriceFood(producto, context),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text('${producto.descripcion}')),
            SizedBox(height: size.height * 0.05),
            CartCounter(),
            SizedBox(height: size.height * 0.05),
            ShopButtonCart(producto)
          ],
        ),
      ),
      //bottomNavigationBar: BottonNavBar(),
    );
  }

  Container _titlePriceFood(ProductoModel producto, BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${producto.nombre}',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                    Text('${producto.tipo}',
                        style: TextStyle(
                            color: primaryColor.withOpacity(0.5),
                            fontSize: 20)),
                  ]),
            ),
            ClipPath(
              clipper: PricerCliper(),
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(vertical: 15),
                height: 66,
                width: 60,
                color: primaryColor,
                child: Text(
                  '\$ ${producto.precio}',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ));
  }

  Widget _imageFood(ProductoModel producto, Size size) {
    return Column(
      children: [
        Hero(
          tag: producto.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                image: NetworkImage(producto.imagen),
                placeholder: AssetImage('assets/loading-blue.gif'),
                fit: BoxFit.cover,
                height: size.height * 0.30,
                width: double.infinity),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      color: primaryColor.withOpacity(0.34))
                ]))
      ],
    );
  }
}


class PricerCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
