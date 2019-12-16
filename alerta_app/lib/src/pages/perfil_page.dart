import 'package:flutter/material.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:alerta_app/src/models/usuario_model.dart';
class PerfilPage extends StatelessWidget {
  final _prefs = new PreferenciasUsuario();
  final usuarioProvider =new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
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
                SizedBox(height:80.0,),
                Text(_prefs.nombre,style: TextStyle(fontSize: 20,color:Color.fromRGBO(42,26,94,1.0),),),
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
          Center(child:CircularProgressIndicator());
        }
        return Container();
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