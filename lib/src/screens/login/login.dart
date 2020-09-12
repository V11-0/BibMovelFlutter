import 'dart:io' show Platform;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:crypto/crypto.dart';
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

import 'package:bibmovel/src/models/requests/usuario_request.dart';
import 'package:bibmovel/src/models/sessao.dart';
import 'package:bibmovel/src/models/usuario.dart';
import 'package:bibmovel/src/repos/usuario_repo.dart';
import 'package:bibmovel/src/utils/app_localizations.dart';
import 'package:bibmovel/src/values/internals.dart';

import '../home/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey<FormState> _cadastroFormKey;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _emailLogin;
  String _passLogin;

  String _userCadastro;
  String _emailCadastro;
  String _senhaCadastro;

  bool _creating = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFF1E3188)));

    FocusNode emailFocus = new FocusNode();
    FocusNode passwordFocus = new FocusNode();

    return Scaffold(
      key: _scaffoldKey,
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
                        keyboardType: TextInputType.emailAddress,
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context).translate('ShouldNotBeEmpty');
                          } else if (!isEmail(value)) {
                            return AppLocalizations.of(context).translate('TypeValidEmail');
                          }

                          return null;
                        },
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, emailFocus, passwordFocus);
                        },
                        onChanged: (value) => _emailLogin = value,
                      ),
                      Divider(color: Colors.black.withOpacity(0), height: 25.0),
                      TextFormField(
                        focusNode: passwordFocus,
                        obscureText: true,
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context).translate('ShouldNotBeEmpty');
                          }

                          return null;
                        },
                        onFieldSubmitted: (term) {
                          _verificarLoginForm();
                        },
                        onChanged: (value) {
                          var bytes = utf8.encode(value);
                          _passLogin = sha512.convert(bytes).toString();
                        },
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
                      onPressed: () {
                        _verificarLoginForm();
                      },
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      child: Text(AppLocalizations.of(context).translate('DontHaveAnAccount'),
                          style: TextStyle(
                              color: Colors.blue[400], decoration: TextDecoration.underline, fontSize: 18.0)),
                      onTap: () {
                        showDialog(context: context, builder: _createSignInDialog());
                      },
                    )
                )
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
        title: Text(AppLocalizations.of(context).translate('CreateAccount')),
        content: Form(
          key: _cadastroFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  maxLength: 49,
                  focusNode: userFocus,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).translate('User'),
                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                        const Radius.circular(100.0),
                      ))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppLocalizations.of(context).translate('ShouldNotBeEmpty');
                    } else if (value.contains(' ')) {
                      return AppLocalizations.of(context).translate('ShouldNotHaveSpaces');
                    }

                    return null;
                  },
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, userFocus, emailFocus);
                  },
                  onChanged: (value) => _userCadastro = value,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
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
                        return AppLocalizations.of(context).translate('ShouldNotBeEmpty');
                      } else if (!isEmail(value)) {
                        return AppLocalizations.of(context).translate('TypeValidEmail');
                      }

                      return null;
                    },
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(context, emailFocus, passFocus);
                    },
                    onChanged: (value) => _emailCadastro = value,
                  ),
                ),
                TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    focusNode: passFocus,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('Password'),
                        border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                          const Radius.circular(100.0),
                        ))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context).translate('ShouldNotBeEmpty');
                      }

                      return null;
                    },
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(context, passFocus, confirmPassFocus);
                    },
                    onChanged: (value) {
                      var bytes = utf8.encode(value);
                      _senhaCadastro = sha512.convert(bytes).toString();
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                      textInputAction: TextInputAction.go,
                      obscureText: true,
                      focusNode: confirmPassFocus,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).translate('ConfirmPassword'),
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                            const Radius.circular(100.0),
                          ))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context).translate('ShouldNotBeEmpty');
                        } else {
                          var bytes = utf8.encode(value);
                          String confirmacao = sha512.convert(bytes).toString();

                          if (confirmacao == _senhaCadastro) {
                            return null;
                          } else {
                            return AppLocalizations.of(context).translate('PasswordsNotEquals');
                          }
                        }
                      },
                      onFieldSubmitted: (term) {
                        _verificarCadastroForm();
                      }),
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Criar'),
            onPressed: () => _verificarCadastroForm(),
          ),
          _creating? CircularProgressIndicator() : Container()
        ],
      );
    };

    return builder;
  }

  _verificarCadastroForm() async {

    if (_cadastroFormKey.currentState.validate()) {
      setState(() => _creating = true);

      Usuario usuario = new Usuario(_userCadastro, _emailCadastro, _senhaCadastro);
      UsuarioRequest usuarioRequest = new UsuarioRequest(usuario);

      int responseCode = await UsuarioRepo.signUser(usuarioRequest);
      String texto;

      if (responseCode == 201) {
        texto = AppLocalizations.of(context).translate('SignUpDone');
      } else if (responseCode == 409) {
        texto = AppLocalizations.of(context).translate('UserOrEmailIsInUse');
      } else {
        texto = AppLocalizations.of(context).translate('ErrorOcurredTryAgainLater');
      }

      Navigator.pop(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(texto), duration: Duration(seconds: 4)));

      setState(() => _creating = false);
    }
  }

  _verificarLoginForm() async {

    if (_formKey.currentState.validate()) {

      DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
      List<String> info = [];

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        info.add(androidInfo.androidId);
        info.add(androidInfo.model);
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        info.add(iosInfo.identifierForVendor);
        info.add(iosInfo.model);
      }

      Usuario usuario = new Usuario.login(_emailLogin, _passLogin);
      UsuarioRequest usuarioRequest = new UsuarioRequest(usuario, deviceInfo: info);
      Sessao sessao = await UsuarioRepo.logUserIn(usuarioRequest);

      if (sessao != null) {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt(prefsSessionId, sessao.id);
        await prefs.setInt(prefsSessionUserId, sessao.idUsuario);
        await prefs.setString(prefsSessionHash, sessao.hashcode);
        await prefs.setString(prefsSessionStartDate, sessao.dataInicio);
        
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home())
            , (Route<dynamic> route) => false);
      } else {

      }
    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
