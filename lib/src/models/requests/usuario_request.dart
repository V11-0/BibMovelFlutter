import 'package:bibmovel/src/values/database_fields.dart';
import 'package:bibmovel/src/values/internals.dart';

import '../usuario.dart';

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