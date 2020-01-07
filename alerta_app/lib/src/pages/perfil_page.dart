import 'package:flutter/material.dart';
import 'package:alerta_app/src/utils/data.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:alerta_app/src/models/usuario_model.dart';
import 'package:shimmer/shimmer.dart';
class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _prefs = new PreferenciasUsuario();

  final usuarioProvider =new UsuarioProvider();

  Data data2;

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PERFIL'),
      ),
      body:SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            _crearFondo(context),
            _infoPerfil(context),
            _avatarPerfil(context),
          ],
        ),
      ), 
      drawer: MenuWidget(),
    );
  }

  Widget _avatarPerfil(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SafeArea(
            child: Container(
              height: size.height*0.05,
            ), 
          ),
          Container(
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://cdn0.iconfinder.com/data/icons/flat-design-business-set-3/24/people-customers-512.png'),
              backgroundColor: Colors.white,
              radius: 60,
            ),
            decoration:BoxDecoration(
              boxShadow: [new BoxShadow(
                color: Colors.black,
                blurRadius: 20.0,
              ),],
              color: Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(60.0))
            )
          )
      ],
    );
  }

  Widget _infoPerfil(BuildContext context){
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
                blurRadius: 20.0,
              ),],
              color: Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(40.0))
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height:80.0),
                Text(_prefs.nombre,textAlign: TextAlign.center ,style: TextStyle(fontSize: 20,color:Color.fromRGBO(42,26,94,1.0))), 
                SizedBox(height:20.0,),
                _datosPerfil(),
                SizedBox(height:20.0,),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _datosPerfil(){
    return FutureBuilder(
      future: usuarioProvider.cargarUsuario(_prefs.cui),
      builder: (BuildContext context, AsyncSnapshot<UsuarioModel> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child:CircularProgressIndicator(
              backgroundColor: Color.fromRGBO(42,26,94,1.0)
            )
          );
        }
        UsuarioModel usuario=snapshot.data;
        return Container(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _itemDatos(Icons.format_list_numbered_rtl,'CUI',usuario.cui.toString()),
              //SizedBox(height: 20),
              //_itemDatos(Icons.group,'NOMBRE',usuario.nombre),
              SizedBox(height: 20),
              _itemDatos(Icons.filter_none,'NOMBRE',usuario.nombre),
              SizedBox(height: 20.0,),
              _itemDatos(Icons.lock_outline,'CONTRASEÑA',usuario.password),
              SizedBox(height: 20.0,),
              _actualizarDatos(context,usuario)
            ],
          ),
        );
      },
    );
  }

  Widget _itemDatos(IconData icono,String tipo,String datos){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.only(left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(icono,color: Color.fromRGBO(42,26,94,1.0),),
            SizedBox(width:25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(tipo,style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(244,89,5,1.0))),
                SizedBox(height: 10,),
                Text(datos,style: TextStyle(fontSize: 15.0, color: Color.fromRGBO(42,26,94,1.0)))
              ],
            )
          ],
        ),
      ),
    );
  }

 Widget _actualizarDatos(BuildContext context,UsuarioModel usuario){
  final size=MediaQuery.of(context).size;
  return RaisedButton(
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    color: Color.fromRGBO(244,89,5,1.0),
    child: Container(
      width:size.width*0.65,
      child: Center(
        child: Text('Actualizar Datos',style: TextStyle(color:Colors.white)),
      )
    ),
    onPressed: (){
      Navigator.pushNamed(context,'editarusuario',arguments:usuario);
    },
  );
}

  Widget _crearFondo(BuildContext context){
    final _screenSize=MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: _screenSize.height*0.40,
          width: _screenSize.width,
          color: Color.fromRGBO(42,26,94,1.0),
        ),
        Container(
          height: _screenSize.height*0.50,
          color: Colors.white,
        )
      ],
    );
  }
}