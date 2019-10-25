import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';



class qrclass extends StatefulWidget {
  final String asx;
    qrclass({Key key, @required this.asx}) : super(key: key);
  @override

  State<StatefulWidget> createState() {
    return MyApp(asx);
  }
}
class MyApp extends State<qrclass> {
  String asx;
  MyApp(this.asx);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.green,
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          title: Text('qrclass'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Center(
            child:QrImage(
              data: asx,
              version: QrVersions.auto,
              size: 250.0,
            ),),
      ),
    );
  }
}