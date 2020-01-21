import 'package:flutter/material.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:alerta_app/src/utils/data.dart';
class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
      child: Drawer(
        child: Container(
          color: Colors.white,
          child:ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                child: DrawerHeader(
                  child: Container(),
                  decoration: BoxDecoration(
                  image:DecorationImage(
                    image: AssetImage('assets/menu2.jpg'),
                    fit: BoxFit.cover,
                  )
                ),
              ),
            ),
            _itemPerfil(prefs.tipo,context)
          ],
        ),
        ), 
      ),
    ); 
  }
   Widget _itemPerfil(int perfil,BuildContext context){
     final prefs = new PreferenciasUsuario();
    //perfil 1 es usuario normal
    //perfil 2 es usuario administrador
    //perfil 3 es usuario invitado
    if(perfil==1){
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              //padding: EdgeInsets.symmetric(horizontal: 20.0),
              //alignment: new FractionalOffset(0.0,1.0),
              child: Text(prefs.nombre,style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontWeight: FontWeight.bold,fontSize: 15.0)),           
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Mi perfil',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'perfil');
              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Mis publicaciones',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'mispublicaciones');
              },
            ), 
            ListTile(
              leading: Icon(Icons.map,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Mapa',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'mapa');
              },
            ),
            ListTile(
              leading: Icon(Icons.call,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Numeros emergencia',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'emergencia');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.close,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Cerrar Sesion',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                prefs.token='';
                prefs.cui=0;
                prefs.password='';
                prefs.tipo=0;
                //Navigator.pop(context);
                final Data data= new Data(contenido:'Sesion Cerrrada con exito');
                Navigator.pushReplacementNamed(context,'login',arguments: data);
              },
            ),
          ],
        ),
      );
    }else if(perfil==2){
      return Container(
        child: Column(
          children: <Widget>[
            Text('Usuario ADMINISTRADOR'),
            ListTile(
              leading: Icon(Icons.person,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Mi perfil',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'perfil');
              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Mis publicaciones',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'mispublicaciones');
              },
            ), 
            ListTile(
              leading: Icon(Icons.format_list_bulleted,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Publicaciones',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'publicaciones');
              },
            ),
            ListTile(
              leading: Icon(Icons.map,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Mapa',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'mapa');
              },
            ),
            ListTile(
              leading: Icon(Icons.call,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Numeros emergencia',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'emergencia');
              },
            ),
            ListTile(
              leading: Icon(Icons.donut_small,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Estadisticas',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'estadistica');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.close,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Cerrar sesion',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                //Navigator.pop(context);
                prefs.token='';
                prefs.cui=0;
                prefs.password='';
                prefs.tipo=0;
                final Data data= new Data(contenido:'Sesion Cerrrada con exito');
                Navigator.pushReplacementNamed(context,'login',arguments: data);
              },
            ),
          ],
        ),
      );
    }else{
      return Container(
        child: Column(
          children: <Widget>[
            Text('Usuario INVITADO'),
            ListTile(
              leading: Icon(Icons.map,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Mapa',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'mapa');
              },
            ),
            ListTile(
              leading: Icon(Icons.call,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Numeros emergencia',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'emergencia');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.close,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('Cerrar Sesion',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                prefs.token='';
                prefs.cui=0;
                prefs.password='';
                prefs.tipo=0;
                //Navigator.pop(context);
                final Data data= new Data(contenido:'Sesion Cerrrada con exito');
                Navigator.pushReplacementNamed(context,'login',arguments: data);
              },
            ),
          ],
        ),
      );
    }
  }
}