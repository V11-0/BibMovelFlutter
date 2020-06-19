import 'package:bibmovel/src/main/values/database_fields.dart';
import 'package:retrofit/retrofit.dart';

import 'package:bibmovel/src/main/models/usuario.dart';
import 'package:bibmovel/src/main/values/internals.dart';

@Parser.JsonSerializable
class UsuarioPostRequest {

  String operationKey = generalKey;
  Usuario usuario;

  UsuarioPostRequest(this.usuario);

  Map<String, dynamic> toJson() => {
    fieldOperationKey: operationKey,
    fieldUsuario: usuario,
  };
}