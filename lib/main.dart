import 'package:btc_project/ui/btc_funtion/btc_main.dart';
import 'package:btc_project/ui/pincode/pin_main.dart';
import 'package:btc_project/ui/reuse_file/generate_Pn.dart';
import 'package:btc_project/ui/reuse_file/generate_fibonacci.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TEST Neversitup',
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
      home: const MyHomePage(title: 'TEST Neversitup'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildGestureDetector(title: "PIN CODE" , callback: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PinMain()),
              );
            }),
            buildGestureDetector(title: "BTC" , callback: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BtcMain()),
              );
            }),
            buildGestureDetector(title: "จำนวนเฉพาะ" , callback: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GeneratePn()),
              );
            }),
            buildGestureDetector(title: "Fibonacci" , callback: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GenerateFibonacci()),
              );
            }),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  GestureDetector buildGestureDetector({String? title ,Function()? callback}) {
    return GestureDetector(
            onTap: (){
                callback?.call();
            },
            child: Container(
              margin: EdgeInsets.all(8),
              alignment: Alignment.center,
              height: 60,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.shade200,
              ),
              child: Text(title ?? '' ,style:  const TextStyle(fontSize: 16 ,color: Colors.black),),
            ),
          );
  }
}
