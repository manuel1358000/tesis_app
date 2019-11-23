
import 'dart:convert';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:http/http.dart' as http;
class UsuarioProvider{

  final _prefs = new PreferenciasUsuario();

  Future<Map<String,dynamic>> nuevoUsuario(int cui,String password,String nombre,int tipo,int estado)async{
    final authData={
      'CUI':cui,
      'PASSWORD':password,
      'NOMBRE':nombre,
      'TIPO':tipo,
      'ESTADO':estado
    };
    final resp=await http.post(
      'http://192.168.0.17:8080/post/usuarioAU',
      body:json.encode(authData),
      headers: {"Content-Type": "application/json"}
    );
    Map<String,dynamic> decodedResp=json.decode(resp.body);
    return decodedResp;
  }

  Future<Map<String,dynamic>> iniciarSesion(int cui,String password)async{
    final authData={
      'CUI':cui,
      'PASSWORD':password
    };
    final resp=await http.post(
      'http://192.168.0.17:8080/post/iniciar_sesion',
      body:json.encode(authData),
      headers: {"Content-Type": "application/json"}
    );
    Map<String,dynamic> decodedResp=json.decode(resp.body);
    if(decodedResp.containsKey('token')){
      _prefs.token=decodedResp['token'];
      _prefs.cui=cui;
      _prefs.password=password;
      _prefs.tipo=decodedResp['tipo'];
      _prefs.nombre=decodedResp['nombre'];
    }
    return decodedResp;
  }
}