import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/preferencias_usuario/preferencia_usuario.dart';

class Menu extends StatelessWidget {

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [
          DrawerHeader(
            child: Container(
              child: FadeInImage(
                  image: AssetImage('assets/logo2.png'),
                  placeholder: AssetImage('assets/logo2.png'),
                  //fadeInDuration: Duration(milliseconds: 200),
                ),
            ),
            decoration: BoxDecoration(
              color: primaryColor 
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: primaryColor),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: primaryColor),
            title: Text('Mi Cuenta'),
            onTap: () {
              Navigator.pushNamed(context, 'accountsSettings');
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag, color: primaryColor),
            title: Text('Mis Pedidos'),
            onTap: () {
              //Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
            },
          ),
          Divider(
            color: primaryColor,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: primaryColor),
            title: Text('Cerrar Sesión'),
            onTap: () {
              prefs.ultimaPagina = 'login';
              Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
            },
          )
        ],
      ),
      
    );
  }
}