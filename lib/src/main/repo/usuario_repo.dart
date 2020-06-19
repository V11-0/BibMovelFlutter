import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:bibmovel/src/main/models/requests/post_usuario_request.dart';
import 'package:bibmovel/src/main/values/internals.dart';

abstract class UsuarioRepo {

  /// Manda requisição post para cadastrar usuario
  static Future<int> signUser(UsuarioPostRequest usuario_request) async {

    Dio dio = new Dio();

    int code;

    try {
      Response response = await dio.post('$apiUrl' 'usuario', data: usuario_request.toJson()
              , options: Options(headers: {"Authorization": "Basic " + base64Url.encode(utf8.encode(authKey))}));

      code = response.statusCode;

    } catch (e) {
      code = e.response.statusCode;
    }

    return code;
  }
}