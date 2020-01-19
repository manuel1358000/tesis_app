import 'package:flutter/material.dart';
import 'package:alerta_app/src/models/publicacion_model.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapaMarcador extends StatelessWidget {
  final List<PublicacionModel> publicaciones;
  MapaMarcador({@required this.publicaciones});
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
              child: CircleAvatar(
                backgroundImage: NetworkImage('http://www.falmouthpubliclibrary.org/wp-content/uploads/2018/07/xpop-up-alert.png.pagespeed.ic_.vwzzZnK_Rf.png'),
                backgroundColor: Colors.white,
                radius: 30,
              ),
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
              mostrarAlerta(context,"Soy el punto del marcador");
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
}