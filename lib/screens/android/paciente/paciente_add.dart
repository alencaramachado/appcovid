
import 'dart:io';

import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/paciente.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class PacienteScrean extends StatefulWidget {

  int index;
  PacienteScrean({int index}){
    this.index = index;

    if(this.index == null){
      this.index = -1;
    }
  }

  @override
  _PacienteScreanState createState() => _PacienteScreanState();
}

class _PacienteScreanState extends State<PacienteScrean> {

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cartaoController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Paciente _paciente;
  bool _isUpdate = false;

  @override
  Widget build(BuildContext context) {

    if(widget.index >= 0 && this._isUpdate == false){
      debugPrint('editar index = '+widget.index.toString());

      this._paciente = PacienteDAO.getPaciente(widget.index);
      this._paciente.id = widget.index;
      this._nomeController.text = this._paciente.nome;
      this._emailController.text = this._paciente.email;
      this._idadeController.text = this._paciente.idade.toString();
      this._cartaoController.text = this._paciente.cartao;
      this._senhaController.text = this._paciente.senha;
      this._fotoPerfil = this._paciente.foto;

      this._isUpdate = true;

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ADD PACIENTE'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _fotoAvatar(context),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return 'nome obrigatório';
                    }
                    return null;
                  },
                  controller: this._nomeController,
                  decoration: InputDecoration(
                    labelText: "Nome"
                  ),
                  style: TextStyle( fontSize: 24),
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return 'e-mail obrigatório';
                    }
                    return null;
                  },

                  controller: this._emailController,
                  decoration: InputDecoration(
                      labelText: "E-mail"
                  ),
                  style: TextStyle( fontSize: 24),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return 'cartão SUS obrigatório';
                    }
                    return null;
                  },

                  controller: this._cartaoController,
                  decoration: InputDecoration(
                      labelText: "Cartão SUS"
                  ),
                  style: TextStyle( fontSize: 24),
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return 'Idade obrigatório';
                    }
                    return null;
                  },

                  controller: this._idadeController,
                  decoration: InputDecoration(
                      labelText: "Idade"
                  ),
                  style: TextStyle( fontSize: 24),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return 'Senha obrigatório';
                    }
                    return null;
                  },

                  controller: this._senhaController,
                  decoration: InputDecoration(
                      labelText: "Senha"
                  ),
                  style: TextStyle( fontSize: 24),
                  obscureText: true,
                ),
                Container(
                  //color: Colors.red,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(18),
                    elevation: 6.0,
                    color: Colors.lightBlue,
                    onPressed: (){

                      if(_formKey.currentState.validate()){


                        Paciente p =
                        new Paciente(widget.index, this._nomeController.text,
                                        this._emailController.text,
                                        this._cartaoController.text,
                                        int.tryParse(this._idadeController.text),
                                        this._senhaController.text,
                                        this._fotoPerfil
                        );

                    if(widget.index >= 0){
                      PacienteDAO.autalizar(p);
                      Navigator.of(context).pop();
                    }else{
                      PacienteDAO.adicionar(p);
                      Navigator.of(context).pop();
                    }

                      }else{
                        debugPrint('formuláiro inválido');
                      }


                    },
                    child: Text('SALVAR',
                      style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fotoAvatar(BuildContext context){

    return InkWell(
      onTap: (){
        alertTirarFoto(context);
        debugPrint('tirar foto ...');
      },
      child: CircleAvatar(
        backgroundImage: AssetImage('imagens/camera.png'),
        radius: 70,
        child: ClipOval(
            child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.file(File(this._fotoPerfil))
            )
        ),
      ),
    );

  }

  alertTirarFoto(BuildContext context){
    AlertDialog alert = AlertDialog(
      title: Text('TIRAR FOTO?', style: TextStyle(fontWeight: FontWeight.bold),),
      content: Text('Escolha entre câmera ou galeria para uma foto do seu perfil'),
      elevation: 5.0,
      actions: <Widget>[
        FlatButton(
          child: Text('CAMERA'),
          onPressed: (){
            debugPrint('usuário escolheu camera');
            _obeterImage(ImageSource.camera);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('GALERIA'),
          onPressed: (){
            debugPrint('usuário escolheu galeria');
            _obeterImage(ImageSource.gallery);
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context){
          return alert;
        }
    );

  }

  String _fotoPerfil = '';

  _obeterImage(ImageSource source) async{

    final image = await ImagePicker().getImage(source: source);

    if( image != null){
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioY: 1, ratioX: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: 'CORTAR IMAGEM',
          statusBarColor: Colors.lightBlue,
          backgroundColor: Colors.white
        )
      );

      setState(() {
        this._fotoPerfil = cropped.path;
      });

    }


  }
}
