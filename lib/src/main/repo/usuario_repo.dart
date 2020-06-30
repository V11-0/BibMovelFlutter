import 'dart:convert';

import 'package:bibmovel/src/main/models/requests/sessao_request.dart';
import 'package:bibmovel/src/main/models/usuario.dart';
import 'package:dio/dio.dart';

import 'package:bibmovel/src/main/models/requests/usuario_request.dart';
import 'package:bibmovel/src/main/values/internals.dart';
import 'package:bibmovel/src/main/models/sessao.dart';

abstract class UsuarioRepo {

  /// Manda requisição post para cadastrar usuario
  static Future<int> signUser(UsuarioRequest usuarioRequest) async {

    String url = '$apiUrl' 'usuario';
    Dio dio = new Dio();

    int code;

    try {
      Response response = await dio.post(url, data: usuarioRequest.toJson()
              , options: Options(headers: {"Authorization": "Basic " + base64Url.encode(utf8.encode(authKey))}));

      code = response.statusCode;

    } catch (e) {
      code = e.response.statusCode;
    }

    return code;
  }

  /// Envia requisição de Login e retorna um objeto sessão
  static Future<Sessao> logUserIn(UsuarioRequest usuarioRequest) async {

    String url = '$apiUrl' 'usuario/login';
    Dio dio = new Dio();

    try {
      Response response = await dio.post(url, data: usuarioRequest.toJson()
        , options: Options(headers: {"Authorization": "Basic " + base64Url.encode(utf8.encode(authKey))}));

      if (response.statusCode == 200) {
        return Sessao.fromJson(response.data);
      }

    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Valida a sessao atual do dispositivo
  static Future<Usuario> validateSession(SessaoRequest sessaoRequest) async {

    String url = '$apiUrl' 'usuario/validate';
    Dio dio = new Dio();

    try {
      Response response = await dio.post(url, data: sessaoRequest.toJson()
          , options: Options(headers: {"Authorization": "Basic " + base64Url.encode(utf8.encode(authKey))}));

      if (response.statusCode == 200) {
        return Usuario.fromJson(response.data);
      }

    } catch (e) {
      print(e);
      return null;
    }
  }
}