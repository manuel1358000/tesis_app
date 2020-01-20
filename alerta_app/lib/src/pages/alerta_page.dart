import 'package:flutter/material.dart';
import 'package:alerta_app/src/utils/data.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/bloc/provider.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:alerta_app/src/bloc/publicacion_bloc.dart';
class AlertaPage extends StatefulWidget {
  @override
  _AlertaPageState createState() => _AlertaPageState();
}

class _AlertaPageState extends State<AlertaPage> {
  final usuarioProvider=new UsuarioProvider();
  String _opcionSeleccionada='Emergencia Medica';
  List<String> _tipos=['Emergencia Medica','Accidente Vehicular','Asalto','Robo Vehiculo','Incendio','Bloqueo','Otro'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height 
        child: AppBar(
          backgroundColor: Color.fromRGBO(244,89,5,1.0),
          title: Text('AlertaUSAC'),
          centerTitle: true,
          elevation: 5.0,
        ),
      ), 
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _alertaForm(context),
        ],
      )
    );
  }

  Widget _crearFondo(BuildContext context){
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(42,26,94,1.0)
      ),
    );
  }

  Widget _alertaForm(BuildContext context){
    final bloc =Provider.ofPublicacion(context);
    bloc.setSubtipo=1;
    final size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height*0.15,
            ), 
          ),
          Container(
            width: size.width*0.85,
            decoration:BoxDecoration(
              boxShadow: [new BoxShadow(
                color: Colors.black,
                blurRadius: 25.0,
              ),],
              color: Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(40.0))
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 25.0,),
                Text('Tipo Alerta',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize:20)),
                SizedBox(height: 10.0,),
                _crearTIPO(context,bloc),
                SizedBox(height: 15.0,),
                _crearNOMBRE(context,bloc),
                SizedBox(height: 25.0,),
                _crearDESCRIPCION(context,bloc),
                SizedBox(height: 30.0),
                _crearIngreso(context,bloc),
                SizedBox(height: 30.0,),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget _iconoDropdown(String tipo){
    switch(tipo){
      case "Emergencia Medica": return Icon(Icons.local_hospital,color: Colors.red,);
      case "Asalto": return Icon(Icons.directions_run,color:Colors.blue );
      case "Robo Vehiculo": return Icon(Icons.directions_run,color:Colors.blue,);
      case "Accidente Vehicular": return Icon(Icons.local_hospital,color:Colors.red);
      case "Bloqueo": return Icon(Icons.block,color:Colors.green);
      case "Incendio": return Icon(Icons.priority_high,color:Colors.green);
      default: return Icon(Icons.outlined_flag,color:Colors.yellow);
    }
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(){  
    List<DropdownMenuItem<String>> lista=new List();
    _tipos.forEach((tipo){
      lista.add(DropdownMenuItem(
        child: Row(
          children: <Widget>[
            _iconoDropdown(tipo),
            SizedBox(width: 10.0,),
            Text(tipo,style:TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
          ],
        ),
        value: tipo,
      ));
    });
    return lista;
  }

  Widget _crearTIPO(BuildContext context,PublicacionBloc bloc){
    return Center(
      child: DropdownButton(
        value: _opcionSeleccionada,
        items: getOpcionesDropdown(),
        onChanged: (opt){
          setState((){
            bloc.setSubtipo=_valueDropdown(opt);
            _opcionSeleccionada=opt;
          });
        },
      ),
    );
  }
  int _valueDropdown(String tipo){
    switch(tipo){
      case "Emergencia Medica": return 1;
      case "Accidente Vehicular": return 2;
      case "Asalto": return 3;
      case "Robo Vehiculo": return 4;
      case "Bloqueo": return 5;
      case "Incendio": return 6;
      default: return 0;
    }
  }

  Widget _crearNOMBRE(BuildContext context,PublicacionBloc bloc){
    return StreamBuilder(
      stream:bloc.nombreStream,
      builder:(BuildContext context,AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Color.fromRGBO(42,26,94,1.0),
              labelText: 'Titulo Alerta',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0),
              ),
              errorText: snapshot.error
            ),
            onChanged: (value)=>bloc.changeNombre(value),
          ),
        );
      }
    );
  }

  Widget _crearDESCRIPCION(BuildContext context,PublicacionBloc bloc){
    return StreamBuilder(
      stream:bloc.descripcionStream,
      builder:(BuildContext context,AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Color.fromRGBO(42,26,94,1.0),
              labelText: 'Descripcion Alerta',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0),
              ),
              errorText: snapshot.error
            ),
            onChanged: (value)=>bloc.changeDescripcion(value),
          ),
        );
      }
    );
  }

  Widget _crearIngreso(BuildContext context,PublicacionBloc bloc){
    final size=MediaQuery.of(context).size;
    return StreamBuilder(
      stream: bloc.formValidatorAlerta,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          color: Color.fromRGBO(244,89,5,1.0),
          child: Container(
            width:size.width*0.65,
            child: Center(
              child: Text('Publicar',style: TextStyle(color:Colors.white)),
            )
          ),
          onPressed: snapshot.hasData ? (){
            _getCurrentLocation(bloc,context);
          }:null,
        );
      },
    );
  }

   _getCurrentLocation(PublicacionBloc bloc,BuildContext context)async{
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager=true;
     Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _registrarPublicacion(bloc,position,context);
  }

  _registrarPublicacion(PublicacionBloc bloc,Position position,BuildContext context)async {
    DateTime now = new DateTime.now();
    Map info=await usuarioProvider.publicacion(1,bloc.nombre,bloc.descripcion,position.latitude,position.longitude,1,_valueDropdown(_opcionSeleccionada),now.toString());
    if(info['codigo']==200){
      final Data data= new Data(contenido:'Alerta creada con exito');
      Navigator.pushNamed(context,'mapa',arguments: data);
    }else{
      mostrarAlerta(context,info['mensaje']);
    }
  }
}