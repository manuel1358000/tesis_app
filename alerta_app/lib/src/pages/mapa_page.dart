import 'package:alerta_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:alerta_app/src/bloc/provider.dart';
class MapaPage extends StatelessWidget {
  const MapaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.ofLogin(context);
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
      body:_crearFlutterMap(context,bloc)
      
    );
  }
  Widget _crearCarrete(BuildContext context,LoginBloc bloc){
    mostrarAlerta(context,'Bienvenido ${bloc.cui}');
    return Container(
      child: Text('Container'),
      height: 20,
      color: Colors.black,
    );
  }
  Widget _crearFlutterMap(BuildContext context, LoginBloc bloc){
    //mostrarAlerta(context,'Bievenido ${bloc.cui}');
    print(bloc.cui);
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