import 'package:bibmovel/src/main/values/database_fields.dart';
import 'package:retrofit/retrofit.dart';

@Parser.JsonSerializable
class Usuario {

  String _usuario;
  String _email;
  String _senha;
  String _nome;

  Usuario(this._usuario, this._email, this._senha, {nome}) : _nome = nome;
  Usuario.login(this._email, this._senha);
  Usuario.load(this._usuario, this._email, this._nome);

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

  Usuario.fromJson(Map<String, dynamic> json) {
    _usuario = json[fieldUsuario];
    _email = json[fieldEmail];
    _nome = json[fieldNome];
  }

  Map<String, dynamic> toJson() {

    Map<String, dynamic> user = new Map();

    if (_usuario != null) user[fieldUsuario] = _usuario;
    if (_email != null) user[fieldEmail] = _email;
    if (_nome != null) user[fieldNome] = _nome;
    if (_senha != null) user[fieldSenha] = _senha;

    return user;
  }
}