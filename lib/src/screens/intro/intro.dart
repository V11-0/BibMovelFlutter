import 'package:flutter/material.dart';

import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bibmovel/src/screens/login/login.dart';
import 'package:bibmovel/src/values/internals.dart';

class Intro extends StatelessWidget {
  // TODO: Internacionalizar
  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      [
        PageViewModel(
          pageColor: const Color(0xFF607D8B),
          iconColor: null,
          bubbleBackgroundColor: Colors.green,
          title: Text('Esse é o meu aplicativo feito em Flutter'),
          body: Text('BibMóvel'),
          mainImage: null,
        ),
        PageViewModel(
          pageColor: Colors.blue,
          bubbleBackgroundColor: Colors.pink,
          title: Text("O BibMóvel irá te ajudar a baixar livros"),
          body: Text("Eles ficam armazenados no seu servidor pessoal"),
          mainImage: null,
        ),
        PageViewModel(
          pageColor: Colors.red,
          bubbleBackgroundColor: Colors.amber,
          title: Text("Obrigado por baixar o Aplicativo"),
          body: Text("Espero que goste :)"),
          mainImage: null,
        ),
      ],
      onTapDoneButton: () => registerIntro(context),
    );
  }

  void registerIntro(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefsLoginShowedIntro, true);

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
