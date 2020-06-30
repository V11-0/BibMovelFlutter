import 'dart:convert';

import 'package:bibmovel/src/main/models/requests/sessao_request.dart';
import 'package:bibmovel/src/main/models/usuario.dart';
import 'package:bibmovel/src/main/values/internals.dart';
import 'package:dio/dio.dart';

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