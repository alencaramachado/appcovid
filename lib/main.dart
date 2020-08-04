import 'dart:io';

import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/screens/android/appcovid.dart';
import 'package:flutter/material.dart';

void main() {

  _geraPacientes(){

    Paciente p1 = Paciente(18, 'Jose', 'jose@teste', 'tx232', 66, 'teste223', '');
    Paciente p2 = Paciente(22, 'Paulo', 'paulo@teste', 'tx232', 56, 'teste223', '');
    Paciente p3 = Paciente(22, 'Paulo12', 'paulo@teste', 'tx232', 56, 'teste223', '');

    PacienteDAO.adicionar(p1);
    PacienteDAO.adicionar(p2);
    PacienteDAO.adicionar(p3);

  }

  if(Platform.isAndroid){
    debugPrint('app no android');
    _geraPacientes();
    runApp(AppCovid());
  }
  if(Platform.isIOS){
    debugPrint('app no IOS');
  }

  //runApp(MyApp());
}



