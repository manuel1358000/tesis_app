
import 'dart:convert';
import 'package:http/http.dart' as http;
class UsuarioProvider{
  Future nuevoUsuario(int cui,String password,String nombre,int tipo,int estado)async{
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
    print(decodedResp);
  }

  Future iniciarSesion(int cui,String password)async{
    print('Dentro del provider '+cui.toString());
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
    print(decodedResp);
  }

}