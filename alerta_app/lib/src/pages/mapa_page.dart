import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapaPage extends StatelessWidget {
  const MapaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text('Alertas'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){},
          )
        ],
      ),
      body:_crearFlutterMap()
      
    );
  }
  Widget _crearCarrete(){
    return Container(
      child: Text('Container'),
      height: 20,
      color: Colors.black,
    );
  }
  Widget _crearFlutterMap(){
    return FlutterMap(
        options: MapOptions(
          center: LatLng(14.586493,-90.552185),
          zoom: 15
        ),
        layers:[
          _crearMapa(),
        ]
    );
  }
  _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoibWFudWVsMTM1ODAiLCJhIjoiY2syYmZ1MGtxMDM5bjNscGpnemRvaHZ0eiJ9.BYcnZMXkIKvvH52ijm9XvA',
        'id': 'mapbox.dark'
        //streets, dark, light, outdoors, satellite
      }
    );
  }
}