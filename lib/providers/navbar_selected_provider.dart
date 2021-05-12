import 'package:flutter/material.dart';

class NavBarSelectedProvider extends ChangeNotifier{

  int _selectedNavBarOpt = 0;

  int get selectedNavBarOpt {

    return this._selectedNavBarOpt;
  }

  set selectedNavBarOpt( int i) {

    this._selectedNavBarOpt = i;
    notifyListeners();
  } 

}