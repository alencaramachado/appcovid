
import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/paciente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PacienteList extends StatefulWidget{

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
                 itemBuilder: (context, index){
                  final Paciente p = _pacientes[index];
                   return ItemPaciente(p);
                  }
              ),
            ),
          ),
         ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          Paciente p1 = Paciente(18, 'Santos', 'santos@teste', 'tx232', 66, 'teste223');
          PacienteDAO.adicionar(p1);
          setState(() {
            debugPrint(' adiconar pacientes ...');
          });
        },
        child: Icon(Icons.add)
      ),
    );
  }
}

class ItemPaciente extends StatelessWidget {

  final Paciente _paciente;

  ItemPaciente(this._paciente);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('imagens/avatar.jpeg'),
          ),
          title: Text(this._paciente.nome,
            style: TextStyle(fontSize: 24),
          ),
          subtitle: Text(this._paciente.email,
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

  Widget _menu(){
    return PopupMenuButton(
      onSelected: (ItensMenuListPaciente selecionado){
        debugPrint('selecionado ... $selecionado');
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ItensMenuListPaciente>>[
        const PopupMenuItem(
          value: ItensMenuListPaciente.editar,
          child: Text('Editar'),
        ),
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

 enum ItensMenuListPaciente {editar, resultados, novo_checklist}
