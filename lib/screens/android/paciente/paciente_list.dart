import 'dart:io';

import 'package:codaula/database/check_sintomasDAO.dart';
import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/check_sintomas_model.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/screens/android/checklist/checklist_sintomas.dart';
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
    //List<Paciente> _pacientes = PacienteDAO.listarPacientes;

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
              child: _futureBuiderPaciente(),
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


  Widget _futureBuiderPaciente(){
    return FutureBuilder<List<Paciente>>(
      initialData: List(),
      future: PacienteDAO().getPacientes(),
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('Loading')
                ],
              ),
            );
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            final List<Paciente> pacientes = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Paciente p = pacientes[index];
                return ItemPaciente(p, onClick: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=> PacienteScrean(paciente: p,))
                  ).then((value) {
                    setState(() {
                      debugPrint('... voltou do editar');
                    });
                  });
                },);
              },
              itemCount: pacientes.length,
            );
            break;
        }
        return Text('Problemas em gerar a lista');
      },
    );
  }

  Widget _oldListPaciente(){

    List<Paciente> _pacientes = null;

    return ListView.builder(
        itemCount: _pacientes.length,
        itemBuilder: (context, index) {
          final Paciente p = _pacientes[index];
          p.id = index;
          return ItemPaciente(p, onClick: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=> PacienteScrean(paciente: p,))
            ).then((value) {
              setState(() {
                debugPrint('... voltou do editar');
              });
            });
          },);
        });
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
          trailing: _menu(context),
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

  Widget _menu(BuildContext context) {
    return PopupMenuButton(
      onSelected: (ItensMenuListPaciente selecionado) {
       
        if(selecionado == ItensMenuListPaciente.novo_checklist){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChecklistSintomas(paciente: this._paciente,)
          ));
        }else{

          CheckSintomasDAO().getPacienteCheckSintomas(this._paciente).then((sintomas) {

            if(sintomas.length > 0){

              for(CheckSintomasModel csm in sintomas){
                print(csm);
              }

            }else{
              print('NENHUM REGISTRO ENCONTRADO');
            }

          });




        }
        
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
