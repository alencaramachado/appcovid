
import 'package:codaula/model/check_sintomas_model.dart';

class DefinirCasoSuspeito{

  String casoSuspeitoCovidOrientacao(CheckSintomasModel cs){

    if(casoSuspeito(cs) && cs.qtdDiasSintomas >=10){
      return 'URGENTE: PACIENTE DEVE SER INTERNADO';
    }else if(casoSuspeito(cs) && cs.qtdDiasSintomas >=8){
      return 'ATENÇÃO: ENCAMINHAR IMEDIATAMENTE PARA AVALIAÇÃO MÉDICA';
    } else if(casoSuspeito(cs) && cs.qtdDiasSintomas >=6){
      return 'CASO SUSPEITO: PACIENTE DEVE SER ENCAMINHADO PARA EXAMES';
    } else {
      return 'ESTÁ TUDO BEM';
    }
  }


  bool casoSuspeito(CheckSintomasModel csm){
    if(_calculaPontos(csm) >=4){
      return true;
    }
    return false;
  }


  int _calculaPontos(CheckSintomasModel cs){
    int pontos = 0;

    if(cs.qtdDiasSintomas > 6){
      if(_sarg(cs)){
        pontos = pontos + 4;
      }
      if(cs.temp > 37.8){
        pontos = pontos + 2;
      }
      if(cs.isTosse){
        pontos = pontos + 1;
      }
      if(cs.isRouquidao){
        pontos = pontos + 1;
      }
      if(cs.isDorGarganta){
        pontos = pontos + 1;
      }
      if(cs.isNarizEntupido){
        pontos = pontos + 1;
      }

    }

    return pontos;

  }

  bool _sarg(CheckSintomasModel csm){

    if(csm.qtdDiasSintomas > 6){
      if(csm.temp > 37.8 && (csm.isTosse || csm.isCatarro)){
        return true;
      }
    }
    return false;
  }

}