import 'package:flutter/material.dart';


class NotificationModel extends ChangeNotifier {

  int _numero = 0;
  bool _guardando = false;
  AnimationController _bounceControler;

  int get numero => this._numero;
  bool get guardando => this._guardando;

  set numero (int valor)  {
    this._numero = valor;
    notifyListeners();
  }

  set guardando (bool valor) {
    this._guardando = valor;
    notifyListeners();
  }

  AnimationController get bounceControler => this._bounceControler;
  set bounceControler (AnimationController controller) {
    this._bounceControler = controller;
  }

}