import 'dart:io';

import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/screens/android/appcovid.dart';
import 'package:flutter/material.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  _geraPacientes(){

    Paciente p1 = Paciente(0, 'Jose', 'jose@teste', 'tx232', 66, 'teste223', '');
    //PacienteDAO().adicionar(p1);

  }

  PacienteDAO().getPacientes().then((value) {
    for(Paciente p in value){
      debugPrint('paciente nome : '+p.nome);
    }
  });

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



