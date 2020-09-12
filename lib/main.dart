import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/screens/home/home.dart';
import 'src/screens/intro/intro.dart';
import 'src/screens/login/login.dart';
import 'src/utils/app_localizations.dart';
import 'src/values/internals.dart';
import 'src/values/strings.dart';

void main() => runApp(MaterialApp(
      title: bibmovel,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: BibMovel(),
    ));

class BibMovel extends StatefulWidget {
  @override
  _BibMovelState createState() => _BibMovelState();
}

class _BibMovelState extends State<BibMovel> {
  Alignment _imageAlignment = Alignment.centerLeft;
  double _imageOpacity = 0.0;
  bool _barVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  child: AnimatedOpacity(
                    opacity: _imageOpacity,
                    duration: Duration(milliseconds: 500),
                    child: Image.asset(pathImages + "logo.png"),
                  ),
                  height: 150,
                ),
                alignment: _imageAlignment,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: SizedBox(
                    height: 4.0,
                    width: MediaQuery.of(context).size.width,
                    child: Visibility(
                      child: LinearProgressIndicator(),
                      visible: _barVisible,
                    )),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _imageAlignment = Alignment.center;
        _imageOpacity = 1.0;
        _barVisible = true;
      });

      Future.delayed(Duration(seconds: 2), verifyLogin);
    });
  }

  void verifyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int sessionId = prefs.getInt(prefsSessionId);
    bool hasShowIntro = prefs.getBool(prefsLoginShowedIntro);

    hasShowIntro ??= false;

    var route;

    if (sessionId != null) {
      route = new Home();
    } else if (hasShowIntro) {
      route = new Login();
    } else {
      route = new Intro();
    }

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => route), (route) => false);
  }
}
