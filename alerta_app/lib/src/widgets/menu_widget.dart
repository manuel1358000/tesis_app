import 'package:flutter/material.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
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
              title: Text('MI PERFIL',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0))),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'perfil');
              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MIS PUBLICACIONES',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'mispublicaciones');
              },
            ), 
            ListTile(
              leading: Icon(Icons.map,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MAPA',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'mapa');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.close,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('CERRAR SESION',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                prefs.token='';
                prefs.cui=0;
                prefs.password='';
                prefs.tipo=0;
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'login');
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
              title: Text('MI PERFIL',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'perfil');
              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MIS PUBLICACIONES',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'mispublicaciones');
              },
            ), 
            ListTile(
              leading: Icon(Icons.format_list_bulleted,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('PUBLICACIONES',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'publicaciones');
              },
            ),
            ListTile(
              leading: Icon(Icons.group,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('USUARIOS',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'usuarios');
              },
            ),
            ListTile(
              leading: Icon(Icons.map,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('MAPA',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'mapa');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.close,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('CERRAR SESION',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                prefs.token='';
                prefs.cui=0;
                prefs.password='';
                prefs.tipo=0;
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'login');
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
              title: Text('MAPA',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                Navigator.pushReplacementNamed(context,'mapa');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.close,color:Color.fromRGBO(42,26,94,1.0)),
              title: Text('CERRAR SESION',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0)),),
              onTap: (){
                prefs.token='';
                prefs.cui=0;
                prefs.password='';
                prefs.tipo=0;
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'login');
              },
            ),
          ],
        ),
      );
    }
  }
}