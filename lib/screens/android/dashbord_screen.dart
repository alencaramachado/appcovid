

import 'package:codaula/screens/android/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashbord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DASHBORD'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Login()
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                _msgSuperiorTXT(),
                _imgCentral(),
                Container(
                  //color: Colors.green,
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _ItemElemento('PACIENTES', Icons.accessibility_new,
                        onClick:  (){
                                      debugPrint('pacientes ....');
                                      },
                      ),
                      _ItemElemento('RESULTADOS', Icons.check_circle_outline, onClick: (){
                                      debugPrint('resutlados ....');
                                    },
                      ),
                    ],
                  ),
                )
              ]
          ),
        )
    );
  }

  Widget _imgCentral(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset('imagens/check6.jpg'),
    );
  }

  Widget _msgSuperiorTXT(){
    return Container(
     // color: Colors.green,
      alignment: Alignment.topRight,
      padding: const EdgeInsets.all(8.0),
      child: Text('Checklist para o COVID-19', style: TextStyle(
          color: Colors.black.withOpacity(0.6),
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic
      ),),
    );
  }
}

class _ItemElemento extends StatelessWidget {

  final String titulo;
  final IconData icone;
  final Function onClick;

  _ItemElemento(this.titulo, this.icone, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 10.0,
        child: InkWell(
          onTap: this.onClick,
          child: Container(
            // color: Colors.green,
            width: 150,
            height: 80,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(this.icone,
                  color: Colors.white,
                ),
                Text(this.titulo, style: TextStyle(
                    color: Colors.white, fontSize: 16
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


