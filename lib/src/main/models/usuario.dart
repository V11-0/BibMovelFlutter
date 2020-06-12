class Usuario {

  String _usuario;
  String _nome;
  String _email;
  String _senha;

  Usuario(this._usuario, this._nome, this._email, this._senha);

  String get usuario => _usuario;

  set usuario(String value) {
    _usuario = value;
  }

  String get nome => _nome;

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  set nome(String value) {
    _nome = value;
  }
}