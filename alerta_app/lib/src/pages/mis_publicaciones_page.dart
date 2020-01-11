import 'package:flutter/material.dart';
import 'package:alerta_app/src/widgets/publicacion_vertical.dart';
import 'package:alerta_app/src/provider/publicacion_provider.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
class MisPublicacionesPage extends StatelessWidget {
  
  final publicacionProvider=new PublicacionProvider();
  
  @override
  Widget build(BuildContext context) {
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
    final _size=MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: publicacionProvider.getGeneral(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData)return CircularProgressIndicator();
              return PublicacionVertical(publicaciones: snapshot.data);
            },
          )
        ],
      ),
    );
  }


}