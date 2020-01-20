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
    double alertas=double.parse(lista['alertas']);
    double eventos=double.parse(lista['eventos']);
    double panico=double.parse(lista['botonpanico']);
    final size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
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
                  Text('Numero de publicaciones',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15.0,fontWeight: FontWeight.bold)),
                  _crearChart(eventos,alertas),
                  _crearDatos(eventos,alertas),
                  SizedBox(height: 20.0,)
                ],
              ),
            ),
          ),
          SizedBox(height: size.height*0.05,),
          _crearPanico(panico)
        ],
      ),
    );
  }

  Widget _crearDatos(double eventos,double alertas){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 10,width: 10,color: Colors.green,),
            SizedBox(width: 10.0,),
            Text('Eventos: '+eventos.toString(),style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15.0,fontWeight: FontWeight.bold)),
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 10,width: 10,color: Colors.red,),
            SizedBox(width: 10.0,),
            Text('Alertas: '+alertas.toString(),style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 15.0,fontWeight: FontWeight.bold)),
          ]
        )
      ],
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
  Widget _crearChart(double eventos,double alertas){
    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(eventos, Colors.red, rankKey: 'Q1'),
          new CircularSegmentEntry(alertas, Colors.green, rankKey: 'Q2'),
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
}