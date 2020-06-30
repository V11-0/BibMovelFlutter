import 'package:bibmovel/src/main/values/database_fields.dart';

class Sessao {

  int _id;
  int _idUsuario;
  String _hashCode;
  String _dataInicio;
  String _deviceUUID;

  Sessao(this._id, this._idUsuario, this._hashCode, this._deviceUUID);
  Sessao.validacao(this._id, this._idUsuario, this._hashCode, this._dataInicio, this._deviceUUID);

  String get dataInicio => _dataInicio;

  String get hashcode => _hashCode;

  int get id => _id;

  int get idUsuario => _idUsuario;

  String get deviceUUID => _deviceUUID;

  Sessao.fromJson(Map<String, dynamic> json) {
    _id = json[fieldId];
    _idUsuario = json[fieldIdUsuario];
    _hashCode = json[fieldHashCode];
    _dataInicio = json[fieldDataInicio];
    _deviceUUID = json[fieldDeviceUUID];
  }

  Map<String, dynamic> toJson() => {
    fieldId: _id,
    fieldIdUsuario: _idUsuario,
    fieldHashCode: _hashCode,
    fieldDataInicio: _dataInicio,
    fieldDeviceUUID: _deviceUUID
  };
}