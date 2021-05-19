import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/preferencias_usuario/preferencia_usuario.dart';
import 'package:food_delivery/providers/notification_provider.dart';
import 'package:provider/provider.dart';

void mostrarSnackbar(BuildContext context, String mensaje) {
  final snackbar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.check, color: Colors.white, size: 25.0),
          SizedBox(width: 10),
          Text(mensaje),
        ],
      ),
      duration: Duration(milliseconds: 800),
      backgroundColor: primaryColor.withOpacity(0.6));
  // debo referencia el scafold
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

Widget customAppBar(BuildContext context) {
  final int notifNumero = Provider.of<NotificationModel>(context).numero;
  return AppBar(
    elevation: 0,
    title: Text('Italian Pizza & Pasta',style: TextStyle(fontSize: 18) ),
    centerTitle: true,
    //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
    backgroundColor: backColor,
    actions: <Widget>[
      Stack(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart_outlined, size: 25.0),
              onPressed: () => Navigator.pushNamed(context, 'shopCart')
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: BounceInDown(
              from: 10,
              animate: (notifNumero > 0) ? true : false,
              child: Bounce(
                  from: 10,
                  controller: (controller) =>
                      Provider.of<NotificationModel>(context).bounceControler =
                          controller,
                  child: (notifNumero > 0)
                      ? Container(
                          child: Text(
                            '$notifNumero',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          alignment: Alignment.center,
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.redAccent, shape: BoxShape.circle),
                        )
                      : null),
            ),
          )
        ],
      ),
      
    ],
  );
}

bool isNumeric(String s) {

    if (s.isEmpty) return false;
    final n = num.tryParse(s);
    return (n == null) ? false : true;
}

void mostrarAlerta( BuildContext context, String mensaje) {

  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: Text('Información incorrecta') ,
        content: Text(mensaje),
        actions: <Widget> [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                      primary: primaryColor, // background
                      onPrimary: Colors.white, // foreground
            ),
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Ok'))
        ],
      );
    });
}


void exitHome( BuildContext context, String mensaje) {


  final prefs = new PreferenciasUsuario();

  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        content: Text(mensaje),
        actions: <Widget> [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                      primary: primaryColor, // background
                      onPrimary: Colors.white, // foreground
            ),
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('No')),
                      ElevatedButton(
            style: ElevatedButton.styleFrom(
                      primary: primaryColor, // background
                      onPrimary: Colors.white, // foreground
            ),
            onPressed: () => {
              prefs.ultimaPagina = 'login',
              Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false), 
            },
            child: Text('Si'))
        ],
      );
    });
}
