import 'package:flutter/material.dart';
import 'package:alerta_app/src/utils/data.dart';
import 'package:alerta_app/src/bloc/provider.dart';
import 'package:alerta_app/src/bloc/recuperar_bloc.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:alerta_app/src/utils/utils.dart';
class RecuperarPage extends StatelessWidget {
  final UsuarioProvider usuarioProvider=new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Recuperar Contraseña'),
      ),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _recuperarForm(context)
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
Widget _recuperarForm(BuildContext context){
  final bloc =Provider.ofRecuperar(context);
    final size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height*0.23,
            ), 
          ),
          Container(
            width: size.width*0.85,
            decoration:BoxDecoration(
              boxShadow: [new BoxShadow(
                color: Colors.black,
                blurRadius: 20.0,
              ),],
              color: Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(40.0))
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height*0.03),
                  _crearTexto(context),
                  _crearCUI(context,bloc),
                  SizedBox(height: 15.0,),
                  _crearRecuperar(context,bloc),
                  SizedBox(height: 30.0,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _crearCUI(BuildContext context,RecuperarBloc bloc){
    return StreamBuilder(
      stream: bloc.cuiStream,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: Colors.black26,
              labelText: 'CUI',
              hintText: '2000000000101',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0)
              ),
              errorText: snapshot.error
            ),
            onChanged: (value)=>bloc.changeCui(int.parse(value)),
          ),
        );
      },
    );
  }
   Widget _crearTexto(BuildContext context){
    return Center(
      child: Container(
        child: GestureDetector(
          child: Text('Ingresa CUI',style:TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(42,26,94,1.0),fontSize:20.0, )),
          onTap: (){
            Navigator.pushNamed(context,'recuperar');
          },
        )
      ),
    );
  }
  Widget _crearRecuperar(BuildContext context,RecuperarBloc bloc){
    final size=MediaQuery.of(context).size;
    
    return StreamBuilder(
    stream: bloc.formValidator,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return RaisedButton(
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Color.fromRGBO(244,89,5,1.0),
        child: Container(
          width:size.width*0.65,
          child: Center(
            child: Text('RECUPERAR CONTRASEÑA',style: TextStyle(color:Colors.white)),
          )
        ),
        onPressed: snapshot.hasData ? (){
          _recuperarContra(bloc,context);
        }:null,
      );    
    }
  );
  }
  _recuperarContra(RecuperarBloc bloc, BuildContext context) async{
  Map info= await usuarioProvider.recuperarContra(bloc.cui);
  if(info['codigo']==200){
    final Data data= new Data(contenido:info['mensaje']);
    Navigator.pushNamed(context, 'login',arguments:data);
  }else{
    mostrarAlerta(context,info['mensaje']);
  }
}
}