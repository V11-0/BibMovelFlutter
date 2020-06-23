import 'package:bibmovel/src/main/values/database_fields.dart';
import 'package:retrofit/retrofit.dart';

import 'package:bibmovel/src/main/models/usuario.dart';
import 'package:bibmovel/src/main/values/internals.dart';

@Parser.JsonSerializable
class UsuarioRequest {

  String operationKey = generalKey;
  Usuario usuario;
  List<String> deviceInfo;

  UsuarioRequest(this.usuario, {this.deviceInfo});

  Map<String, dynamic> toJson() => {
    fieldOperationKey: operationKey,
    fieldUsuario: usuario,
    fieldDeviceInfo: deviceInfo,
  };
}