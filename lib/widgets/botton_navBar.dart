import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import 'package:food_delivery/constants.dart';

import 'package:food_delivery/providers/navbar_selected_provider.dart';
import 'package:food_delivery/providers/notification_provider.dart';

class BottonNavBar extends StatelessWidget {
  const BottonNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

 final int notifNumero = Provider.of<NotificationModel>(context).numero;
 final navBarProvider = Provider.of<NavBarSelectedProvider>(context);
 final currentIndex = navBarProvider.selectedNavBarOpt;


 return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: primaryColor,
        primaryColor: Colors.white,
      ),
      child: BottomNavigationBar(
        onTap: ( int i) => navBarProvider.selectedNavBarOpt = i,
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 25.0),
            label: '' 
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget> [
                Icon(Icons.shopping_cart, size: 25.0),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: BounceInDown(
                    from: 10,
                    animate: ( notifNumero > 0 ) ? true : false,
                    child: Bounce(
                      from: 10,
                      controller: (controller) => Provider.of<NotificationModel>(context).bounceControler = controller,
                      child: (notifNumero > 0) 
                      ?Container(
                        child: Text('$notifNumero', style:  TextStyle(color: Colors.white, fontSize: 8),),
                        alignment: Alignment.center,
                        width: 12,
                        height: 12,
                        decoration:  BoxDecoration(
                          color: Colors.redAccent,
                          shape:  BoxShape.circle 
                        ),

                      )
                      : null
                    ),
                  ),
                )
              
              
              ],
            ),
          label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 25.0),
            label: '' 
          ),
        ]
      ) ,
    );
  }
}