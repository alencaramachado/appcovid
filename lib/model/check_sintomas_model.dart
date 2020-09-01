import 'package:codaula/model/paciente_model.dart';

class CheckSintomasModel{

  int _id;
  Paciente _paciente;
  int _temp;
  int _qtdDiasSintomas;
  bool _isTosse;
  bool _isCatarro;
  bool _isRouquidao;
  bool _isDorGarganta;
  bool _isNarizEntupido;
  DateTime _dataAvaliacao;
  bool _isCasoSuspeito;

  CheckSintomasModel(this._id, this._paciente, this._temp, this._qtdDiasSintomas,
      this._isNarizEntupido, this._isDorGarganta, this._isRouquidao, this._isCatarro,
      this._isTosse, this._dataAvaliacao);


  Map<String, dynamic> toMap(){
    return{
      // id
    'idpaciente' : _paciente.id,
    'temp': _temp,
    'qtdiasintomas' : _qtdDiasSintomas,
    'tosse' : _isTosse == true ? 1 : 0,
    'catarro' : _isCatarro == true ? 1 : 0,
    'rouquidao' : _isRouquidao == true ? 1 : 0,
    'dorgarganta' : _isDorGarganta == true ? 1 : 0,
    'narizentupido' : _isNarizEntupido == true ? 1 : 0,
    'dataAvaliacao' : _dataAvaliacao.toIso8601String(),
    'casosuspeito' : _isCasoSuspeito == true ? 1 : 0,
    };
  }


  set id(int id){
    this._id = id;
  }
  int get id{
    return this._id;
  }

  Paciente get paciente{
    return this._paciente;
  }
  int get temp{
    return this._temp;
  }

  int get qtdDiasSintomas{
    return this._qtdDiasSintomas;
  }

  bool get isTosse{
    return this._isTosse;
  }

  bool get isCatarro{
    return this._isCatarro;
  }

  bool get isNarizEntupido{
    return this._isNarizEntupido;
  }

  bool get isDorGarganta{
    return this._isDorGarganta;
  }

  bool get isRouquidao{
    return this._isRouquidao;
  }

  set isCasoSuspeito( bool suspeito){
    this._isCasoSuspeito = suspeito;
  }
  bool get isCasoSuspeito{
    return this._isCasoSuspeito;
  }

  DateTime get dataAvaliacao{
    return this._dataAvaliacao;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'CHECKSINTOMAS $id: Paciente: id '+paciente.id.toString()+', nome:'+paciente.nome
        +' temp: $_temp, '+' dias sintomas: $_qtdDiasSintomas'
        +' iscatarro: $_isCatarro, '+' istosse: $_isTosse, '+' isrouquidao: $_isRouquidao, '
        +' isDorGarganta: $_isDorGarganta, '+' isNarizEntupido: $_isNarizEntupido, '
        +' SUSPEITO?: $_isCasoSuspeito, '+
        'dtime /'+dataAvaliacao.day.toString()+'/'+dataAvaliacao.month.toString()+'/'+dataAvaliacao.year.toString();
  }

}