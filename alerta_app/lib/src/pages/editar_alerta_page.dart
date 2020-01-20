import 'package:alerta_app/src/provider/publicacion_provider.dart';
import 'package:alerta_app/src/utils/data.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:alerta_app/src/models/publicacion_model.dart';
class EditarAlertaPage extends StatefulWidget {
  @override
  _EditarAlertaPageState createState() => _EditarAlertaPageState();
  }

class _EditarAlertaPageState extends State<EditarAlertaPage> {
  PublicacionModel publicacionmodel=new PublicacionModel();
  PublicacionProvider publicacionProvider=new PublicacionProvider();
  final _formKey = GlobalKey<FormState>();
  String _opcionSeleccionada='Emergencia Medica';
  List<String> _tipos=['Emergencia Medica','Accidente Vehicular','Asalto','Robo Vehiculo','Incendio','Bloqueo','Otro'];
  @override
  Widget build(BuildContext context) {
    PublicacionModel publicacionData=ModalRoute.of(context).settings.arguments;   
    if(publicacionData!=null&&publicacionmodel.estado==true){
      publicacionmodel=publicacionData;
      publicacionmodel.estado=false;
      _opcionSeleccionada=_cadenaDropdown(publicacionmodel.subtipo);
    }
    return Scaffold(
       appBar:PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height 
        child: AppBar(
          backgroundColor: Color.fromRGBO(244,89,5,1.0),
          title: Text('AlertaUSAC'),
          centerTitle: true,
          elevation: 5.0,
        ),
      ),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearFormulario(context),
        ],
      )
    );
  }
  Widget _crearFondo(BuildContext context){
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(42,26,94,1.0)
      ),
    );
  }
  Widget _crearFormulario(BuildContext context){
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
                blurRadius: 25.0,
              ),],
              color: Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(40.0))
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25.0,),
                  _crearTexto(context),
                  SizedBox(height: 10.0,),
                  _crearTIPO(context),
                  SizedBox(height: 15.0,),
                  _crearNOMBRE(context),
                  SizedBox(height: 25.0,),
                  _crearDESCRIPCION(context),
                  SizedBox(height: 30.0),
                  _crearEditar(context),
                  SizedBox(height: 30.0,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _crearTexto(BuildContext context){
    return Center(
      child:Text('Actualizar Alerta',style:TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(42,26,94,1.0),fontSize:20.0, )),
    );
  }
  Widget _crearTIPO(BuildContext context){
    return Center(
      child: DropdownButton(
        value: _opcionSeleccionada,
        items: getOpcionesDropdown(),
        onChanged: (opt){
          setState((){
            _opcionSeleccionada=opt;
            publicacionmodel.subtipo=_valueDropdown(opt);
          });
        },
      ),
    );
  }
   Widget _crearNOMBRE(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue:publicacionmodel.nombre,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          fillColor: Color.fromRGBO(42,26,94,1.0),
          labelText: 'Titulo Alerta',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0),
          ),
        ),
        onChanged: (value)=>publicacionmodel.nombre=value,
        validator: (value) {
          if (value.isEmpty) {
            return 'Ingrese un nombre valido';
          }
          return null;
        },
      ),
    );
  }
  Widget _crearDESCRIPCION(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: publicacionmodel.descripcion,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          fillColor: Color.fromRGBO(42,26,94,1.0),
          labelText: 'Descripcion Alerta',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0),
          ),
        ),
        onChanged: (value)=>publicacionmodel.descripcion=value,
        validator: (value) {
          if (value.isEmpty) {
            return 'Ingrese una descripcion';
          }
          return null;
        },
      ),
    );
  }
  Widget _crearEditar(BuildContext context){
    final size=MediaQuery.of(context).size;
    return RaisedButton(
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Color.fromRGBO(244,89,5,1.0),
      child: Container(
        width:size.width*0.65,
        child: Center(
          child: Text('Publicar',style: TextStyle(color:Colors.white)),
        )
      ),
      onPressed: publicacionmodel!=null ? (){
          if(_formKey.currentState.validate()){
            _editarAlerta(publicacionmodel,context);
          }
        }:null,
    );
  }

  _editarAlerta(PublicacionModel publicacion,BuildContext context) async{
    Map info=await publicacionProvider.editarPublicacion(publicacion.nombre,publicacion.descripcion,publicacion.fechahora,publicacion.codpublicacion,publicacion.subtipo);
    if(info['codigo']==200){
      final Data data= new Data(contenido:'Los datos se actualizaron de manera correcta');
      Navigator.pushReplacementNamed(context,'mapa',arguments:data);
    }else{
      mostrarAlerta(context,info['mensaje']);
    }
  }
  List<DropdownMenuItem<String>> getOpcionesDropdown(){  
    List<DropdownMenuItem<String>> lista=new List();
    _tipos.forEach((tipo){
      lista.add(DropdownMenuItem(
        child: Row(
          children: <Widget>[
            _iconoDropdown(tipo),
            SizedBox(width: 10.0,),
            Text(tipo,style:TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
          ],
        ),
        value: tipo,
      ));
    });
    return lista;
  }
  Widget _iconoDropdown(String tipo){
    switch(tipo){
      case "Emergencia Medica": return Icon(Icons.local_hospital,color: Colors.red,);
      case "Asalto": return Icon(Icons.directions_run,color:Colors.blue );
      case "Robo Vehiculo": return Icon(Icons.directions_run,color:Colors.blue,);
      case "Accidente Vehicular": return Icon(Icons.local_hospital,color:Colors.red);
      case "Bloqueo": return Icon(Icons.block,color:Colors.green);
      case "Incendio": return Icon(Icons.priority_high,color:Colors.green);
      default: return Icon(Icons.outlined_flag,color:Colors.yellow);
    }
  }
  int _valueDropdown(String tipo){
    switch(tipo){
      case "Emergencia Medica": return 1;
      case "Accidente Vehicular": return 2;
      case "Asalto": return 3;
      case "Robo Vehiculo": return 4;
      case "Bloqueo": return 5;
      case "Incendio": return 6;
      default: return 0;
    }
  }
  String _cadenaDropdown(int tipo){
    switch(tipo.toString()){
      case "1": return "Emergencia Medica";
      case "2": return "Accidente Vehicular";
      case "3": return "Asalto";
      case "4": return "Robo Vehiculo";
      case "5": return "Bloqueo";
      case "6": return "Incendio";
      default: return "Otro";
    }
  }
}
