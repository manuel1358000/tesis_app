// To parse this JSON data, do
//     final publicacionModel = publicacionModelFromJson(jsonString);
import 'dart:convert';

class Publicaciones{
  List<PublicacionModel> items=new List();
  
  Publicaciones();
  
  Publicaciones.fromJsonList(List<dynamic> jsonList){
    if(jsonList==null) return ;
    for(var item in jsonList){
      final publicacion=new PublicacionModel.fromJson(item);
      items.add(publicacion);
    }
  }
}

PublicacionModel publicacionModelFromJson(String str) => PublicacionModel.fromJson(json.decode(str));
String publicacionModelToJson(PublicacionModel data) => json.encode(data.toJson());

class PublicacionModel {
    int cui;
    String nombre;
    int codpublicacion;
    int tipo;
    String descripcion;
    double posicionx;
    double posiciony;
    String fechahora;
    int subtipo;
    bool estado;
    String anterior;
    
    PublicacionModel({
        this.cui=0,
        this.nombre="",
        this.codpublicacion=0,
        this.tipo=0,
        this.descripcion="",
        this.posicionx=0.0,
        this.posiciony=0.0,
        this.fechahora="",
        this.subtipo=1,
        this.estado=true,
        this.anterior=""
    });

    factory PublicacionModel.fromJson(Map<String, dynamic> json) => PublicacionModel(
        cui: int.parse(json["cui"]),
        nombre: json["nombre"],
        codpublicacion: json["cod_publicacion"],
        tipo: json["tipo"],
        descripcion: json["descripcion"],
        posicionx:json["posicion_x"].toDouble(),
        posiciony: json["posicion_y"].toDouble(),
        fechahora: json["fechahora"],
        subtipo: json["subtipo"],
        estado:true,
        anterior: ""
    );

    Map<String, dynamic> toJson() => {
        "cui": cui,
        "nombre": nombre,
        "codpublicacion": codpublicacion,
        "tipo": tipo,
        "descripcion":descripcion,
        "posicionx":posicionx,
        "posiciony":posiciony,
        "fechahora":fechahora,
        "subtipo":subtipo,
        "estado":true,
        "anterior":anterior 
    };
}