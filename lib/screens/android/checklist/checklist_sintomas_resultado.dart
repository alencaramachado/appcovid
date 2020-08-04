



import 'package:codaula/database/check_sintomasDAO.dart';
import 'package:codaula/model/check_sintomas_model.dart';
import 'package:codaula/screens/android/paciente/paciente_list.dart';
import 'package:codaula/service/definir_caso_suspeito.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChecklistSintomasResultados extends StatelessWidget{

  CheckSintomasModel _checkSintomasModel;
  String _msg;

  ChecklistSintomasResultados(this._checkSintomasModel){
    this._msg = DefinirCasoSuspeito()
                  .casoSuspeitoCovidOrientacao(this._checkSintomasModel);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('RESULTADO'),
      ),
      body: Column(
        children: <Widget>[
          Text(this._msg, style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold,
          ),),
          _registrarBtn(context),
        ],
      )
    );
  }

  Widget _registrarBtn(BuildContext context){
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            child: Text('REGISTRAR'),
            onPressed: (){


              CheckSintomasDAO.adicinar(this._checkSintomasModel);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PacienteList()
              ));
            },
            color: Colors.green,
            elevation: 5.0,
          ),
          RaisedButton(
            child: Text('DESCARTAR'),
            onPressed: (){
                Navigator.of(context).pop();
            },
            color: Colors.amberAccent,
            elevation: 5.0,
          ),
        ],
      ),
    );
  }

}