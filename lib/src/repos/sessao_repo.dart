import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:bibmovel/src/models/requests/sessao_request.dart';
import 'package:bibmovel/src/models/usuario.dart';
import 'package:bibmovel/src/values/internals.dart';

abstract class SessaoRepo {

  /// Valida dados da sessao salva do usuario
  static Future<Usuario> validateSession(SessaoRequest sessaoRequest) async {

    String url = '$apiUrl' 'sessao/validate';
    Dio dio = new Dio();

    Response response = await dio.post(url, data: sessaoRequest.toJson()
        , options: Options(headers: {"Authorization": "Basic " + base64Url.encode(utf8.encode(authKey))}));

    return Usuario.fromJson(response.data);
  }
}