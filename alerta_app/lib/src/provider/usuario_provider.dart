import 'dart:convert';
import 'dart:io';
import 'package:alerta_app/src/models/usuario_model.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class UsuarioProvider {
  final _prefs = new PreferenciasUsuario();
  //final _url='192.168.0.17';
  final _url = '148.72.23.200';

  Future<String> subirImagen(File avatar) async {
    final url = Uri.parse('http://' + _url + ':3002/post/imagenAU');
    final mimeType = mime(avatar.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('AVATAR', avatar.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp['codigo'] != 200) {
      print('Algo salio mal');
      return null;
    }
    return decodedResp['url'];
  }

  Future<Map<String, dynamic>> nuevoUsuario(int cui, String password,
      String nombre, int tipo, int estado, String imagen) async {
    final authData = {
      'CUI': cui,
      'PASSWORD': password,
      'NOMBRE': nombre,
      'TIPO': tipo,
      'ESTADO': estado,
      'IMAGEN': imagen
    };
    final resp = await http.post('http://' + _url + ':3002/post/usuarioAU',
        body: json.encode(authData),
        headers: {"Content-Type": "application/json"});
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    return decodedResp;
  }

  Future<Map<String, dynamic>> editarUsuario(
      int cui, String password, String nombre, String imagen) async {
    final authData = {
      'CUI': cui,
      'PASSWORD': password,
      'NOMBRE': nombre,
      'IMAGEN': imagen
    };
    final resp = await http.put('http://' + _url + ':3002/put/usuarioAU',
        body: json.encode(authData),
        headers: {"Content-Type": "application/json"});
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    return decodedResp;
  }

  Future<Map<String, dynamic>> iniciarSesion(int cui, String password) async {
    final authData = {'CUI': cui, 'PASSWORD': password};
    final resp = await http.post('http://' + _url + ':3002/post/iniciar_sesion',
        body: json.encode(authData),
        headers: {"Content-Type": "application/json"});
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey('token')) {
      _prefs.token = decodedResp['token'];
      _prefs.cui = cui;
      _prefs.password = password;
      _prefs.tipo = decodedResp['tipo'];
      _prefs.nombre = decodedResp['nombre'];
    }
    return decodedResp;
  }

  Future<Map<String, dynamic>> publicacion(
      int tipo,
      String nombre,
      String descripcion,
      double posicionX,
      double posicionY,
      int estado,
      int subtipo,
      String fechahora) async {
    final authData = {
      'TIPO': tipo,
      'NOMBRE': nombre,
      'DESCRIPCION': descripcion,
      'POSICIONX': posicionX,
      'POSICIONY': posicionY,
      'FECHAHORA': fechahora,
      'ESTADO': estado,
      'CUI': _prefs.cui,
      'TOKEN': _prefs.token,
      'SUBTIPO': subtipo
    };

    final resp = await http.post('http://' + _url + ':3002/post/publicacionAU',
        body: json.encode(authData),
        headers: {"Content-Type": "application/json"});
    if (resp.body == null) return null;
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey('codigo')) {
      if (decodedResp['codigo'] == 505) {
        await iniciarSesion(_prefs.cui, _prefs.password);
        await publicacion(tipo, nombre, descripcion, posicionX, posicionY,
            estado, subtipo, fechahora);
      }
    }
    return decodedResp;
  }

  Future<UsuarioModel> cargarUsuario(int cui) async {
    final resp = await http.get(
        'http://' + _url + ':3002/get/usuarioAU?CUI=' + cui.toString(),
        headers: {"Content-Type": "application/json"});
    if (resp.body == null) return null;
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp == null) return null;
    final usuarioTemp = UsuarioModel.fromJson(decodedResp);
    return usuarioTemp;
  }

  Future<Map<String, dynamic>> recuperarContra(int cui) async {
    final authData = {'CUI': cui};
    final resp = await http.post(
        'http://' + _url + ':3002/post/recuperar_contra',
        body: json.encode(authData),
        headers: {"Content-Type": "application/json"});
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    return decodedResp;
  }

  Future<Map<String, dynamic>> getEstadistica() async {
    try {
      final resp = await http.get('http://' + _url + ':3000/get/estadisticasAU',
          headers: {"Content-Type": "application/json"});
      Map<String, dynamic> decodedData = json.decode(resp.body);
      if (decodedData['codigo'] != 200) return null;
      return decodedData;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getEstadistica2() async {
    try {
      final resp = await http.get(
          'http://' + _url + ':3002/get/estadisticas2AU',
          headers: {"Content-Type": "application/json"});
      Map<String, dynamic> decodedData = json.decode(resp.body);
      if (decodedData['codigo'] != 200) return null;
      return decodedData;
    } catch (e) {
      return null;
    }
  }
}
