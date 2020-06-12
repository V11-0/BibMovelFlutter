import 'dart:convert';

import 'package:bibmovel/src/main/models/usuario.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:bibmovel/src/main/utils/AppLocalizations.dart';
import 'package:bibmovel/src/main/values/internals.dart';
import 'package:validators/validators.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey<FormState> _cadastroFormKey;

  String _emailLogin;
  String _passLogin;

  String _userCadastro;
  String _emailCadastro;
  String _senhaCadastro;
  String _confirmaSenhaCadastro;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFF1E3188)));

    FocusNode emailFocus = new FocusNode();
    FocusNode passwordFocus = new FocusNode();

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
                        focusNode: emailFocus,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).translate('Email'),
                            fillColor: Colors.white.withOpacity(0.5),
                            filled: true,
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(100.0),
                              ),
                            )),
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, emailFocus, passwordFocus);
                        },
                        onSaved: (value) => _emailLogin = value,
                      ),
                      Divider(color: Colors.black.withOpacity(0), height: 25.0),
                      TextFormField(
                        focusNode: passwordFocus,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).translate('Password'),
                            fillColor: Colors.white.withOpacity(0.5),
                            filled: true,
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(100.0),
                              ),
                            )),
                        onFieldSubmitted: (term) {
                          // TODO LOGIN
                        },
                        onSaved: (value) => _passLogin = value,
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
                      child: GestureDetector(
                        child: Text(AppLocalizations.of(context).translate('DontHaveAnAccount'),
                            style: TextStyle(
                                color: Colors.blue[400], decoration: TextDecoration.underline, fontSize: 18.0)),
                        onTap: () {
                          showDialog(context: context, builder: _createSignInDialog());
                        },
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  WidgetBuilder _createSignInDialog() {
    _cadastroFormKey = new GlobalKey<FormState>();

    FocusNode userFocus = new FocusNode();
    FocusNode emailFocus = new FocusNode();
    FocusNode passFocus = new FocusNode();
    FocusNode confirmPassFocus = new FocusNode();

    var builder = (BuildContext context) {
      return AlertDialog(
        title: Text('Criar uma conta'),
        content: Form(
          key: _cadastroFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                    textInputAction: TextInputAction.next,
                    maxLength: 49,
                    focusNode: userFocus,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('User'),
                        border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                          const Radius.circular(100.0),
                        ))),
                    validator: (value) {
                      if (value.isEmpty) return 'Não pode estar vazio';

                      return null;
                    },
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(context, userFocus, emailFocus);
                    },
                    onSaved: (value) => _userCadastro = value,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      focusNode: emailFocus,
                      maxLength: 128,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).translate('Email'),
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                            const Radius.circular(100.0),
                          ))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Não pode estar vazio';
                        } else if (!isEmail(value)) {
                          return 'Digite um Email Válido';
                        }

                        return null;
                      },
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, emailFocus, passFocus);
                      },
                      onSaved: (value) => _emailCadastro = value,
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  focusNode: passFocus,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).translate('Password'),
                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                        const Radius.circular(100.0),
                      ))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Não pode estar vazio';
                    }

                    return null;
                  },
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, passFocus, confirmPassFocus);
                  },
                  onSaved: (value) {
                    var bytes = utf8.encode(value);
                    _senhaCadastro = sha512.convert(bytes).bytes.toString();
                  }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                      textInputAction: TextInputAction.go,
                      focusNode: confirmPassFocus,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).translate('ConfirmPassword'),
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                            const Radius.circular(100.0),
                          ))),
                      validator: (value) {
                        if (value.isEmpty) return 'Não pode estar vazio';

                        return null;
                      },
                      onFieldSubmitted: (term) {
                        _verificarCadastroForm();
                      },
                      onSaved: (value) {
                        var bytes = utf8.encode(value);
                        _confirmaSenhaCadastro = sha512.convert(bytes).bytes.toString();
                      }
                  ),
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Criar'),
            onPressed: () => _verificarCadastroForm(),
          )
        ],
      );
    };

    return builder;
  }

  _verificarCadastroForm() {

    if (_cadastroFormKey.currentState.validate()) {

    }
  }

  _verificarLoginForm() {

  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}