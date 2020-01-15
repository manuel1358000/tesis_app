import 'package:flutter/material.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:alerta_app/src/widgets/publicacion_widget.dart';
import 'package:alerta_app/src/provider/publicacion_provider.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
class MisPublicacionesPage extends StatelessWidget {
  
  final publicacionProvider=new PublicacionProvider();
  final _prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    publicacionProvider.getUsuario(_prefs.cui);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mis publicaciones'),
      ),
      body: Container(
        child: Center(
          child: _listado(context),
        ),
      ),
      drawer: MenuWidget(),
    );
  }
  Widget _listado(BuildContext context){
    print(_prefs.cui);
    final _size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: publicacionProvider.usuarioStream,
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return PublicacionWidget(
                  publicaciones: snapshot.data,
                  siguientePagina: publicacionProvider.getUsuario,
                  actual: 'mispublicaciones',
                );
              }else{
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}