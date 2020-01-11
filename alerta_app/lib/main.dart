import 'package:flutter/material.dart';
import 'package:alerta_app/src/pages/ver_publicacion_page.dart';
import 'package:alerta_app/src/pages/editar_usuario_page.dart';
import 'package:alerta_app/src/pages/registro_page.dart';
import 'package:alerta_app/src/pages/info_page.dart';
import 'package:alerta_app/src/pages/login_page.dart';
import 'package:alerta_app/src/pages/recuperar_page.dart';
import 'package:alerta_app/src/pages/mapa_page.dart';
import 'package:alerta_app/src/pages/mis_publicaciones_page.dart';
import 'package:alerta_app/src/pages/perfil_page.dart';
import 'package:alerta_app/src/pages/publicaciones_page.dart';
import 'package:alerta_app/src/pages/usuarios_page.dart';
import 'package:alerta_app/src/bloc/provider.dart';
import 'package:alerta_app/src/pages/alerta_page.dart';
import 'package:alerta_app/src/pages/evento_page.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main()async{
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String _verificarSesion(){
    final prefs = new PreferenciasUsuario();
    if(prefs.cui==0)return 'login';
    return 'mapa';
  }
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);
    return Provider(
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en','US'),
          const Locale('es','ES'),
          const Locale.fromSubtags(languageCode: 'zh'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Alerta App',
        initialRoute: _verificarSesion(),
        routes: {
          'login': (BuildContext context) =>LoginPage(),
          'recuperar': (BuildContext context) =>RecuperarPage(),
          'mapa': (BuildContext context) =>MapaPage(),
          'info': (BuildContext context) =>InfoPage(),
          'registro': (BuildContext context) =>RegistroPage(),
          'editarusuario': (BuildContext context) =>EditarUsuarioPage(),
          'perfil': (BuildContext context) =>PerfilPage(),
          'mispublicaciones': (BuildContext context) =>MisPublicacionesPage(),
          'publicaciones': (BuildContext context) =>PublicacionesPage(),
          'usuarios': (BuildContext context) =>UsuariosPage(),
          'alerta': (BuildContext context) =>AlertaPage(),
          'evento': (BuildContext context) =>EventoPage(),
          'ver_publicacion': (BuildContext context) =>VerPublicacionPage(),
        },
        theme:ThemeData(
          primaryColor: Color.fromRGBO(42,26,94,1.0),
        ),
      ),
    ); 
  }
}