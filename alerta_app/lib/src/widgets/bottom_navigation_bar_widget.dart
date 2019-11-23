import 'package:flutter/material.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
class BottomNavigationBarWidget extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  int currendIndex=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index){
        if(index==0&&prefs.tipo==1){
          currendIndex=0;
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context,'mispublicaciones');
        }
        if(index==1&&prefs.tipo==1){
          currendIndex=1;
          prefs.token='';
          prefs.cui=0;
          prefs.password='';
          prefs.tipo=0;
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context,'login');
        }
        if(index==0&&prefs.tipo==2){
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context,'publicaciones');
        }
        if(index==1&&prefs.tipo==2){
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context,'usuarios');
        }
        if(index==0&&prefs.tipo==3){
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context,'mapa');
        }
        if(index==1&&prefs.tipo==1){
          prefs.token='';
          prefs.cui=0;
          prefs.password='';
          prefs.tipo=0;
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context,'login');
        }
      },
      //tiene que ser mas de un item
      items: generarItems(),
    ); 
  }
  List<BottomNavigationBarItem> generarItems(){
    if (prefs.tipo==1){
      //normal
      return [
        BottomNavigationBarItem(
          icon:Icon(Icons.add_to_photos),
          title: Text('MIS PUBLICACIONES'),
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.supervised_user_circle),
          title: Text('CERRAR SESION'),
        ),
      ];
    }
    
    if(prefs.tipo==2){
      return [
        BottomNavigationBarItem(
          icon:Icon(Icons.add_to_photos),
          title: Text('PUBLICACIONES'),
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.supervised_user_circle),
          title: Text('USUARIOS'),
        ),
      ];
    }
    return [
      BottomNavigationBarItem(
        icon:Icon(Icons.map),
        title: Text('MAPA'),
      ),
      BottomNavigationBarItem(
        icon:Icon(Icons.close),
        title: Text('CERRAR SESION'),
      ),
    ];
  }

}