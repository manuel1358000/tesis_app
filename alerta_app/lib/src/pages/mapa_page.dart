import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.ofLogin(context);
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height 
          child: AppBar(
            title: Text('AlertaUSAC'),
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
            ],
          ),
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
              label: 'ALERTA',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () =>  Navigator.pushNamed(context,'alerta')
            ),
            SpeedDialChild(
              child: Icon(Icons.calendar_today),
              backgroundColor: Color.fromRGBO(251, 229, 85,1.0),
              label: 'EVENTO',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () =>  Navigator.pushNamed(context,'evento'),
            ),
          ],
        );
  }

 _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager=true;
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    .then((Position position) {
      setState(() {
        print(position.latitude.toString()+'-'+position.longitude.toString());
      });
    }).catchError((e) {
      print(e);
    });
  }

  Widget _crearCarrete(BuildContext context){
    final _screenSize=MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.10,
      child: PageView.builder(
        pageSnapping: false,
        // children: _tarjetas(context),
        itemCount: 1,
        itemBuilder: ( context, i ) =>_tarjeta(context),
      ),
    );
  }

  Widget _tarjeta(BuildContext context){
    return Container(
        padding: EdgeInsets.only(left:10.0),
        color:Color.fromRGBO(42,26,94,1.0) ,
        child: Row(
          children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: FadeInImage(
                  image: NetworkImage('assets/mapa2.jpg'),
                  placeholder: AssetImage('assets/mapa2.jpg'),
                  fit: BoxFit.cover,
                  height: 50.0,
                ),
              ),
          ],
        )
  );
}

  Widget _crearFlutterMap(BuildContext context, LoginBloc bloc){
    
    return Container(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(14.586493,-90.552185),
          zoom: 17
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
          point: LatLng(14.586493,-90.552185),
          builder: (context)=>Container(
            child: Icon(Icons.location_on,size:45.0,color: Colors.red,),
          )
        )
      ]
    );   
  }
}