import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/models/usuario_model.dart';
import 'package:food_delivery/preferencias_usuario/preferencia_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider extends ChangeNotifier {

  final String _url = 'https://food-delivery-7ca58-default-rtdb.firebaseio.com/usuarios';
  final String _firebaseToken = 'AIzaSyA-Hvd3veJqqYDziGYPdaft-YgEEWTSYRY';
  final _prefs = new PreferenciasUsuario();
  bool _autenticando = false;

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }


  Future<bool> crearUsuario(UsuarioModel usuario) async {

    final url = '$_url.json';
    final resp = await http.post(Uri.parse(url), body: usuarioModelToJson(usuario));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> editarUsuario( UsuarioModel usuario) async {

    final url = '$_url/${usuario.id}.json';
    final resp = await http.put(Uri.parse(url), body: usuarioModelToJson(usuario));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;

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
      // crear usuario para poder disponer de sus Datos
      UsuarioModel newUser = new UsuarioModel();
      newUser.email = email;
      crearUsuario(newUser);
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

    Map<String, dynamic> decodedResp = json.decode( resp.body);
    this.autenticando = false;

    if (decodedResp.containsKey('idToken')) {
      
      _prefs.token = decodedResp['idToken'];
      List<UsuarioModel> usuarios = await getUsuarios();
      usuarios.forEach((user) {
          if (user.email == email) {
            _prefs.nombre = user.nombre;
            _prefs.apellido = user.apellido;
            _prefs.direccion = user.direccion;
            _prefs.telefono = user.telefono;
            _prefs.email = user.email;
          }
      });
      return true;
    }else {

      return false;
    }    

  }

  Future<List<UsuarioModel>> getUsuarios() async {

    final url = '$_url.json';
    final resp = await http.get(Uri.parse(url));


    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<UsuarioModel> usuarios = [];
    if (decodedData == null) return [];

    decodedData.forEach((id, user) {

      final userTemp = UsuarioModel.fromJson(user);
      userTemp.id = id;
      usuarios.add(userTemp);

    });

    return usuarios;

  }

}