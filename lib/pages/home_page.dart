import 'package:flutter/material.dart';
import 'package:food_delivery/preferencias_usuario/preferencia_usuario.dart';
import 'package:food_delivery/utils/utils.dart';
import 'package:provider/provider.dart';

import 'package:food_delivery/pages/home_mila_page.dart';
import 'package:food_delivery/pages/home_pizza_page.dart';
import 'package:food_delivery/pages/home_postre_page.dart';
import 'package:food_delivery/pages/home_burger_page.dart';
import 'package:food_delivery/pages/home_pasta_page.dart';

import 'package:food_delivery/widgets/custom_all_widgets.dart';

import 'package:food_delivery/providers/ui_provider.dart';

final prefs = new PreferenciasUsuario();

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    prefs.ultimaPagina = 'home';

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
            exitHome(context, '¿Realmente desea salir de la aplicación?');
            return true;
        },
        child: Scaffold(
          appBar: customAppBar(context),
          drawer: Menu(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                HeaderWithSearch(size: size),
                ListItemCategory(),
                _HomeBodyPage(),
              ],
            ),
          ),
        ),
    );
    
  }
}

class _HomeBodyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return HomePageBurger();

      case 1:
        return HomePagePasta();

      case 2:
        return HomePagePizza();

      case 3:
        return HomePageMila();

      case 4:
        return HomePagePostre();

      default:
        return HomePageBurger();
    }
  }
}
