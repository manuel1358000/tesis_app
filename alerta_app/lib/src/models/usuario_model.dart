// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromJson(jsonString);
import 'dart:convert';
UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));
String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());
class UsuarioModel {
    int cui;
    String password;
    String nombre;
    UsuarioModel({
        this.cui=0,
        this.password="",
        this.nombre="",
    });
    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        cui: int.parse(json["cui"]),
        password: json["password"],
        nombre: json["nombre"],
    );
    Map<String, dynamic> toJson() => {
        "cui": cui,
        "password": password,
        "nombre": nombre,
    };
}
