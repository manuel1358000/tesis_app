import 'package:flutter/material.dart';
import 'package:alerta_app/src/models/publicacion_model.dart';

class PublicacionVertical extends StatelessWidget {
  PublicacionVertical({@required this.publicaciones});
  final List<PublicacionModel> publicaciones;

  @override
  Widget build(BuildContext context) {
    final _size=MediaQuery.of(context).size;
    return Container(
      height: _size.height*0.8,
      width: _size.width,
      child: PageView(
        controller: PageController(
          initialPage: 1,
          viewportFraction:0.60
        ),
        children: _tarjetas(context),
        scrollDirection: Axis.vertical,
      )
    );
  }
  List<Widget> _tarjetas(BuildContext context){
    final _size=MediaQuery.of(context).size;
    return publicaciones.map((pelicula){ 
      String dateWithT = pelicula.fechahora.substring(0,10) + pelicula.fechahora.substring(10);
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
                    ListTile(
                      leading: Icon(Icons.adjust, size: 70),
                      title: Text('Fecha: '+dateTime.day.toString()+'-'+dateTime.month.toString()+'-'+dateTime.year.toString(), style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 12)),
                      subtitle: Text('Hora: '+dateTime.hour.toString()+':'+dateTime.minute.toString(),style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15,)),  
                    ),
                    SizedBox(height: 15.0,),
                    Text('Tipo',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14,fontWeight: FontWeight.bold)),
                    Text((pelicula.tipo==1?"Alerta":"Evento"),style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14)),
                    SizedBox(height: 15.0,),
                    Text('Titulo',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14,fontWeight: FontWeight.bold)),
                    Text(pelicula.nombre,style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15)),
                    Divider(),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: const Text('Ver', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
                            onPressed: () {},
                          ),
                          FlatButton(
                            child: const Text('Editar', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
                            onPressed: () {},
                          ),
                          FlatButton(
                            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                            onPressed: () {},
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