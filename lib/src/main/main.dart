import 'package:bibmovel/src/main/values/internals.dart';
import 'package:bibmovel/src/main/values/strings.dart';
import 'package:flutter/material.dart';

void main() => runApp(
    MaterialApp(
      title: bibmovel,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home: BibMovel(),
    )
);

class BibMovel extends StatefulWidget {
  @override
  _BibMovelState createState() => _BibMovelState();
}

class _BibMovelState extends State<BibMovel> {

  var _imageAlignment = Alignment.centerLeft;
  var _imageOpacity = 0.0;
  var _barVisible = false;

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
                  height: 4,
                  width: MediaQuery.of(context).size.width,
                  child: Visibility(
                    child: LinearProgressIndicator(),
                    visible: _barVisible,
                  )
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _imageAlignment = Alignment.center;
        _imageOpacity = 1.0;
        _barVisible = true;
      });
    });
  }
}
