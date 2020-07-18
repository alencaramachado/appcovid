import 'dart:io';

import 'package:codaula/screens/android/appcovid.dart';
import 'package:flutter/material.dart';

void main() {

  if(Platform.isAndroid){
    debugPrint('app no android');
    runApp(AppCovid());
  }
  if(Platform.isIOS){
    debugPrint('app no IOS');
  }

  //runApp(MyApp());
}



