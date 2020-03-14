import 'dart:ui';

import 'package:bibmovel/src/main/pages/home.dart';
import 'package:bibmovel/src/main/values/internals.dart';
import 'package:bibmovel/src/main/values/strings.dart';

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF40CED5), const Color(0xFF3252E3)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: Image.asset(pathImages + 'logo.png')
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: usuario,
                    labelText: nome,
                  ),
                  validator: (String value) {
                    if (value.isEmpty) return naoDeveEstarVazio;

                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: senha,
                    labelText: senha,
                  ),
                  validator: (String value) {
                    if (value.isEmpty) return naoDeveEstarVazio;

                    return null;
                  },
                ),
              ],
            ),
            RaisedButton(
              onPressed: () {
                SnackBar snackBar = SnackBar(
                    content: Row(
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text("Entrando"),
                        )
                      ],
                    ));
                Scaffold.of(context).showSnackBar(snackBar);
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Principal()),
                          (Route<dynamic> route) => false);
                });
              },
              child: Text(login),
            ),
          ],
        ),
      ),
    ));
  }
}
