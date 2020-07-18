
import 'package:codaula/screens/android/dashbord_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Login'),
      ),
      body: Container(
        //color: Colors.green,
        padding: EdgeInsets.symmetric(vertical: 50.0),
        width: double.infinity,
        child: RaisedButton(
          onPressed: (){

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Dashbord()
            ));

          },
          color: Colors.blue,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          ),
          padding: EdgeInsets.all(20.0),
          child: Text('LOGIN', style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}
