import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bibmovel/src/models/requests/sessao_request.dart';
import 'package:bibmovel/src/models/sessao.dart';
import 'package:bibmovel/src/models/usuario.dart';
import 'package:bibmovel/src/repos/sessao_repo.dart';
import 'package:bibmovel/src/values/internals.dart';
import 'package:bibmovel/src/values/strings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Usuario _usuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF99F2C8), Color(0xFF1F4037)],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 10,
                    child: _usuario != null
                        ? Column(
                            children: [
                              Text(_usuario.usuario, style: TextStyle(color: Colors.white)),
                              Text(_usuario.email, style: TextStyle(color: Colors.white)),
                            ],
                          )
                        : CircularProgressIndicator())
              ],
            ),
            ListTile(title: Text("Opção 1")),
            ListTile(title: Text("Opção 2"))
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(todosLivros),
      ),
      body: Container(
          alignment: Alignment.center,
          child: _usuario == null ? Center(child: CircularProgressIndicator()) : Text(_usuario.email)),
    );
  }

  @override
  void initState() {
    super.initState();

    // TODO: Obter dados da sessao pelo prefs e validar com o web service
    validaSessao();
  }

  void validaSessao() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int id = prefs.getInt(prefsSessionId);
    int idUsuario = prefs.getInt(prefsSessionUserId);
    String hashCode = prefs.getString(prefsSessionHash);
    String dataInicio = prefs.getString(prefsSessionStartDate);
    String deviceUUID = await _getDeviceUUID();

    Sessao sessao = new Sessao.validacao(id, idUsuario, hashCode, dataInicio, deviceUUID);
    SessaoRequest sessaoRequest = new SessaoRequest(sessao);

    try {
      var user = await SessaoRepo.validateSession(sessaoRequest);
      user.nome ??= '';

      setState(() => _usuario = user);
    } catch (e) {
      if (e.response != null) {
        if (e.response.statusCode == 403) {
          print('FORBIDDEN');
          // TODO: Pede para logar novamente
        } else {
          print('Server Error');
          // Ocorreu um erro no servidor
        }
      } else {
        // Sem resposta
        print("Serv Off");
      }
    }
  }

  Future<String> _getDeviceUUID() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await new DeviceInfoPlugin().androidInfo;
      return deviceInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo deviceInfo = await new DeviceInfoPlugin().iosInfo;
      return deviceInfo.identifierForVendor;
    }

    return null;
  }
}
