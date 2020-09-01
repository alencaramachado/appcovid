import 'package:codaula/database/openDatabaseDB.dart';
import 'package:codaula/model/check_sintomas_model.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/screens/android/checklist/checklist_sintomas.dart';
import 'package:codaula/service/definir_caso_suspeito.dart';
import 'package:sqflite/sqflite.dart';

class CheckSintomasDAO{


  static const String _nomeTabela = 'checksintomas';
  static const String _col_id = 'id_cs';
  static const String _col_idpaciente = 'idpaciente';
  static const String _col_temp = 'temp';
  static const String _col_qtdDias = 'qtdiasintomas';
  static const String _col_isTosse = 'tosse';
  static const String _col_isCatarro = 'catarro';
  static const String _col_isRouquidao = 'rouquidao';
  static const String _col_isDorGarganta = 'dorgarganta';
  static const String _col_isNarizEntupido = 'narizentupido';
  static const String _col_dataAvaliacao = 'dataAvaliacao';
  static const String _col_isCasoSuspeito = 'casosuspeito';

  static const String sqlTabela = 'CREATE TABLE $_nomeTabela ('
      '$_col_id INTEGER PRIMARY KEY, '
      '$_col_idpaciente INTEGER, '
      '$_col_temp INTEGER, '
      '$_col_qtdDias INTEGER, '
      '$_col_isTosse INTEGER,'
      '$_col_isCatarro INTEGER, '
      '$_col_isRouquidao INTEGER, '
      '$_col_isDorGarganta INTEGER, '
      '$_col_isNarizEntupido INTEGER, '
      '$_col_dataAvaliacao TEXT, '
      '$_col_isCasoSuspeito INTEGER, '
      ' FOREIGN KEY ($_col_idpaciente) REFERENCES paciente(id))';

  //static final List<CheckSintomasModel> _chekSintomasPaciente = List();

  static adicinar(CheckSintomasModel cs) async{

    cs.isCasoSuspeito = DefinirCasoSuspeito().casoSuspeito(cs);

    final Database db = await getDatabase();
    db.insert(_nomeTabela, cs.toMap());

   // _chekSintomasPaciente.add(cs);
  }


  static const String _nomeTabelaPaciente = 'paciente';
  static const String _col_idP = 'id';
  static const String _col_nome = 'nome';
  static const String _col_email = 'email';
  static const String _col_idade = 'idade';
  static const String _col_cartao = 'cartao';
  static const String _col_senha = 'senha';
  static const String _col_foto = 'foto';

   Future<List<CheckSintomasModel>> getPacienteCheckSintomas(Paciente p) async{

    final Database db =  await getDatabase();
    // select * from checksintomas, paciente where id_cl = id and id = p.id
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM $_nomeTabela cs, $_nomeTabelaPaciente p '
                          'WHERE cs.idpaciente = p.id AND p.id = '+p.id.toString());

//    CheckSintomasModel(this._id, this._paciente, this._temp, this._qtdDiasSintomas,
//        this._isNarizEntupido, this._isDorGarganta, this._isRouquidao, this._isCatarro,
//        this._isTosse, this._dataAvaliacao)

    return List.generate(maps.length, (i) {

      Paciente paciente  = Paciente(
        maps[i][_col_idP],
        maps[i][_col_nome],
        maps[i][_col_email],
        maps[i][_col_cartao],
        maps[i][_col_idade],
        maps[i][_col_senha],
        maps[i][_col_foto],
      );

      CheckSintomasModel cs = CheckSintomasModel(
        maps[i][_col_id],
        paciente,
        maps[i][_col_temp],
        maps[i][_col_qtdDias],
        maps[i][_col_isNarizEntupido] == 1 ? true : false,
        maps[i][_col_isDorGarganta] == 1 ? true : false,
        maps[i][_col_isRouquidao] == 1 ? true : false,
        maps[i][_col_isCatarro] == 1 ? true : false,
        maps[i][_col_isTosse] == 1 ? true : false,
        DateTime.parse(maps[i][_col_dataAvaliacao]),
      );
      cs.isCasoSuspeito = maps[i][_col_isCasoSuspeito] == 1 ? true : false;
      return cs;
    });

  }

}