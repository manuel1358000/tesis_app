import 'package:alerta_app/src/provider/publicacion_provider.dart';
import 'package:alerta_app/src/widgets/historia_widget.dart';
import 'package:flutter/material.dart';
import 'package:alerta_app/src/utils/data.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:latlong/latlong.dart';
import 'package:alerta_app/src/bloc/provider.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
import 'package:geolocator/geolocator.dart';
class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final prefs = new PreferenciasUsuario();
  Data data2;
  final PublicacionProvider publicacionProvider=new PublicacionProvider();
  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      mostrarAlerta2(context, data2);
    });
  }
  @override
  Widget build(BuildContext context) {
    data2=ModalRoute.of(context).settings.arguments;
    final bloc = Provider.ofLogin(context);
    return Scaffold(
      appBar:AppBar(
            backgroundColor: Color.fromRGBO(42,26,94,1.0),
            title: Text('AlertaUSAC'),
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child:GestureDetector(
                  child:Icon(Icons.fiber_smart_record,color: Colors.white),
                  onLongPress: (){
                    mostrarAlerta(context,'Boton de Panico');
                  },
                )
              )
            ],
          ),
        body:Stack(
        children: <Widget>[
           _crearFlutterMap(context,bloc),
           _crearCarrete(context)
        ],
      ),
      drawer: MenuWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _crearBotonPublicacion(context),
    );
  }

  Widget _crearBotonPublicacion(BuildContext context){
    return SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: true,
          // If true user is forced to close dial manually 
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Color.fromRGBO(42,26,94,1.0),
          foregroundColor: Colors.white,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.report_problem),
              backgroundColor: Color.fromRGBO(244,89,5,1.0),
              label: 'Alerta',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () =>  Navigator.pushNamed(context,'alerta')
            ),
            SpeedDialChild(
              child: Icon(Icons.calendar_today),
              backgroundColor: Color.fromRGBO(251, 229, 85,1.0),
              label: 'Evento',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () =>  Navigator.pushNamed(context,'evento'),
            ),
          ],
        );
  }
  Widget _crearCarrete(BuildContext context){
    final _screenSize=MediaQuery.of(context).size;
    return Container(
      color: Color.fromRGBO(42,26,94,1.0),
      height: _screenSize.height * 0.10,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: publicacionProvider.getGeneral(0),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              return HistoriaHorizontal(publicaciones: snapshot.data,);
            },
          ),

        ],
      )
    );
  }


  Widget _crearFlutterMap(BuildContext context, LoginBloc bloc){
    
    return Container(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(14.611468, -90.545515),
          zoom: 18
        ),
        layers:[
          _crearMapa(),
          _crearMarcador()
        ]
      ),
    );
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

  _crearMarcador(){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(14.611468, -90.545515),
          builder: (context)=>Container(
            child: GestureDetector(
              child:  Icon(Icons.location_on,size:45.0,color: Colors.red,),
              onTap:(){
                print('Accion del icono');
              },
            ),
          ),
        )
      ]
    );   
  }
}