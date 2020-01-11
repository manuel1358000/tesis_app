
import 'dart:convert';
import 'package:alerta_app/src/models/publicacion_model.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
class PublicacionProvider{

  final _prefs = new PreferenciasUsuario();

  Future<List<PublicacionModel>> getGeneral()async{
    final resp=await http.get(
      'http://192.168.0.17:8080/get/publicacionGAU?PAGINACION=1',
      headers: {"Content-Type": "application/json"}
    );
    final decodedData=json.decode(resp.body);
    if(decodedData['codigo']==200) return [];
    final publicaciones=new Publicaciones.fromJsonList(decodedData['data']);
    return publicaciones.items;
  }
}