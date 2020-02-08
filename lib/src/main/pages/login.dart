import 'package:bibmovel/src/main/pages/principal.dart';
import 'package:bibmovel/src/main/values/strings.dart';

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(login),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: usuario,
                  labelText: nome,
                ),
                validator: (String value) {
                  if (value.isEmpty)
                    return naoDeveEstarVazio;

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
                  if (value.isEmpty)
                    return naoDeveEstarVazio;

                  return null;
                },
              ),
              RaisedButton(
                onPressed: () {
                  final snackBar = SnackBar(
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
          );
        }
      )
    );
  }
}
