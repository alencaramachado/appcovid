import 'dart:io';

import 'package:codaula/database/check_sintomasDAO.dart';
import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/check_sintomas_model.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/screens/android/checklist/checklist_sintomas_resultado.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class ChecklistSintomas extends StatelessWidget {

  Paciente _paciente;

  final _formKeys = GlobalKey<FormState>();

  TextEditingController tempController = new TextEditingController();
  TextEditingController diasSintomasController = new TextEditingController();


  ChecklistSintomas({Paciente paciente}){
    this._paciente = paciente;
      _isTosse = false;
      _isDorGarganta = false;
      _isCatarro = false;
      _isNarizEntupido = false;
      _isRouquidao = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SINTOMAS '+this._paciente.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: this._formKeys,
            child: Column(
              children: <Widget>[
                _pacienteAvatar(),
                CheckSintomas(),
                _temp_diasSintomasTFF(),
                _registarBtn(context)
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _registarBtn(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(15.0),
         onPressed: (){
            if(this._formKeys.currentState.validate()){
              debugPrint('registarr ....');
              debugPrint('Paciente '+this._paciente.nome);
              debugPrint('_isTosse? '+_isTosse.toString());
              debugPrint('_isCatarro? '+_isCatarro.toString());
              debugPrint('_isRouquidao? '+_isRouquidao.toString());
              debugPrint('_isDorGarganta? '+_isDorGarganta.toString());
              debugPrint('_isNarizEntupido? '+_isNarizEntupido.toString());

              debugPrint('Temp: '+tempController.text);
              debugPrint('Dias sintomas: '+diasSintomasController.text);

              CheckSintomasModel csm =
              CheckSintomasModel(0, this._paciente, int.tryParse(this.tempController.text),
              int.tryParse(this.diasSintomasController.text), _isNarizEntupido, _isDorGarganta,
              _isRouquidao, _isCatarro, _isTosse, DateTime.now() );

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChecklistSintomasResultados(csm)
              ));

            }else{
              debugPrint('vormulário inválido');
            }
         },
        color: Colors.blue,
        elevation: 5.0,
        child: Text('REGISTRAR', style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 22.0,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }


  Widget _temp_diasSintomasTFF(){
    return Column(
      children: <Widget>[
        TextFormField(
          controller: tempController,
          validator: (value){
            if(value.isEmpty){
              return 'Temperatura obrigatória';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Temperatura",
            hintText: "Digite a temperatura"
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: diasSintomasController,
          validator: (value){
            if(value.isEmpty){
              return 'Informar os dias com os sitomas';
            }
            return null;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Dias com sintomas",
              hintText: "Digite a quantidade de dias"
          ),
          keyboardType: TextInputType.number,
        )
      ],
    );
  }

  Widget _pacienteAvatar(){
    return Column(
      children: <Widget>[
        ListTile(
          leading: _avatarFotoPerfil(),
          title: Text(this._paciente.nome.toUpperCase(),
            style: TextStyle(
                color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold
            ),),
          subtitle: Text(this._paciente.email, style: TextStyle(
              fontSize: 15
          ),),
        ),
        Divider(
          color: Colors.green,
          endIndent: 20,
          indent: 70.0,
          thickness: 1.0,
          height: 0.0,
        )
      ],
    );
  }

  Widget _avatarFotoPerfil(){

    RandomColor corRandomica = RandomColor();
    Color cor = corRandomica.randomColor(
        colorBrightness: ColorBrightness.light
    );

    var iniciaNome = this._paciente.nome[0].toUpperCase();
    if(this._paciente.foto.length> 0){
      iniciaNome = '';
    }

    return CircleAvatar(
      backgroundColor: cor,
      foregroundColor: Colors.white,
      backgroundImage: FileImage(File(this._paciente.foto)),
      radius: 22.0,
      child: Text(iniciaNome,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0
        ),),
    );
  }

}


class CheckSintomas extends StatefulWidget {
  @override
  _CheckSintomasState createState() => _CheckSintomasState();
}

bool _isTosse = false;
bool _isDorGarganta = false;
bool _isCatarro = false;
bool _isNarizEntupido = false;
bool _isRouquidao = false;

class _CheckSintomasState extends State<CheckSintomas> {
  bool valor = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          _itemCheck(label: 'Tosse', valor: _isTosse, onChanged: (){
            setState(() {
              _isTosse = !_isTosse;
            });
          }),
          _itemCheck(label: 'Catarro', valor: _isCatarro, onChanged: (){
            setState(() {
              _isCatarro = !_isCatarro;
            });
          }),
          _itemCheck(label: 'Rouquidao', valor: _isRouquidao, onChanged: (){
            setState(() {
              _isRouquidao = !_isRouquidao;
            });
          }),
          _itemCheck(label: 'Dor Garganta', valor: _isDorGarganta, onChanged: (){
            setState(() {
              _isDorGarganta = !_isDorGarganta;
            });
          }),
          _itemCheck(label: 'Nariz Entupido', valor: _isNarizEntupido, onChanged: (){
            setState(() {
              _isNarizEntupido = !_isNarizEntupido;
            });
          }),
        ],
      ),
    );
  }

  Widget _itemCheck({String label, bool valor, Function onChanged}){
    return InkWell(
      onTap: (){
       onChanged();
      },
      child: Row(
        children: <Widget>[
          Checkbox(
            onChanged: (bool novoValor){},
            value: valor,
            checkColor: Colors.green,
            activeColor: Colors.white,
          ),
          Text(label, style: TextStyle(fontSize: 30.0),)
        ],
      ),
    );
  }

}
