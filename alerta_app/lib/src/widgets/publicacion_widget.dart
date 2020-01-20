import 'package:alerta_app/src/provider/publicacion_provider.dart';
import 'package:alerta_app/src/utils/data.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:alerta_app/src/models/publicacion_model.dart';

class PublicacionWidget extends StatefulWidget {
  final Function siguientePagina;
  String actual;
  final List<PublicacionModel> publicaciones;
  PublicacionWidget({@required this.publicaciones,@required this.siguientePagina,@required this.actual});
  
  @override
  _PublicacionWidgetState createState() => _PublicacionWidgetState();
}
class _PublicacionWidgetState extends State<PublicacionWidget> {
  PublicacionProvider publicacionProvider=new PublicacionProvider();

  final _prefs=new PreferenciasUsuario();

  Data data2;

  final _pageController=new PageController(
    initialPage: 1,
    viewportFraction: 0.60
  );
  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      mostrarAlerta2(context, data2);
      _prefs.peticionUsuario=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    final _size=MediaQuery.of(context).size;
    _pageController.addListener((){
      if(_pageController.position.pixels>_pageController.position.maxScrollExtent-100&&_pageController.position.pixels<_pageController.position.maxScrollExtent-90){
        widget.siguientePagina(_prefs.cui);
      }
    });

    return Container(
      height: _size.height,
      width: _size.width,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.publicaciones.length,
        itemBuilder: (context,i)=>_crearTarjetas(context,widget.publicaciones[i]),
        scrollDirection: Axis.vertical,
      )
    );
  }

 
  Widget _formarIcono(IconData icono,Color color,String texto){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icono,color:color),
          Text(texto,style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14)),
        ],
      );
  }

  Widget _crearTarjetas(BuildContext context, PublicacionModel publicacion){
    final _size=MediaQuery.of(context).size;
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
              color: publicacion.subtipo==15?Colors.red:Colors.white,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 5,
                    width: _size.width*0.90,
                    color: publicacion.tipo==1?Colors.red:Colors.green,
                    child: Text(''),
                  ),
                  SizedBox(height: 15.0,),
                  Text('Clase Publicacion',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14,fontWeight: FontWeight.bold)),
                  Text((publicacion.tipo==1?"Alerta":"Evento"),style: TextStyle(color: publicacion.subtipo==15?Colors.white:Color.fromRGBO(42,26,94,1.0),fontSize: 14)),
                  SizedBox(height: 10.0,),
                  Text('Tipo de Publicacion',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14,fontWeight: FontWeight.bold)),
                  _iconoDropdown(publicacion.subtipo),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Fecha: ', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 13,fontWeight: FontWeight.bold)),
                      Text(dateTime.day.toString()+'-'+dateTime.month.toString()+'-'+dateTime.year.toString(), style: TextStyle(color: publicacion.subtipo==15?Colors.white:Color.fromRGBO(42,26,94,1.0),fontSize: 13)),
                      SizedBox(width: 15.0,),
                      Text('Hora: ', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 13,fontWeight: FontWeight.bold)),
                      Text(dateTime.hour.toString()+':'+dateTime.minute.toString(),style: TextStyle(color: publicacion.subtipo==15?Colors.white:Color.fromRGBO(42,26,94,1.0),fontSize: 13,)),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Text('Titulo',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14,fontWeight: FontWeight.bold)),
                  Text(publicacion.nombre,style: TextStyle(color: publicacion.subtipo==15?Colors.white:Color.fromRGBO(42,26,94,1.0),fontSize: 15)),
                  SizedBox(height: 10.0,),
                  Text('Descripcion',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14,fontWeight: FontWeight.bold)),
                  Container(
                    child: Text(publicacion.descripcion, overflow: TextOverflow.ellipsis, style: TextStyle(color: publicacion.subtipo==15?Colors.white:Color.fromRGBO(42,26,94,1.0),fontSize: 15)),
                    margin: EdgeInsets.only(right: 20,left: 20),
                  ),
                  Divider(),
                  ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: const Text('Ver', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
                          onPressed: () {
                            Navigator.pushNamed(context,'ver_publicacion',arguments:publicacion);
                          },
                        ),
                        FlatButton(
                          child: const Text('Editar', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
                          onPressed: () {    
                          },
                        ),
                        FlatButton(
                          child: const Text('Eliminar', style: TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: new Text('Alerta'),
                                  content: new Text('¿Desea eliminar la publicacion?'),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("Aceptar"),
                                      onPressed: (){
                                        _eliminarPublicacion(context,publicacion.codpublicacion);
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Text("Cerrar"),
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                            );
                          },
                        ),
                      ],
                    ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _eliminarPublicacion(BuildContext context,int codPublicacion)async{
    print(codPublicacion);
    Map info = await publicacionProvider.eliminarPublicacion(codPublicacion);
    if(info['codigo']==200){
      final Data data= new Data(contenido:info['mensaje']);
      Navigator.pushNamed(context,widget.actual,arguments:data);
    }else{
      mostrarAlerta(context,info['mensaje']);
    }
  }
   Widget _iconoDropdown(int tipo){
    switch(tipo.toString()){
      case "1": return _formarIcono(Icons.local_hospital,Colors.red,"Emergencia Medica");
      case "2": return _formarIcono(Icons.directions_run,Colors.blue,"Asalto");
      case "3": return _formarIcono(Icons.directions_run,Colors.blue,"Robo Vehiculo");
      case "4": return _formarIcono(Icons.local_hospital,Colors.red,"Accidente Vehicular");
      case "5": return _formarIcono(Icons.block,Colors.green,"Bloqueo");
      case "6": return _formarIcono(Icons.priority_high,Colors.green,"Incendio");
      case "7": return _formarIcono(Icons.local_library,Colors.green,"Academico");
      case "8": return _formarIcono(Icons.local_library,Colors.green,"Educativo");
      case "9": return _formarIcono(Icons.insert_comment,Colors.red,"Informativo");
      case "10": return _formarIcono(Icons.security,Colors.red,"Seguridad");
      case "11": return _formarIcono(Icons.sms,Colors.blue,"Cultural");
      case "12": return _formarIcono(Icons.sms,Colors.blue,"Social");
      case "13": return _formarIcono(Icons.directions_bike,Colors.purple,"Deportipo");
      case "14": return _formarIcono(Icons.supervisor_account,Colors.purple,"Recreativo");
      case "15": return _formarIcono(Icons.security,Colors.white,"Boton de Panico");      
      default: return _formarIcono(Icons.outlined_flag,Colors.yellow,"");
    }
  }
}