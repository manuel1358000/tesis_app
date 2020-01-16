import 'package:alerta_app/src/models/publicacion_model.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HistoriaHorizontal extends StatelessWidget {
  final List<PublicacionModel> publicaciones;
  final Function siguientePagina;
  HistoriaHorizontal({@required this.publicaciones,@required this.siguientePagina});
  final _pageController=new PageController(
    initialPage: 1,
    viewportFraction: 0.25
  );
  @override
  Widget build(BuildContext context) {
    final _size=MediaQuery.of(context).size;
    _pageController.addListener((){
      if(_pageController.position.pixels>=_pageController.position.maxScrollExtent-200){
        print('SIgueintes datos');
        siguientePagina(0);
      }
    });
    return Container(
      alignment: Alignment.bottomLeft,
      height: _size.height*0.10,
      width: double.infinity,
      child: PageView.builder(
        dragStartBehavior: DragStartBehavior.start,
        pageSnapping: false,
        controller: _pageController,
        //children: _historias(context),
        itemCount: publicaciones.length,
        itemBuilder: ( context, i)=> _crearHistoria(context,publicaciones[i]),
      ),
    );
  }

  Widget _crearHistoria(BuildContext context,PublicacionModel publicacion){
    return Row(
        children: <Widget>[
          SizedBox(width: 3),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context,'ver_publicacion',arguments:publicacion);
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
  }
}