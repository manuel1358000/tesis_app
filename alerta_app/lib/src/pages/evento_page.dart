import 'package:flutter/material.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/bloc/provider.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:alerta_app/src/bloc/publicacion_bloc.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
class EventoPage extends StatefulWidget {
  @override
  _EventoPageState createState() => _EventoPageState();
}

class _EventoPageState extends State<EventoPage> {
  final _prefs = new PreferenciasUsuario();
  final usuarioProvider=new UsuarioProvider();
  String _fecha='';
  String _hora='';
  TextEditingController _inputFieldDateController=new TextEditingController();
   TextEditingController _inputFieldTimeController=new TextEditingController();
  String _opcionSeleccionada='Academico';
  List<String> _tipos=['Academico','Educativo','Informativo','Seguridad','Cultural','Social','Deportivo','Recreativo','Otro'];

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
    final size=MediaQuery.of(context).size;
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
                Text('Tipo de Evento',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize:20)),
                SizedBox(height: 10.0,),
                _crearTIPO(context,bloc),
                SizedBox(height: 15.0,),
                _crearFECHA(context,bloc),
                SizedBox(height: 30.0),
                _crearHORA(context,bloc),
                SizedBox(height: 30.0),
                _crearNOMBRE(context,bloc),
                SizedBox(height: 20.0,),
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
      case "Academico": return Icon(Icons.local_library,color: Colors.green,);
      case "Educativo": return Icon(Icons.local_library,color:Colors.green);
      case "Informativo": return Icon(Icons.insert_comment,color:Colors.red);
      case "Seguridad": return Icon(Icons.security,color:Colors.red);
      case "Cultural": return Icon(Icons.sms,color:Colors.blue);
      case "Social": return Icon(Icons.sms,color:Colors.blue);
      case "Deportivo": return Icon(Icons.directions_bike,color:Colors.purple);
      case "Recreativo": return Icon(Icons.supervisor_account,color:Colors.purple);      
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
      case "Academico": return 7;
      case "Educativo": return 8;
      case "Informativo": return 9;
      case "Seguridad": return 10;
      case "Cultural": return 11;
      case "Social": return 12;
      case "Deportivo": return 13;
      case "Recreativo": return 14;      
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
              labelText: 'Titulo Evento',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0),
              )
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
              labelText: 'Descripcion Evento',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0),
              )
            ),
            onChanged: (value)=>bloc.changeDescripcion(value),
          ),
        );
      }
    );
  }

  Widget _crearFECHA(BuildContext context, PublicacionBloc bloc){
    return StreamBuilder(
      stream:bloc.fechaStream,
      builder:(BuildContext context,AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _inputFieldDateController,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Color.fromRGBO(42,26,94,1.0),
              labelText: 'Fecha Evento',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0),
              )
            ),
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              _selectDate(context);
            },
          ),
        );
      }
    );
  }
  Widget _crearHORA(BuildContext context, PublicacionBloc bloc){
    return StreamBuilder(
      stream:bloc.fechaStream,
      builder:(BuildContext context,AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _inputFieldTimeController,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Color.fromRGBO(42,26,94,1.0),
              labelText: 'Hora Evento',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0),
              )
            ),
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              _selectHour(context);
            },
          ),
        );
      }
    );
  }
  Widget _crearIngreso(BuildContext context,PublicacionBloc bloc){
    final size=MediaQuery.of(context).size;
    return RaisedButton(
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Color.fromRGBO(244,89,5,1.0),
      child: Container(
        width:size.width*0.65,
        child: Center(
          child: Text('Publicar',style: TextStyle(color:Colors.white)),
        )
      ),
      onPressed: (){
        _getCurrentLocation(bloc,context);
        //_login(bloc,context);
      },
    );
  }
  
  _selectDate(BuildContext context)async{
    DateTime picker=await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      locale: Locale('es','ES')
    );
    if(picker!=null){
      setState(() {
        var objetos=picker.toString().split(' ');
        _fecha=objetos[0];
        _inputFieldDateController.text=_fecha;        
      });
    }
  }
  _selectHour(BuildContext context)async{
    TimeOfDay picker=await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
    );
    if(picker!=null){
      setState(() {
        
        _hora=picker.format(context);
        _inputFieldTimeController.text=_hora;        
      });
    }
  }
   _getCurrentLocation(PublicacionBloc bloc,BuildContext context){
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager=true;
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    .then((Position position) {
      _registrarPublicacion(bloc,position,context);
    }).catchError((e) {
      print('error: '+e);
    });
  }

  _registrarPublicacion(PublicacionBloc bloc,Position position,BuildContext context)async {
    print("aqui1");
    DateTime now = new DateTime.now();
    Map info=await usuarioProvider.publicacion(1,bloc.nombre,bloc.descripcion,position.latitude,position.longitude,1,bloc.subtipo,now.toString());
    if(info['codigo']==200){
      await mostrarAlerta(context,info['mensaje']);
      Navigator.pushNamedAndRemoveUntil(context,'mapa',(_)=>false);
    }else{
      mostrarAlerta(context,info['mensaje']);
    }
  }
}