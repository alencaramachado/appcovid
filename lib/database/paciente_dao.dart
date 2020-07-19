

import 'package:codaula/model/paciente.dart';

class PacienteDAO{
  static final List<Paciente> _pacientes = List();


  static adicionar(Paciente p){
    _pacientes.add(p);
  }

  static get listarPacientes{
    return _pacientes;
  }

}