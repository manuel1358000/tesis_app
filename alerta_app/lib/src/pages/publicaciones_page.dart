import 'package:flutter/material.dart';
import 'package:alerta_app/src/widgets/publicacion_widget.dart';
import 'package:alerta_app/src/provider/publicacion_provider.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
class PublicacionesPage extends StatelessWidget {
  
  final publicacionProvider=new PublicacionProvider();
  
  @override
  Widget build(BuildContext context) {
    publicacionProvider.getGeneral(0);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Publicaciones Generales'),
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: publicacionProvider.generalStream,
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData)return CircularProgressIndicator();
              return PublicacionWidget(publicaciones: snapshot.data,
                siguientePagina: publicacionProvider.getGeneral,
                actual: 'publicaciones',
              );
            },
          )
        ],
      ),
    );
  }


}