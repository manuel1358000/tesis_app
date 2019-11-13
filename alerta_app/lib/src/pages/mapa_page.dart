import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:alerta_app/src/bloc/provider.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
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
      body:Stack(
        children: <Widget>[
           _crearFlutterMap(context,bloc),
        ],
      ),
      drawer: MenuWidget(),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(42,26,94,1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme
          .copyWith( caption: TextStyle( color: Colors.white ) )
      ),
      child: BottomNavigationBar(
        
        items: [
          BottomNavigationBarItem(
            icon: Icon( Icons.calendar_today, size: 30.0 ),
            title: Text('MIS PUBLICACIONES',style: TextStyle(fontSize: 8),)
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.gps_fixed, size: 35.0 ),
            title: Text('CREAR',style: TextStyle(fontSize: 10))
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.supervised_user_circle, size: 30.0 ),
            title: Text('USUARIOS',style:TextStyle(fontSize: 10))
          ),
        ],
      ),
    );
  }

  Widget _itemPerfil(int perfil,BuildContext context){
    //perfil 1 es usuario normal
    //perfil 2 es usuario administrador
    //perfil 3 es usuario invitado
    if(perfil==1){
      return Container(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MI PERFIL',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'perfil');
              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MIS PUBLICACIONES',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
            ), 
            ListTile(
              leading: Icon(Icons.map,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MAPA',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'mapa');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.close,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('CERRAR SESION',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
            ),
          ],
        ),
      );
    }else if(perfil==2){
      return Container(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MI PERFIL',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MIS PUBLICACIONES',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
            ), 
            ListTile(
              leading: Icon(Icons.format_list_bulleted,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('PUBLICACIONES',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
            ),
            ListTile(
              leading: Icon(Icons.group,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('USUARIOS',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
            ),
            ListTile(
              leading: Icon(Icons.map,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MAPA',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'mapa');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.close,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('CERRAR SESION',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
            ),
          ],
        ),
      );
    }else{
      return Container(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.map,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MAPA',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'mapa');
              },
            ),
            ListTile(
              leading: Icon(Icons.close,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('CERRAR SESION',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
            ),
          ],
        ),
      );
    }
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
}