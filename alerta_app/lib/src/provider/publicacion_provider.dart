
import 'dart:async';
import 'dart:convert';
import 'package:alerta_app/src/models/publicacion_model.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
class PublicacionProvider{

  final _prefs = new PreferenciasUsuario();
  int _paginacionGeneral = 0;
  int _paginacionUsuario=0;

  List<PublicacionModel> _general=new List();
  List<PublicacionModel> _usuario=new List();

  final _generalStreamController = StreamController<List<PublicacionModel>>.broadcast();
  final _usuarioStreamController = StreamController<List<PublicacionModel>>.broadcast();

  Function(List<PublicacionModel>) get generalSink => _generalStreamController.sink.add;
  Function(List<PublicacionModel>) get usuarioSink => _usuarioStreamController.sink.add;

  Stream<List<PublicacionModel>> get generalStream=>_generalStreamController.stream;
  Stream<List<PublicacionModel>> get usuarioStream=>_usuarioStreamController.stream;

  void disposeStreams(){
    _generalStreamController?.close();
    _usuarioStreamController?.close();
  }


  Future<List<PublicacionModel>> getGeneral(int cui)async{
    final resp=await http.get(
      'http://192.168.0.17:8080/get/publicacionGAU?PAGINACION='+_paginacionGeneral.toString(),
      headers: {"Content-Type": "application/json"}
    );
    final decodedData=json.decode(resp.body);
    if(decodedData['codigo']==200) return [];
    final publicaciones=new Publicaciones.fromJsonList(decodedData['data']);
    _paginacionGeneral++;
    final respuesta= await publicaciones.items;
    _general.addAll(respuesta);
    generalSink(_general);
    return respuesta;
  }




  Future<List<PublicacionModel>> getUsuario(int cui)async{
    final resp=await http.get(
      'http://192.168.0.17:8080/get/publicacionUAU?PAGINACION='+_paginacionUsuario.toString()+'&CUI='+cui.toString(),
      headers: {"Content-Type": "application/json"}
    );
    final decodedData=json.decode(resp.body);
    if(decodedData['codigo']==200) return [];
    final publicaciones=new Publicaciones.fromJsonList(decodedData['data']);
    _paginacionUsuario++;
    final respuesta=await publicaciones.items;
    _usuario.addAll(respuesta);
    usuarioSink(_usuario);
    return respuesta;
  }

  Future<Map<String,dynamic>> eliminarPublicacion(int codPublicacion)async{
    final resp=await http.delete('http://192.168.0.17:8080/delete/publicacionAU?COD_PUBLICACION='+codPublicacion.toString(),
      headers: {"Content-Type": "application/json"});
    Map<String,dynamic> decodedResp=json.decode(resp.body);
    return decodedResp;
  }




}