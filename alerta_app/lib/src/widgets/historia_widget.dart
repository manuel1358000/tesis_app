import 'package:alerta_app/src/models/publicacion_model.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HistoriaHorizontal extends StatelessWidget {
  
  final List<PublicacionModel> publicaciones;

  HistoriaHorizontal({@required this.publicaciones});

  @override
  Widget build(BuildContext context) {
    final _size=MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomLeft,
      height: _size.height*0.10,
      width: double.infinity,
      child: PageView(
        dragStartBehavior: DragStartBehavior.start,
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.25
        ),
        children: _historias(context),
      ),
    );
  }
  List<Widget> _historias(BuildContext context){
    return publicaciones.map((publicacion){
      return Row(
        children: <Widget>[
          SizedBox(width: 3),
          GestureDetector(
            onTap: (){
              mostrarAlerta(context,'Publicacion '+publicacion.nombre);
            },
            child: Container(
              width: 50,
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                minRadius: 20,
                maxRadius: 25,
                backgroundImage: AssetImage(publicacion.tipo==2?'assets/icono5.png':'assets/icono4.png'),
                )
            ),
          ),
        ],
      );
    }).toList();

  }

}