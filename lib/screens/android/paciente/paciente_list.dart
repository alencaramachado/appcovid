import 'dart:io';

import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/paciente.dart';
import 'package:codaula/screens/android/paciente/paciente_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_color/random_color.dart';

class PacienteList extends StatefulWidget {
  @override
  _PacienteListState createState() => _PacienteListState();
}

class _PacienteListState extends State<PacienteList> {
  @override
  Widget build(BuildContext context) {
    List<Paciente> _pacientes = PacienteDAO.listarPacientes;

    return Scaffold(
      appBar: AppBar(
        title: Text('PACIENTES'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            //color: Colors.red,
            child: TextField(
              style: TextStyle(fontSize: 25),
              decoration: InputDecoration(
                labelText: "Pesquisar",
                hintText: "Pesquisar",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.green,
              child: ListView.builder(
                  itemCount: _pacientes.length,
                  itemBuilder: (context, index) {
                    final Paciente p = _pacientes[index];
                    return ItemPaciente(p, onClick: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=> PacienteScrean(index: index))
                      ).then((value) {
                        setState(() {
                          debugPrint('... voltou do editar');
                        });
                      });
                    },);
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PacienteScrean()
            )).then((value) {

              setState(() {
                debugPrint(' retornou do add pacientes ');
              });

            });

          },
          child: Icon(Icons.add)),
    );
  }
}

class ItemPaciente extends StatelessWidget {
  final Paciente _paciente;
  final Function onClick;

  ItemPaciente(this._paciente, {@required this.onClick});

  Widget _avatarAntigo(){
    return CircleAvatar(
      backgroundImage: AssetImage('imagens/avatar.jpeg'),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () => this.onClick(),
          leading: _avatarFotoPerfil(),
          title: Text(
            this._paciente.nome,
            style: TextStyle(fontSize: 24),
          ),
          subtitle: Text(
            this._paciente.email,
            style: TextStyle(fontSize: 12),
          ),
          trailing: _menu(),
        ),
        Divider(
          color: Colors.green,
          indent: 70.0,
          endIndent: 20,
          thickness: 1.0,
          height: 0.0,
        )
      ],
    );
  }

  Widget _menu() {
    return PopupMenuButton(
      onSelected: (ItensMenuListPaciente selecionado) {
        debugPrint('selecionado ... $selecionado');
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuItem<ItensMenuListPaciente>>[
        const PopupMenuItem(
          value: ItensMenuListPaciente.resultados,
          child: Text('Resultados'),
        ),
        const PopupMenuItem(
          value: ItensMenuListPaciente.novo_checklist,
          child: Text('Novo Checklist'),
        )
      ],
    );
  }
}

enum ItensMenuListPaciente { resultados, novo_checklist }
