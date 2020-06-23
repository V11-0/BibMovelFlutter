import 'package:bibmovel/src/main/values/database_fields.dart';

class Sessao {

  int _id;
  String _hashCode;
  String _dataInicio;

  Sessao(this._id, this._hashCode, this._dataInicio);
  Sessao.empty();

  String get dataInicio => _dataInicio;

  String get hashcode => _hashCode;

  int get id => _id;

  Sessao.fromJson(Map<String, dynamic> json) {
    _id = json[fieldId];
    _hashCode = json[fieldHashCode];
    _dataInicio = json[fieldDataInicio];
  }
}