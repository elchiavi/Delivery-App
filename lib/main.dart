import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/preferencias_usuario/preferencia_usuario.dart';
import 'package:food_delivery/providers/usuarios_providers.dart';
import 'package:provider/provider.dart';

import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/item_cat_model.dart';
import 'package:food_delivery/routes/routes.dart';

import 'package:food_delivery/providers/cart_counter_provider.dart';
import 'package:food_delivery/providers/navbar_selected_provider.dart';
import 'package:food_delivery/providers/notification_provider.dart';
import 'package:food_delivery/providers/ui_provider.dart';

void main() async {
  // para que bloquee la opcion horizontal (giro aut)
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ItemCat()),
      ChangeNotifierProvider(create: (_) => new UiProvider()),
      ChangeNotifierProvider(create: (_) => new UsuarioProvider()),
      ChangeNotifierProvider(create: (_) => new NavBarSelectedProvider()),
      ChangeNotifierProvider(create: (_) => new NotificationModel()),
      ChangeNotifierProvider(create: (_) => new CartCounterProvider()),
    ], child: new MyApp()));
  });
  
}

class MyApp extends StatelessWidget {

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor),
          backgroundColor: backColor),
      initialRoute: prefs.ultimaPagina,
      routes: appRoutes,
    );
  }
}
