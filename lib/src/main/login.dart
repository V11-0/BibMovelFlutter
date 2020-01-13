import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Usuario',
                  labelText: 'Nome',
                ),
                validator: (String value) {
                  if (value.isEmpty)
                    return "Não deve estar vazio";

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Senha',
                  labelText: 'Senha',
                ),
                validator: (String value) {
                  if (value.isEmpty)
                    return "Não deve estar vazio";

                  return null;
                },
              ),
              RaisedButton(
                onPressed: () {
                  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
                  Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Text("Login"),
              ),
            ],
          );
        }
      )
    );
  }
}
