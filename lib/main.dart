import 'dart:io' show Platform;

import 'package:biometrictest2/screen/FIrstScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool hasBiometric = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Check Auth"),
          onPressed: ()async{
            bool pass = await checkBioMetric();
            if(pass){
              Navigator.of(context).push(MaterialPageRoute( builder: (context ) => FirstScreen()));
            }
          },
        )
      ),
    );
  }

  @override
  void initState() {
    print("Init State called");
      super.initState();

  }


  Future<bool> checkBioMetric() async {
    LocalAuthentication auth  =  LocalAuthentication();
    bool hasBiometric = await auth.canCheckBiometrics;

    if(hasBiometric){

      List<BiometricType> availableBiometrics =
      await auth.getAvailableBiometrics();

      print(availableBiometrics);

      if (Platform.isAndroid) {
            try {


//              returns a boolean 'true' if authenticated
              return  await auth.authenticateWithBiometrics(
                  localizedReason: 'Please authenticate');

            } on PlatformException catch(err){
              throw err;
            }
      }else{
        throw Exception("Feature available for android only");
      }


    }else{
      throw Exception("No biometric auth available for this device");
    }




  }

}
