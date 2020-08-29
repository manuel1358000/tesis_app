import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:alerta_app/src/models/publicacion_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class VerPublicacionPage extends StatelessWidget {
  PublicacionModel publicacionData;
  final _prefs=new PreferenciasUsuario();
  Widget build(BuildContext context) {
    publicacionData=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Publicacion'),
      ),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearInformacion(context)
        ],
      )
    );
  }
  Widget _crearFondo(BuildContext context){
  final size=MediaQuery.of(context).size;
  return SingleChildScrollView(
      child: Column(
      children: <Widget>[
        Image.asset('assets/cum.png',width: double.infinity,),
        Container(
          height: size.height*0.60,
          width: double.infinity,
          color: Colors.white,
        ),
      ],
      
    ),
  );
  }
  Widget _crearInformacion(BuildContext context){
    final size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height*0.25,
            ), 
          ),
          Container(
            height: size.height*0.35,
            width: size.width*0.80,
            decoration:BoxDecoration(
              boxShadow: [new BoxShadow(
                color: Colors.black,
                blurRadius: 20.0,
              ),],
              color: Color.fromRGBO(42,26,94,1),
              borderRadius: new BorderRadius.all(Radius.circular(40.0))
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                _crearNombre(),
                SizedBox(height: 15.0),
                _crearTipo(),
                SizedBox(height: 20.0),
                _crearFechaHora(),
                SizedBox(height: 20.0,)
              ],            
            ),
          ),
          SizedBox(height: 30,),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                _crearDescripcion(context),
                SizedBox(height: 30.0,),
                _crearEditar(context),
                SizedBox(height: 30),
                _crearPosicion(context),
              ],
            ),
          ),      
        ],
      ),
    );
  }
  Widget _crearPosicion(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment(-0.75,0),
          child:Text('Ubicacion',style: TextStyle(color:Color.fromRGBO(42,26,94,1.0),fontSize: 20,fontWeight:FontWeight.bold)),
        ),
        _crearFlutterMap(context)
      ],
    );
  }
  Widget _crearFlutterMap(BuildContext context){
    return Container(
      height: 400,
      width: 400,
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
        width: 25.0,
        height: 25.0,
        point: LatLng(publicacionData.posicionx,publicacionData.posiciony),
        builder: (context)=>Container(
          child: GestureDetector(
            child: Container(
              child: _iconoDropdown(publicacionData.subtipo),
              decoration:BoxDecoration(
                boxShadow: [new BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0,
                ),],
                color: Colors.white,
                borderRadius: new BorderRadius.all(Radius.circular(35.0))
              )
            ),
          ),
        ),
      )
      ]
    );   
  }
  Widget _crearDescripcion(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Column(
      children:<Widget>[
        Container(
          alignment: Alignment(-0.75,0),
          child:Text('Descripcion',style: TextStyle(color:Color.fromRGBO(42,26,94,1.0),fontSize: 20,fontWeight:FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Container(
          width: size.width*0.80,
          child: Text(publicacionData.descripcion,textAlign: TextAlign.justify,),
        ),
      ]
    );
  }
  Widget _crearFechaHora(){
    String dateWithT = publicacionData.fechahora.substring(0,10) + publicacionData.fechahora.substring(10);
    DateTime dateTime = DateTime.parse(dateWithT);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.calendar_today,color: Colors.white),
        SizedBox(width: 10,),
        Text(dateTime.day.toString()+'-'+dateTime.month.toString()+'-'+dateTime.year.toString(),style: TextStyle(color: Colors.white),),
        SizedBox(width: 10),
        Icon(Icons.watch,color: Colors.white),
        SizedBox(width: 10,),
        Text(dateTime.hour.toString()+':'+dateTime.minute.toString()+':'+dateTime.second.toString(),style: TextStyle(color: Colors.white),)
      ],
    );
  }
  Widget _crearTipo(){
    return Column(
      children: <Widget>[
        Text('Tipo',style: TextStyle(color: Colors.white)),
        Text(publicacionData.tipo==1?"Alerta":"Evento".toString(),style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold)),
      ],
    ); 
  }
  Widget _crearNombre(){
    return Column(
      children: <Widget>[
        Text('Titulo',style: TextStyle(color: Colors.white)),
        Text(publicacionData.nombre,style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      ],
    );
  }
  Widget _crearEditar(BuildContext context){
    if(_prefs.cui!=publicacionData.cui)return Container();
    final size=MediaQuery.of(context).size;
    return RaisedButton(
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Color.fromRGBO(244,89,5,1.0),
      child: Container(
        height: size.height*0.05,
        width:size.width*0.60,
        child: Center(
          child: Text('Editar',style: TextStyle(color:Colors.white)),
        )
      ),
      onPressed: (){
        mostrarAlerta(context,'Editar Publicacion');
      },
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