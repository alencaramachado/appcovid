class Paciente {

  int _id;
  String _nome;
  String _email;
  String _cartao;
  int _idade;
  String _senha;

  Paciente(this._id, this._nome, this._email,
      this._cartao, this._idade, this._senha);

  set id(int i){
    this._id = i;
  }
  int get id{
    return this._id;
  }
  String get nome{
    return this._nome;
  }
  String get email{
    return this._email;
  }
  String get cartao{
    return this._cartao;
  }
  int get idade{
    return this._idade;
  }
  String get senha{
    return this._senha;
  }

}