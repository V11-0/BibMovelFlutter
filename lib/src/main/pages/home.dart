import 'package:bibmovel/src/main/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
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
