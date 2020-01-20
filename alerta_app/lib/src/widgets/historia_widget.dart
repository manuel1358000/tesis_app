import 'package:alerta_app/src/models/publicacion_model.dart';
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
              height: 45,
              width: 45,
              decoration:BoxDecoration(
                boxShadow: [new BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0,
                ),],
                color: Colors.white,
                borderRadius: new BorderRadius.all(Radius.circular(45.0))
              ),
              child: _iconoDropdown(publicacion.subtipo)
            ),
          ),
        ],
      );
  }
  Widget _iconoDropdown(int tipo){
    double tam=35;
    switch(tipo.toString()){
      case "1": return Icon(Icons.local_hospital,color:Colors.red,size: tam);
      case "2": return Icon(Icons.directions_run,color:Colors.blue,size:tam);
      case "3": return Icon(Icons.directions_run,color:Colors.blue,size:tam);
      case "4": return Icon(Icons.local_hospital,color:Colors.red,size: tam);
      case "5": return Icon(Icons.block,color:Colors.green,size: tam);
      case "6": return Icon(Icons.priority_high,color:Colors.green,size: tam);
      case "7": return Icon(Icons.local_library,color:Colors.green,size: tam);
      case "8": return Icon(Icons.local_library,color:Colors.green,size: tam);
      case "9": return Icon(Icons.insert_comment,color:Colors.red,size: tam);
      case "10": return Icon(Icons.security,color:Colors.red,size: tam);
      case "11": return Icon(Icons.sms,color:Colors.blue,size: tam);
      case "12": return Icon(Icons.sms,color:Colors.blue,size: tam);
      case "13": return Icon(Icons.directions_bike,color:Colors.purple,size: tam);
      case "14": return Icon(Icons.supervisor_account,color:Colors.purple,size: tam);
      case "15": return Icon(Icons.security,color:Colors.red,size: tam);      
      default: return Icon(Icons.outlined_flag,color:Colors.yellow,size: tam);
    }
  }
}