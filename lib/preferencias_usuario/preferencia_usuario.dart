
  import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

    static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

    factory PreferenciasUsuario() {
      return _instancia;
    }

    PreferenciasUsuario._internal();

    SharedPreferences _prefs;

    initPrefs() async {
      this._prefs = await SharedPreferences.getInstance();
    }

    // GET y SET del nombre
    get token {
      return _prefs.getString('token') ?? '';
    }

    set token( String value ) {
      _prefs.setString('token', value);
    }

        // GET y SET de la última página
    get ultimaPagina {
      return _prefs.getString('ultimaPagina') ?? 'login';
    }

    set ultimaPagina( String value ) {
      _prefs.setString('ultimaPagina', value);
    }

    get nombre {
      return _prefs.getString('nombre');
    }

    set nombre( String value ) {
      _prefs.setString('nombre', value);
    }

    get apellido {
      return _prefs.getString('apellido');
    }

    set apellido( String value ) {
      _prefs.setString('apellido', value);
    }

    get direccion {
      return _prefs.getString('direccion');
    }

    set direccion( String value ) {
      _prefs.setString('direccion', value);
    }

    get telefono {
      return _prefs.getString('telefono');
    }

    set telefono( String value ) {
      _prefs.setString('telefono', value);
    }

    get email {
      return _prefs.getString('email');
    }

    set email( String value ) {
      _prefs.setString('email', value);
    }

  }