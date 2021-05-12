import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/preferencias_usuario/preferencia_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider extends ChangeNotifier {

  final String _firebaseToken = 'AIzaSyA-Hvd3veJqqYDziGYPdaft-YgEEWTSYRY';
  final _prefs = new PreferenciasUsuario();
  bool _autenticando = false;

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  Future<bool> nuevoUsuario( String email, String password) async {

    this.autenticando = true;

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body);
    this.autenticando = false;
    if (decodedResp.containsKey('idToken')) {
      // guardar token en dispositivo
      _prefs.token = decodedResp['idToken'];
      return true;
    }else {
      return false;
    }

  }

  Future<bool> login( String email, String password) async {

    this.autenticando = true;
    
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken'),
      body: json.encode(authData)
    );
    print(resp.body);

    Map<String, dynamic> decodedResp = json.decode( resp.body);
    this.autenticando = false;

    if (decodedResp.containsKey('idToken')) {
      
      _prefs.token = decodedResp['idToken'];
      return true;
    }else {

      return false;
    }
    

  }



}