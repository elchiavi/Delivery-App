import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/cart_producto_model.dart';
import 'package:food_delivery/models/pedido_model.dart';
import 'package:food_delivery/providers/cart_counter_provider.dart';
import 'package:food_delivery/providers/notification_provider.dart';
import 'package:food_delivery/widgets/custom_all_widgets.dart';
import 'package:provider/provider.dart';

class ShopCartPage extends StatefulWidget {
  @override
  _ShopCartPageState createState() => _ShopCartPageState();
}

class _ShopCartPageState extends State<ShopCartPage> {
  
  int costoDelivery = 0;
  bool _delivery;

  @override
  Widget build(BuildContext context) {
    List<CartProductoModel> lista = Provider.of<CartCounterProvider>(context).listaProductos;
    CartCounterProvider cartCounterProv = Provider.of<CartCounterProvider>(context);
    _delivery = Provider.of<CartCounterProvider>(context).delivery;
    Size size = MediaQuery.of(context).size;
    if (_delivery) {
      costoDelivery = 75;
    }
    double total = 0;
    if (lista.isNotEmpty) {
      lista.forEach((element) => total = total + element.total );
    }
    return Scaffold(
      appBar: _customAppBar(),
      drawer: Menu(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: (lista.isEmpty)
            ? Center(
                child: Text('Carrito vacio', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black87, fontWeight: FontWeight.bold))
              )
            : Column(
                children: [
                  Text('Detalle del Pedido',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Container(
                    height: size.height * 0.5,
                    child: Scrollbar(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Column(
                              children: lista
                                  .map((element) => _crearListado(element))
                                  .toList()
                              //children: lista.map((element) => ListProductCart(element: element)).toList()
                              ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SwitchListTile(
                    activeColor: primaryColor,
                    title: Text('Delivery', style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(color: primaryColor)),
                    value: _delivery, 
                    onChanged: (value) { 
                      setState(() {
                      _delivery = value;

                      if (_delivery )
                        costoDelivery = 75;
                      else {
                        costoDelivery = 0;                  
                      }
                      Provider.of<CartCounterProvider>(context, listen: false).delivery = value;
                      });
                    }
                  ),
                  SizedBox(height: 10),
                  DetailCart(delivery: _delivery, total: total, costoDelivery: costoDelivery)
                ],
              ),
      ),
      //bottomNavigationBar: BottonNavBar(),
      floatingActionButton: (lista.isNotEmpty)
          ? FloatingActionButton.extended(
              label: Text('Continuar',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              backgroundColor: primaryColor,
              onPressed: () {

                    PedidoModel pedido = new PedidoModel();
                    pedido.delivery = cartCounterProv.delivery;
                    pedido.estado = cartCounterProv.estadoPedido;
                    pedido.total = total + costoDelivery;
                    pedido.productos = cartCounterProv.listaProductos;
                    Navigator.pushNamed(context, 'confirmation', arguments: pedido);
              } 
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  Widget _crearListado(CartProductoModel element) {
    return Row(children: [
      Container(
        padding: EdgeInsets.only(bottom: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage(
            image: NetworkImage(element.producto.imagen),
            placeholder: AssetImage('assets/loading-blue.gif'),
            height: 60,
            width: 80.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
      //Spacer(),
      Expanded(
          child: Text('${element.producto.nombre}',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: primaryColor),
              textAlign: TextAlign.center)
      ),
      _buildOutlineButton(icon: Icons.remove, press: () {
        setState(() {
          if(element.cantidad > 1) {
            element.cantidad --;
            element.total = element.total - element.producto.precio;
            int numero = Provider.of<NotificationModel>(context, listen: false).numero;
            numero --;
            Provider.of<NotificationModel>(context, listen: false).numero = numero ;
          }
        });
      }),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('${element.cantidad}',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: primaryColor),
            textAlign: TextAlign.center),
      ),
      _buildOutlineButton(icon: Icons.add, press: () {
        setState(() {
          element.cantidad ++;
          element.total = element.total + element.producto.precio;
          int numero = Provider.of<NotificationModel>(context, listen: false).numero;
          numero ++;
          Provider.of<NotificationModel>(context, listen: false).numero = numero;
        });
      }),
      Expanded(
          child: Text('\$${element.total.toInt()}',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: primaryColor),
              textAlign: TextAlign.center)
      ),
      GestureDetector(
          onTap: () {
            _confirmarEliminado(context,element);

          },
          child: Icon(Icons.delete_outline, color: primaryColor)),
    ]);
  }


  _confirmarEliminado(BuildContext context, CartProductoModel element) {
    
    showDialog(
      context:context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Eliminar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              Text('¿Realmente desea eliminar este producto?'),
          
            ],
          ),
          actions: <Widget> [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                onPrimary: Colors.white
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar')
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                onPrimary: Colors.white
              ),
              onPressed: () {
                setState(() {
                    int numero = Provider.of<NotificationModel>(context, listen: false).numero;
                    Provider.of<NotificationModel>(context, listen: false).numero = numero - element.cantidad;
                    Provider.of<CartCounterProvider>(context, listen: false).eliminarProducto(element);
                    Navigator.pop(context);
                });
              }, 
              child: Text('Confirmar')
            )
          ],
        );
      }
    );
  }
}

class DetailCart extends StatelessWidget {
  const DetailCart({
    Key key,
    @required bool delivery,
    @required this.total,
    @required this.costoDelivery,
  }) : _delivery = delivery, super(key: key);

  final bool _delivery;
  final double total;
  final int costoDelivery;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget> [
          (_delivery)
          ? Column(
            children: [
              Row(children: [
                Text('SubTotal', style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: primaryColor)
                ),
                Spacer(),
                Text('\$${total.toInt()}', style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: primaryColor)
                )
              ],),
              Row(children: [
                Text('Delivery', style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: primaryColor)
                ),
                Spacer(),
                Text('\$$costoDelivery', style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: primaryColor)
                )
              ],)
            ],
            
          )
          : Container(),
          Divider(height: 5, thickness: 2,),
          Row(
            children: [
            Text('Total', style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: primaryColor)
            ),
            Spacer(),
            Text('\$${total.toInt() + costoDelivery}', style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: primaryColor)
            )
          ],),

        ],
      ),
      height:100,
    );
  }
}

Widget _buildOutlineButton({IconData icon, Function press}) { 
return SizedBox(
      width: 22,
      height: 22,
      child: OutlinedButton(
        onPressed: press ,
        child: Icon(icon, size: 14),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: primaryColor,
          side: BorderSide(color: primaryColor, width: 1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40))),
        ),
    );
}

Widget _customAppBar() {
  return AppBar(
    elevation: 0,
    title: Text('Italian Pizza & Pasta',style: TextStyle(fontSize: 18) ),
    centerTitle: true,
    //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
    backgroundColor: backColor,
    
  );
}