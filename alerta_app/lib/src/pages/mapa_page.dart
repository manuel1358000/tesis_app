import 'package:flutter/material.dart';
import 'package:alerta_app/src/widgets/marcador_widget.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:alerta_app/src/provider/publicacion_provider.dart';
import 'package:alerta_app/src/widgets/historia_widget.dart';
import 'package:alerta_app/src/utils/data.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  final usuarioProvider=new UsuarioProvider();
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
    publicacionProvider.getGeneral(0);
    return Scaffold(
      appBar:AppBar(
            backgroundColor: Color.fromRGBO(42,26,94,1.0),
            title: Text('AlertaUSAC'),
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  margin: EdgeInsets.all(14.0),
                  child:Icon(Icons.fiber_smart_record,color: Colors.white)
                ),
                onLongPress: (){
                      _getCurrentLocation(context);
                    },
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
  _getCurrentLocation(BuildContext context)async{
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager=true;
    Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _registrarPublicacion(position,context);
  }
  _registrarPublicacion(Position position,BuildContext context)async {
    DateTime now = new DateTime.now();
    Map info=await usuarioProvider.publicacion(1,'Alerta Seguridad','Boton de panico activado por el usuario '+prefs.nombre,position.latitude,position.longitude,1,15,now.toString());
    if(info['codigo']==200){
      mostrarAlerta(context,"Alerta Boton de Panico Enviada");
    }else{
      mostrarAlerta(context,info['mensaje']);
    }
  }

  Widget _crearFlutterMap(BuildContext context,LoginBloc bloc){
    return Container(
      child: FutureBuilder(
        future:publicacionProvider.getMarcador(),
        builder: (BuildContext context,AsyncSnapshot<List> snapshot){
          if(snapshot.hasData){
            return MarcadorPage(publicaciones: snapshot.data,);
          }else{
            return CircularProgressIndicator();
          } 
        },
      ),
    );
  }

  Widget _crearBotonPublicacion(BuildContext context){
    return SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          visible: true,
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
          StreamBuilder(
            stream: publicacionProvider.generalStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return HistoriaHorizontal(publicaciones: snapshot.data,siguientePagina: publicacionProvider.getGeneral,);
              }else{
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      )
    );
  }
}