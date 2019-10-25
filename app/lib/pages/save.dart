import 'dart:ui';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:image_picker/image_picker.dart';

import 'package:qrscan/qrscan.dart' as scanner;

import 'dart:typed_data';

import 'package:sudo_wild/pages/qr.dart';
import 'qr.dart';

int selected = 0;
int state = 1;
var linkfile;

//save the result of camera file
class save extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return data_home();
  }
}
File cameraFile;
File galleryFile;

class data_home extends State<save> {
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.green,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        title: Text('save objects'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SingleChildScrollView(
          child:
          state == 1
              ? state1()
              :state==2?state2(context):state3(),
      ),
    );
  }
  Uint8List bytes = Uint8List(200);
  String barcode = '';
  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() => this.barcode = barcode);
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    setState(() => this.barcode = barcode);
  }


  Widget state3(){
    return Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        SizedBox(
        width: 200,
        height: 200,
        child: Image.memory(bytes),
    ),
    Text('RESULT  $barcode'),
    RaisedButton(onPressed: _scan, child: Text("Scan")),
    RaisedButton(onPressed: _scanPhoto, child: Text("Scan Photo")),
    ],
    ),
    );
  }
  Widget state2(BuildContext context){
    int a=0;
    String code="asd";
    return a==0?Column(
      children: <Widget>[
        Text(
          "save your object by QR code",
          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 25),
        ),
        Center(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 100,
              ),
              FlatButton(
                color: Colors.lightGreen,
                onPressed: imageSelectorGallery,
                child: Text("gallery"),
              ),
              SizedBox(
                width: 40,
              ),
              FlatButton(
                color: Colors.lightGreenAccent,
                onPressed: imageSelectorCamera,
                child: Text("camera"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        linkfile != null
            ? new Image.file(
          linkfile,
          scale: 5,
        )
            : Text(
          "you didn`t upload any image",
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
        FlatButton(
          color: Colors.green,
          onPressed: () {
            Navigator.of(context).push(
              // With MaterialPageRoute, you can pass data between pages,
              // but if you have a more complex app, you will quickly get lost.
              MaterialPageRoute(
                builder: (context) =>
                    qrclass(asx: 'Hello there from the first page!'),
              ),
            );
          },
          child: Text("generate"),
        )
      ],
    ):Column(
      children: <Widget>[
        Text(
          "save it ",
          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 25),
        ),

      ],
    );
  }
  imageSelectorGallery() async {
    galleryFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      // maxHeight: 50.0,
      // maxWidth: 50.0,
    );
    print("You selected gallery image : " + galleryFile.path);
    setState(() {
      selected = 0;
      linkfile = galleryFile;
    });
  }

  imageSelectorCamera() async {
    cameraFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      //maxHeight: 50.0,
      //maxWidth: 50.0,
    );
    print("You selected camera image : " + cameraFile.path);

    setState(() {
      selected = 1;
      linkfile = cameraFile;
    });
  }

  Widget state1() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 150,
        ),
        Center(
            child:     Text("this function can help you to save photo and import it again by QR code.",style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 25

            ) ,)
        ),
        SizedBox(
          height: 250,
        ),
        RaisedButton(

          onPressed: () {
            print('create new object');
            setState(() {
              state = 2;
            });
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: null,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.green,
                  Colors.lightGreen,
                  Colors.greenAccent,
                ],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(

              children: <Widget>[

                Text('create new object', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),

        RaisedButton(

          onPressed: () {
            print('You tapped on RaisedButton');
            setState(() {
              state = 3;
            });
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: null,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.green,
                  Colors.lightGreen,
                  Colors.greenAccent,
                ],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(

              children: <Widget>[

                Text("scan QR code", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget button(String name_, x, c) {
    return RaisedButton(
      onPressed: x,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: null,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.green,
              Colors.lightGreen,
              Colors.greenAccent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Icon(c),
            Text('$name_', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
