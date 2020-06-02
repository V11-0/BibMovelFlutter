import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:bibmovel/src/main/values/strings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todosLivros),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Flutter"),
      ),
    );
  }
}
