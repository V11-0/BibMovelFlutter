import 'package:bibmovel/src/values/database_fields.dart';
import 'package:bibmovel/src/values/internals.dart';

import '../sessao.dart';

class SessaoRequest {

  String operationKey = generalKey;
  Sessao sessao;

  SessaoRequest(this.sessao);

  Map<String, dynamic> toJson() => {
    fieldOperationKey: operationKey,
    fieldSessao: sessao,
  };
}