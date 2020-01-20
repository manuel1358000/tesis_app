import 'package:alerta_app/src/provider/publicacion_provider.dart';
import 'package:alerta_app/src/utils/data.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:alerta_app/src/models/publicacion_model.dart';
class EditarEventoPage extends StatefulWidget {
  @override
  _EditarEventoPageState createState() => _EditarEventoPageState();
  }

class _EditarEventoPageState extends State<EditarEventoPage> {
  String _fecha='';
  String _hora='';
  TextEditingController _inputFieldDateController=new TextEditingController();
  TextEditingController _inputFieldTimeController=new TextEditingController();
  String _opcionSeleccionada='Academico';
  List<String> _tipos=['Academico','Educativo','Informativo','Seguridad','Cultural','Social','Deportivo','Recreativo','Otro'];
  PublicacionModel publicacionmodel=new PublicacionModel();
  final _formKey = GlobalKey<FormState>();
  PublicacionProvider publicacionProvider=new PublicacionProvider();
  @override
  Widget build(BuildContext context) {   
    PublicacionModel publicacionData=ModalRoute.of(context).settings.arguments;   
    if(publicacionData!=null&&publicacionmodel.estado==true){
      publicacionmodel=publicacionData;
      publicacionmodel.estado=false;
      _opcionSeleccionada=_cadenaDropdown(publicacionmodel.subtipo);
      _fecha=_crearFecha();
      _inputFieldDateController=new TextEditingController(text:_fecha);
      _hora=_crearHora();
      _inputFieldTimeController=new TextEditingController(text: _hora);
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
          _crearFormulario(context)
        ],
      )
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
                  Text('Tipo de Evento',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize:20)),
                  SizedBox(height: 10.0,),
                  _crearTIPO(context),
                  SizedBox(height: 15.0,),
                  _crearFECHA(context),
                  SizedBox(height: 30.0),
                  _crearHORA(context),
                  SizedBox(height: 30.0),
                  _crearNOMBRE(context),
                  SizedBox(height: 20.0,),
                  _crearDESCRIPCION(context),
                  SizedBox(height: 30.0),
                  _crearIngreso(context),
                  SizedBox(height: 30.0,),
                ],
              ),
            ),
          )
        ],
      ),
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
   Widget _crearTIPO(BuildContext context){
    return Center(
      child: DropdownButton(
        value: _opcionSeleccionada,
        items: getOpcionesDropdown(),
        onChanged: (opt){
          setState((){
            publicacionmodel.subtipo=_valueDropdown(opt);
            _opcionSeleccionada=opt;
          });
        },
      ),
    );
  }
  Widget _crearFECHA(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: _inputFieldDateController,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          fillColor: Color.fromRGBO(42,26,94,1.0),
          labelText: 'Fecha Evento',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0),
          ),
        ),
        onChanged: (value)=>_fecha=value,
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }
  
  Widget _crearHORA(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _inputFieldTimeController,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          fillColor: Color.fromRGBO(42,26,94,1.0),
          labelText: 'Hora Evento',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0),
          )
        ),
        onChanged: (value)=>_hora=value,
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectHour(context);
        },
      ),
    );
  }
  Widget _crearNOMBRE(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: publicacionmodel.nombre,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          fillColor: Color.fromRGBO(42,26,94,1.0),
          labelText: 'Titulo Evento',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0),
          )
        ),
        onChanged: (value)=>publicacionmodel.nombre=value,
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
          labelText: 'Descripcion Evento',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0),
          ),
        ),
        onChanged: (value)=>publicacionmodel.descripcion=value,
      ),
    );
  }
  Widget _crearIngreso(BuildContext context){
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
            if(_fecha!=''&&_fecha!=''){
              _editarPublicacion(publicacionmodel,context);         
            }else{
              mostrarAlerta(context,'Ingrese una fecha/hora valida');
            }   
          }
        }:null,
    );
  }
  _editarPublicacion(PublicacionModel publicacion,BuildContext context) async{
    publicacionmodel.fechahora=_fecha+' '+_hora;
    Map info=await publicacionProvider.editarPublicacion(publicacion.nombre,publicacion.descripcion,publicacion.fechahora,publicacion.codpublicacion,publicacion.subtipo);
    if(info['codigo']==200){
      final Data data= new Data(contenido:'Los datos se actualizaron de manera correcta');
      Navigator.pushReplacementNamed(context,'mapa',arguments:data);
    }else{
      mostrarAlerta(context,info['mensaje']);
    }
  }
  _crearFecha(){
    String dateWithT = publicacionmodel.fechahora.substring(0,10) + publicacionmodel.fechahora.substring(10);
    DateTime dateTime = DateTime.parse(dateWithT);
    return dateTime.year.toString()+'-'+dateTime.month.toString()+'-'+dateTime.day.toString();
  }
  _crearHora(){
    String dateWithT = publicacionmodel.fechahora.substring(0,10) + publicacionmodel.fechahora.substring(10);
    DateTime dateTime = DateTime.parse(dateWithT);
    return dateTime.hour.toString()+':'+dateTime.minute.toString()+':'+dateTime.second.toString();
  }
  _selectDate(BuildContext context)async{
    DateTime picker=await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      locale: Locale('es','ES')
    );
    if(picker!=null){
      setState(() {
        var objetos=picker.toString().split(' ');
        _fecha=objetos[0];
        _inputFieldDateController.text=_fecha;        
      });
    }
  }
  _selectHour(BuildContext context)async{
    TimeOfDay picker=await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
    );
    if(picker!=null){
      setState(() {
        _hora=picker.format(context);
        _inputFieldTimeController.text=_hora;        
      });
    }
  }
  Widget _iconoDropdown(String tipo){
    switch(tipo){
      case "Academico": return Icon(Icons.local_library,color: Colors.green,);
      case "Educativo": return Icon(Icons.local_library,color:Colors.green);
      case "Informativo": return Icon(Icons.insert_comment,color:Colors.red);
      case "Seguridad": return Icon(Icons.security,color:Colors.red);
      case "Cultural": return Icon(Icons.sms,color:Colors.blue);
      case "Social": return Icon(Icons.sms,color:Colors.blue);
      case "Deportivo": return Icon(Icons.directions_bike,color:Colors.purple);
      case "Recreativo": return Icon(Icons.supervisor_account,color:Colors.purple);      
      default: return Icon(Icons.outlined_flag,color:Colors.yellow);
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
  int _valueDropdown(String tipo){
    print('tipo '+tipo);
    switch(tipo){
      case "Academico": return 7;
      case "Educativo": return 8;
      case "Informativo": return 9;
      case "Seguridad": return 10;
      case "Cultural": return 11;
      case "Social": return 12;
      case "Deportivo": return 13;
      case "Recreativo": return 14;      
      default: return 0;
    }
  }
  String _cadenaDropdown(int tipo){
    switch(tipo.toString()){
      case "7": return "Academico";
      case "8": return "Educativo";
      case "9": return "Informativo";
      case "10": return "Seguridad";
      case "11": return "Cultural";
      case "12": return "Social";
      case "13": return "Deportivo";
      case "14": return "Recreativo";
      default: return "Otro";
    }
  }
}