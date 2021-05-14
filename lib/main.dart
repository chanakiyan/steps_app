import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:decimal/decimal.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String muestrePasos = "";
  String _km = "Unknown";
  String _calories = "Unknown";

  String _stepCountValue = 'Unknown';
  StreamSubscription<int> _subscription;

  double _numerox; //number of steps
  double _convert;
  double _kmx;
  double burnedx;
  double _porciento;
  // double percent=0.1;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    setUpPedometer();
  }

  //start pedometer code
  void setUpPedometer() {
    Pedometer pedometer = new Pedometer();
    _subscription = pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(int stepCountValue) async {
    // print(stepCountValue); //printing number of steps per console
    setState(() {
      _stepCountValue = "$stepCountValue";
      // print(_stepCountValue);
    });

    var dist = stepCountValue; //we pass the integer to a variable called dist
    double y = (dist + .0); //we convert it to double a form of several

    setState(() {
      _numerox =
          y; //we pass it to a state to be captured and converted to double
    });

    var long3 = (_numerox);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    print("d: $d");

    getDistanceRun(_numerox);

    setState(() {
      _convert = d;
      print(_convert);
    });
  }

  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  void _onDone() {}

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  //function to determine the distance run in kilometers using number of steps
  void getDistanceRun(double _numerox) {
    var distance = ((_numerox * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2)); //two decimal places
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = "$distance";
      //print(_km);
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  //function to determine the calories burned in kilometers using number of steps
  void getBurnedRun() {
    setState(() {
      var calories = _kmx; //dos decimales
      _calories = "$calories";
      //print(_calories);
    });
  }

  //end code pedometer

  @override
  Widget build(BuildContext context) {
    //print(_stepCountValue);
    getBurnedRun();
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Step Counter app'),
          backgroundColor: Colors.black54,
        ),
        body: new ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            Container(
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(
                      FontAwesomeIcons.walking,
                      size: 30.0,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    //color: Colors.orange,
                    child: Text(
                      '$_stepCountValue',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.purpleAccent),
                    ),
                    // height: 50.0,
                    // width: 50.0,
                  ),
                ],
              ),
            ),
            Divider(
              height: 5.0,
            ),
            Container(
              width: 80,
              height: 100,
              padding: EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10.0),
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  new Container(
                    child: new Card(
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                        /*decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/distance.png"),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),*/
                        child: Text(
                          "$_km Km",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0),
                        ),
                      ),
                      color: Colors.white54,
                    ),
                  ),
                  VerticalDivider(
                    width: 20.0,
                  ),
                  new Container(
                    child: new Card(
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                       /* decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/burned.png"),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),*/
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                  VerticalDivider(
                    width: 20.0,
                  ),
                  new Container(
                    child: new Card(
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                       /* decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/step.png"),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),*/
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              padding: EdgeInsets.only(top: 2.0),
              width: 150, //width
              height: 30, //length also by number height: 300
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(left: 40.0),
                    child: new Card(
                      child: Container(
                        child: Text(
                          "$_km Km",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white),
                        ),
                      ),
                      color: Colors.purple,
                    ),
                  ),
                  VerticalDivider(
                    width: 20.0,
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: new Card(
                      child: Container(
                        child: Text(
                          "$_calories kCal",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white),
                        ),
                      ),
                      color: Colors.red,
                    ),
                  ),
                  VerticalDivider(
                    width: 5.0,
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: new Card(
                      child: Container(
                        child: Text(
                          "$_stepCountValue Steps",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white),
                        ),
                      ),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
