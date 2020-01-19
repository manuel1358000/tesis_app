import 'package:flutter/material.dart';
import 'package:alerta_app/src/models/publicacion_model.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MarcadorPage extends StatelessWidget {
  final List<PublicacionModel> publicaciones;
  MarcadorPage({@required this.publicaciones});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterMap(
        options: MapOptions(
          center:  new LatLng(14.611468, -90.545515),
          zoom: 18
        ),
        layers:[
          _crearMapa(),
          MarkerLayerOptions(
            markers: _crearMarcadores()
          )
        ]
      ),
    );
  }
  List<Marker> _crearMarcadores(){
    return publicaciones.map((publicacion){
      return Marker(
        width: 25.0,
        height: 25.0,
        point: LatLng(publicacion.posicionx,publicacion.posiciony),
        builder: (context)=>Container(
          child: GestureDetector(
            child: Container(
              child: _iconoDropdown(publicacion.subtipo),
              decoration:BoxDecoration(
                boxShadow: [new BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0,
                ),],
                color: Colors.white,
                borderRadius: new BorderRadius.all(Radius.circular(35.0))
              )
            ),
            onTap:(){
              Navigator.pushNamed(context,'ver_publicacion',arguments:publicacion);
            },
          ),
        ),
      );
    }).toList();
  }
  _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoibWFudWVsMTM1ODAiLCJhIjoiY2syYmZ1MGtxMDM5bjNscGpnemRvaHZ0eiJ9.BYcnZMXkIKvvH52ijm9XvA',
        'id': 'mapbox.streets'
        //streets, dark, light, outdoors, satellite
      }
    );
  }
  Widget _iconoDropdown(int tipo){
    double tam=18;
    switch(tipo.toString()){
      case "1": return Icon(Icons.local_hospital,color:Colors.red,size: tam);
      case "2": return Icon(Icons.directions_run,color:Colors.blue,size:tam);
      case "3": return Icon(Icons.directions_run,color:Colors.blue,size:tam);
      case "4": return Icon(Icons.local_hospital,color:Colors.red,size: tam);
      case "5": return Icon(Icons.block,color:Colors.green,size: tam);
      case "6": return Icon(Icons.priority_high,color:Colors.green,size: tam);
      case "7": return Icon(Icons.local_library,color:Colors.green,size: tam);
      case "8": return Icon(Icons.local_library,color:Colors.green,size: tam);
      case "9": return Icon(Icons.insert_comment,color:Colors.red,size: tam);
      case "10": return Icon(Icons.security,color:Colors.red,size: tam);
      case "11": return Icon(Icons.sms,color:Colors.blue,size: tam);
      case "12": return Icon(Icons.sms,color:Colors.blue,size: tam);
      case "13": return Icon(Icons.directions_bike,color:Colors.purple,size: tam);
      case "14": return Icon(Icons.supervisor_account,color:Colors.purple,size: tam);
      case "15": return Icon(Icons.security,color:Colors.red,size: tam);      
      default: return Icon(Icons.outlined_flag,color:Colors.yellow,size: tam);
    }
  }
}