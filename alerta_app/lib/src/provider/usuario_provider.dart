
import 'dart:convert';
import 'package:http/http.dart' as http;
class UsuarioProvider{
  Future nuevoUsuario(double cui,String password,String nombre,int tipo,int estado)async{
    final authData={
      'CUI':cui,
      'PASSWORD':password,
      'NOMBRE':nombre,
      'TIPO':tipo,
      'ESTADO':estado
    };
    final resp=await http.post(
      'http://127.0.0.1:8080/post/usuarioAU',
      body:json.encode(authData)
    );
    Map<String,dynamic> decodedResp=json.decode(resp.body);
    print(decodedResp);
  }

  Future iniciarSesion(double cui,String password)async{
    final authData={
      'CUI':cui,
      'PASSWORD':password
    };
    final resp=await http.post(
      'http://127.0.0.1:8080/post/iniciar_sesion',
      body:json.encode(authData)
    );
    Map<String,dynamic> decodedResp=json.decode(resp.body);
    print(decodedResp);
  }

}