
import 'package:codaula/database/check_sintomasDAO.dart';
import 'package:codaula/database/paciente_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'dbcovid192.db');

  return openDatabase(
      path,
      onCreate: (db, version){
        db.execute(PacienteDAO.sqlTabelaPaciente);
        db.execute(CheckSintomasDAO.sqlTabela);
      },
      version: 1);
}