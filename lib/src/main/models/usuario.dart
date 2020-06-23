import 'package:bibmovel/src/main/values/database_fields.dart';
import 'package:retrofit/retrofit.dart';

@Parser.JsonSerializable
class Usuario {

  int _id;
  String _usuario;
  String _email;
  String _senha;
  String _nome;

  Usuario(this._usuario, this._email, this._senha, {nome, id}) : _id = id, _nome = nome;

  Usuario.login(this._email, this._senha);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get usuario => _usuario;

  set usuario(String value) {
    _usuario = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Usuario.fromJson(Map<String, dynamic> json) {
    _id = json[fieldId];
    _usuario = json[fieldUsuario];
    _email = json[fieldEmail];
    _nome = json[fieldNome];
  }

  Map<String, dynamic> toJson() {

    Map<String, dynamic> user = new Map();

    if (_id != null) user[fieldId] = _id;
    if (_usuario != null) user[fieldUsuario] = _usuario;
    if (_email != null) user[fieldEmail] = _email;
    if (_nome != null) user[fieldNome] = _nome;
    if (_senha != null) user[fieldSenha] = _senha;

    return user;
  }
}