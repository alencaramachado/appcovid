import 'package:codaula/model/check_sintomas_model.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/screens/android/checklist/checklist_sintomas.dart';
import 'package:codaula/service/definir_caso_suspeito.dart';

class CheckSintomasDAO{

  static final List<CheckSintomasModel> _chekSintomasPaciente = List();

  static adicinar(CheckSintomasModel cs){

    cs.isCasoSuspeito = DefinirCasoSuspeito().casoSuspeito(cs);

    _chekSintomasPaciente.add(cs);
  }

  static List<CheckSintomasModel> getPacienteCheckSintomas(Paciente p){

    List<CheckSintomasModel> lista = List();

    for(CheckSintomasModel csm in _chekSintomasPaciente){
        if(p.id == csm.paciente.id){
          lista.add(csm);
        }
    }
    return lista;

  }

}