
import 'dart:convert';
import 'package:alerta_app/src/models/usuario_model.dart';
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
  Future<Map<String,dynamic>> editarUsuario(int cui,String password,String nombre)async{
    final authData={
      'CUI':cui,
      'PASSWORD':password,
      'NOMBRE':nombre
    };
    final resp=await http.put('http://192.168.0.17:8080/put/usuarioAU',
      body:json.encode(authData),
      headers: {"Content-Type": "application/json"});
    Map<String,dynamic> decodedResp=json.decode(resp.body);
    print(decodedResp);
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
  Future<Map<String,dynamic>> publicacion(int tipo,String nombre,String descripcion,double posicionX, double posicionY, int estado,int subtipo,String fechahora)async{
    final authData={
      'TIPO':tipo,
      'NOMBRE':nombre,
      'DESCRIPCION':descripcion,
      'POSICIONX':posicionX,
      'POSICIONY':posicionY,
      'FECHAHORA':fechahora,
      'ESTADO':estado,
      'CUI':_prefs.cui,
      'TOKEN':_prefs.token,
      'SUBTIPO':subtipo
    };
    
    final resp=await http.post(
      'http://192.168.0.17:8080/post/publicacionAU',
      body:json.encode(authData),
      headers: {"Content-Type": "application/json"}
    );
    Map<String,dynamic> decodedResp=json.decode(resp.body);
    if(decodedResp.containsKey('codigo')){
      if(decodedResp['codigo']==505){
        await iniciarSesion(_prefs.cui,_prefs.password);
        await publicacion(tipo,nombre,descripcion,posicionX,posicionY,estado,subtipo,fechahora);
      }
    }
    return decodedResp;
  }

  Future<UsuarioModel> cargarUsuario(int cui)async{
    final resp=await http.get(
      'http://192.168.0.17:8080/get/usuarioAU?CUI='+cui.toString(),
      headers: {"Content-Type": "application/json"}
    );
    Map<String,dynamic> decodedResp=json.decode(resp.body);
    if(decodedResp==null)return null;
    print(decodedResp);
    final usuarioTemp=UsuarioModel.fromJson(decodedResp);
    return usuarioTemp;
  }

      



}