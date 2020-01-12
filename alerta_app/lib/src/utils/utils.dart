import 'package:flutter/material.dart';
import 'package:alerta_app/src/utils/data.dart';
mostrarAlerta(BuildContext context,String mensaje){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Info'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        ],
      );
    }
  );
}



mostrarAlerta2(BuildContext context,Data data){
  if(data!=null){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Info'),
          content: Text(data.contenido),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: ()=>Navigator.of(context).pop(),
            ),
          ],
        );
      }
    );
  }
}
