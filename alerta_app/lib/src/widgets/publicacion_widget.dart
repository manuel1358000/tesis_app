import 'package:alerta_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:alerta_app/src/models/publicacion_model.dart';

class PublicacionWidget extends StatelessWidget {
  final Function siguientePagina;
  final _prefs=new PreferenciasUsuario();
  PublicacionWidget({@required this.publicaciones,@required this.siguientePagina});
  final List<PublicacionModel> publicaciones;
  final _pageController=new PageController(
    initialPage: 1,
    viewportFraction: 0.40
  );
  @override
  Widget build(BuildContext context) {
    final _size=MediaQuery.of(context).size;

    _pageController.addListener((){
      if(_pageController.position.pixels>=_pageController.position.maxScrollExtent-200){
        siguientePagina(_prefs.cui);
      }
    });

    return Container(
      height: _size.height,
      width: _size.width,
      child: PageView(
        controller: _pageController,
        children: _tarjetas(context),
        scrollDirection: Axis.vertical,
      )
    );
  }
  List<Widget> _tarjetas(BuildContext context){
    final _size=MediaQuery.of(context).size;
    return publicaciones.map((publicacion){ 
      String dateWithT = publicacion.fechahora.substring(0,10) + publicacion.fechahora.substring(10);
      DateTime dateTime = DateTime.parse(dateWithT);
      return Container(
        child: Column(
          children: <Widget>[
             Container(
              width: _size.width*0.95,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                //color: Color.fromRGBO(244,89,5,1.0),
                color: Colors.white,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 5,
                      width: _size.width*0.90,
                      color: publicacion.tipo==1?Colors.red:Colors.yellow,
                      child: Text(''),
                    ),
                    SizedBox(height: 15.0,),
                    Text('Tipo',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14,fontWeight: FontWeight.bold)),
                    Text((publicacion.tipo==1?"Alerta":"Evento"),style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14)),
                    SizedBox(height: 15.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Fecha: ', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 13,fontWeight: FontWeight.bold)),
                        Text(dateTime.day.toString()+'-'+dateTime.month.toString()+'-'+dateTime.year.toString(), style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 13)),
                        SizedBox(width: 15.0,),
                        Text('Hora: ', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 13,fontWeight: FontWeight.bold)),
                        Text(dateTime.hour.toString()+':'+dateTime.minute.toString(),style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 13,)),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Text('Titulo',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14,fontWeight: FontWeight.bold)),
                    Text(publicacion.nombre,style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15)),
                    SizedBox(height: 10.0,),
                    Text('Descripcion',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14,fontWeight: FontWeight.bold)),
                    Container(
                      child: Text(publicacion.descripcion, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15)),
                      margin: EdgeInsets.only(right: 20,left: 20),
                    ),
                    
                    Divider(),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: const Text('Ver', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
                            onPressed: () {
                              mostrarAlerta(context,'Ver publicacion '+publicacion.nombre);
                            },
                          ),
                          FlatButton(
                            child: const Text('Editar', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
                            onPressed: () {
                              mostrarAlerta(context,'Editar publicacion '+publicacion.nombre);
                            },
                          ),
                          FlatButton(
                            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              mostrarAlerta(context,'Eliminar publicacion '+publicacion.nombre);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

}