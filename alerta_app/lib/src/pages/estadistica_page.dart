import 'package:flutter/material.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
class EstadisticaPage extends StatefulWidget {
  @override
  _EstadisticaPageState createState() => _EstadisticaPageState();
}

class _EstadisticaPageState extends State<EstadisticaPage> {
  final UsuarioProvider usuarioProvider=new UsuarioProvider();

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  final GlobalKey<AnimatedCircularChartState> _chartKey2 = new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Estadisticas'),
      ),
      drawer: MenuWidget(),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _crearFondo(context),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: FutureBuilder(
                      future: usuarioProvider.getEstadistica(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return _crearEstadisticas(context,snapshot.data["data"]);
                        }else{
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  /*Container(
                    child: FutureBuilder(
                      future: usuarioProvider.getEstadistica2(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return _crearEstadisticas2(context,snapshot.data["data"]);
                        }else{
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),*/
                ],
              ),
            ),
          ),
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

Widget _crearEstadisticas(BuildContext context,List datos){
    Map<String,dynamic> lista=datos[0];
    //alertas
    double medica=double.parse(lista['eventos']??'0');
    double asalto=double.parse(lista['alertas']??'0');
    double panico=double.parse(lista['botonpanico']??'0');
    final size=MediaQuery.of(context).size;
    return Column(
        children: <Widget>[
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
                  SizedBox(height: 10.0,),
                  Text('Reporte Alertas',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15.0,fontWeight: FontWeight.bold)),
                  _crearChartAlerta(medica,asalto),
                  _crearDatosAlerta(medica,asalto),
                  //_crearChartEvento(academico,educativo,informativo,seguridad,cultural,social,deportivo,recreativo),
                  //_crearDatosEvento(academico,educativo,informativo,seguridad,cultural,social,deportivo,recreativo),
                  SizedBox(height: 20.0,)
                ],
              ),
            ),
          ),
          SizedBox(height: size.height*0.05,),
          _crearPanico(panico),
          SizedBox(height: size.height*0.05,)
        ],
      );
  }
  
  
Widget _crearEstadisticas2(BuildContext context,List datos){
    Map<String,dynamic> lista=datos[0];
    double academico=double.parse(lista['academico']??'0');
    double educativo=double.parse(lista['educativo']??'0');
    double informativo=double.parse(lista['informativo']??'0');
    double seguridad=double.parse(lista['seguridad']??'0');
    double cultural=double.parse(lista['cultural']??'0');
    double social=double.parse(lista['social']??'0');
    double recreativo=double.parse(lista['recreativo']??'0');
    double deportivo=double.parse(lista['deportivo']??'0');
    final size=MediaQuery.of(context).size;
    return Column(
        children: <Widget>[
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
                  SizedBox(height: 10.0,),
                  Text('Reporte Eventos',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15.0,fontWeight: FontWeight.bold)),
                  _crearChartEvento(academico,educativo,informativo,seguridad,cultural,social,deportivo,recreativo),
                  _crearDatosEvento(academico,educativo,informativo,seguridad,cultural,social,deportivo,recreativo),
                  SizedBox(height: 20.0,)
                ],
              ),
            ),
          ),
        ],
      );
  }
  Widget _crearChartAlerta(double medica,double asalto){
    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(medica, Colors.green, rankKey: 'Q1'),
          new CircularSegmentEntry(asalto, Colors.red, rankKey: 'Q2'),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];
    return Container(
      child: new AnimatedCircularChart(
        key: _chartKey,
        size: const Size(300.0, 300.0),
        initialChartData: data,
        chartType: CircularChartType.Pie,
      ),
    );
  }
  Widget _crearDatosAlerta(double medica,double asalto){
    return Column(
      children: <Widget>[
        _datos('Eventos: '+medica.toString(),Colors.green),
        _datos('Alertas: '+asalto.toString(),Colors.red),
      ],
    );
  }
  Widget _crearChartEvento(double academico,double educativo,double informativo,double seguridad,double cultural,double social,double deportivo,double recreativo){
    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(academico, Colors.green, rankKey: 'Q1'),
          new CircularSegmentEntry(educativo, Colors.red, rankKey: 'Q2'),
          new CircularSegmentEntry(informativo, Colors.black, rankKey: 'Q3'),
          new CircularSegmentEntry(seguridad, Colors.blue, rankKey: 'Q4'),
          new CircularSegmentEntry(cultural, Colors.brown, rankKey: 'Q5'),
          new CircularSegmentEntry(social, Colors.yellow, rankKey: 'Q6'),
          new CircularSegmentEntry(deportivo, Colors.pink, rankKey: 'Q7'),
          new CircularSegmentEntry(recreativo, Colors.grey, rankKey: 'Q8'),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];
    return Container(
      child: new AnimatedCircularChart(
        key: _chartKey2,
        size: const Size(300.0, 300.0),
        initialChartData: data,
        chartType: CircularChartType.Pie,
      ),
    );
  }
  Widget _crearDatosEvento(double academico,double educativo,double informativo,double seguridad,double cultural,double social,double deportivo,double recreativo){
    return Column(
      children: <Widget>[
        _datos('Academico: '+academico.toString(),Colors.green),
        _datos('Educativo: '+educativo.toString(),Colors.red),
        _datos('Informativo: '+informativo.toString(),Colors.black),
        _datos('Seguridad: '+seguridad.toString(),Colors.blue),
        _datos('Cultural: '+cultural.toString(),Colors.brown),
        _datos('Social: '+social.toString(),Colors.yellow),
        _datos('Deportivo: '+deportivo.toString(),Colors.pink),
        _datos('Recreativo: '+recreativo.toString(),Colors.grey),
      ],
    );
  }
  Widget _datos(String titulo,Color color){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(height: 10,width: 10,color: color,),
        SizedBox(width: 10.0,),
        Text(titulo,style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15.0,fontWeight: FontWeight.bold)),
      ]
    );
  }
  Widget _crearPanico(double panico){
    final size=MediaQuery.of(context).size;
    return Container(
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
            SizedBox(height: 15.0,),
            Text('Alertas boton de panico',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 15.0,),
            Text(panico.toString(),style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 25.0),),
            SizedBox(height: 20.0,)
          ],
        ),
      ),
    );
  }
}