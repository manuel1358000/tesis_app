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
  get cui {
    return _prefs.getInt('cui') ?? 0;
  }
  set cui( int value ) {
    _prefs.setInt('cui', value);
  }
  get password {
    return _prefs.getString('password') ?? '';
  }
  set password( String value ) {
    _prefs.setString('password', value);
  }
  get tipo{
    return _prefs.getInt('tipo') ?? 0;
  }
  set tipo( int value ) {
    _prefs.setInt('tipo', value);
  }
  get nombre{
    return _prefs.getString('nombre') ?? '';
  }
  set nombre( String value ) {
    _prefs.setString('nombre', value);
  }
  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }
  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }
}
