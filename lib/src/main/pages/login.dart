import 'package:bibmovel/src/main/utils/AppLocalizations.dart';
import 'package:bibmovel/src/main/values/internals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFF1E3188)));

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF267B7F), Color(0xFF1E3188)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 42.0),
                  child: SizedBox(child: Image.asset(pathImages + 'logo.png'), width: 240.0, height: 240.0),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).translate('Email'),
                            fillColor: Colors.white.withOpacity(0.5),
                            filled: true,
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(100.0),
                              ),
                            )),
                      ),
                      Divider(color: Colors.black.withOpacity(0), height: 25.0),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).translate('Password'),
                            fillColor: Colors.white.withOpacity(0.5),
                            filled: true,
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(100.0),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, right: 6.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(AppLocalizations.of(context).translate('ForgotPassword'),
                          style: TextStyle(color: Colors.blue[400], decoration: TextDecoration.underline))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 54.0),
                  child: Center(
                    child: RaisedButton(
                      child: Text(AppLocalizations.of(context).translate('LogIn')),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)),
                      onPressed: () {},
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 142.0),
                      child: Text(AppLocalizations.of(context).translate('DontHaveAnAccount'),
                          style:
                              TextStyle(color: Colors.blue[400], decoration: TextDecoration.underline, fontSize: 18.0)),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
