import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/providers/usuarios_providers.dart';
import 'package:provider/provider.dart';

class HeaderWithSearch extends StatelessWidget {
  const HeaderWithSearch({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;
    
  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).userLogeado;
    return Container(
      margin: EdgeInsets.only(bottom: defaultPadding * 2.5),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget> [
          Container(
            padding: EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
              bottom: 36 + defaultPadding
            ),
            height: size.height * 0.2 -27,
            decoration: BoxDecoration(
              color: backColor,
              borderRadius: BorderRadius.only( 
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35)
              ) 
            ),
            child: Row(
              children: <Widget> [
                (usuario.nombre == null)                
                ? Text('¡Bienvenido!', style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
                )
                : Text('¡Hola ${usuario.nombre}!', style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold)
                ),
                Spacer(),
                FadeInImage(
                  image: AssetImage('assets/logo2.png'),
                  placeholder: AssetImage('assets/logo2.png'),
                  //fadeInDuration: Duration(milliseconds: 200),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: defaultPadding),
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:  BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 50,
                    color: primaryColor.withOpacity(0.23)
                  ),
                ]
              ),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "Buscar",
                  hintStyle: TextStyle(
                    color: primaryColor.withOpacity(0.5)
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  icon: Icon(Icons.search, color: primaryColor.withOpacity(0.5))
                )
              ),
            )
          )
        ],
      ),

    );
  }
}