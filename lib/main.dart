import 'package:bibmovel/src/main/login.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BibMovel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'BibMovel Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      image: new Image.asset('lib/src/res/images/logo.png'),
      title: Text("BibMovel App",
        style: TextStyle(
            color: Colors.blue,
            fontSize: 30,
        ),
      ),
      photoSize: 120,
      backgroundColor: Colors.white,
      navigateAfterSeconds: new Login(),
    );
  }
}
