
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/accounts_settings_page.dart';
import 'package:food_delivery/pages/confirmation_cart_page.dart';
import 'package:food_delivery/pages/detalle_product_page.dart';
import 'package:food_delivery/pages/home_page.dart';
import 'package:food_delivery/pages/login_page.dart';
import 'package:food_delivery/pages/register_page.dart';
import 'package:food_delivery/pages/shop_cart_page.dart';


final Map<String, Widget Function(BuildContext)> appRoutes = {

    'login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => RegisterPage(),
    'home': (BuildContext context) => HomePage(),
    'detalle': (BuildContext context) => DetalleProductoPage(),
    'shopCart': (BuildContext context) => ShopCartPage(),
    'confirmation': (BuildContext context) => ConfirmationPage(),
    'accountsSettings': (BuildContext context) => AccountSettingsPage(),

};
