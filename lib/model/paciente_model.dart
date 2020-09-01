class Paciente {

  int _id;
  String _nome;
  String _email;
  String _cartao;
  int _idade;
  String _senha;
  String _foto;

  Paciente(this._id, this._nome, this._email,
      this._cartao, this._idade, this._senha, this._foto);


  Map<String, dynamic> toMap(){
    return{
      //'id': _id,
      'nome' : _nome,
      'email' : _email,
      'cartao' : _cartao,
      'idade' : _idade,
      'senha' : _senha,
      'foto' : _foto,
    };
  }

  set id(int i){
    this._id = i;
  }
  int get id{
    return this._id;
  }

  String get foto{
    return this._foto;
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

  @override
  String toString() {
    // TODO: implement toString
    return 'Paciente{id: $id, nome: $nome, email: $email}';
  }

}