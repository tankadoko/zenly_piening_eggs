import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late List<double> _accelerometerValues;
  late List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];

    @override
  Widget build(BuildContext context) {
    final List<String> accelerometer = _accelerometerValues.map((double v) => v.toStringAsFixed(1)).toList();
    final double accel_x = _accelerometerValues[0];
    final String accel_y = _accelerometerValues[1].toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Material(
            color: Colors.yellow[100],
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: FlutterLogo(
                size: 72.0,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Text('Accelerometer: $accelerometer',),
              Text('ACCEL_X: $accel_x'),
              Text("ACCEL_Y: $accel_y"),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
      .add(accelerometerEvents.listen((AccelerometerEvent event) {
        setState(() {
          _accelerometerValues = <double>[event.x, event.y, event.z];
        });
    }));
  }

}
