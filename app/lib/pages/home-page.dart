import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'dart:io';

import 'package:image_picker/image_picker.dart';

var datain = null;
int _selectedIndexlength = -1;
const List<String> length = const <String>[
  'Small',
  'medium',
  'large',
];
double _po = -20;
bool _visible = false;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

int selected = 0;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      Timer(Duration(seconds: 1), () {
        print("oh ya");
        setState(() {
          _visible = true;
          _po = 0;
        });
      });
    });
    super.initState();
  }

//save the result of gallery file
  File galleryFile;

//save the result of camera file
  File cameraFile;
  @override
  Widget build(BuildContext context) {
    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      print("You selected gallery image : " + galleryFile.path);
      setState(() {
        selected = 0;
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
      });
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              "assets/home1.jpg",
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            bottom: _po,
            left: -250,
            child: Image.asset(
              "assets/home2.png",
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomLeft,
            ),
          ),
          AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 1400),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 130,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: new Text(
                      "Sudo_",
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: new Text(
                      "Wild",
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              )),
          AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 1500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[


                    button("detect animal type", "/corg",
                        Icons.adb,context),
                SizedBox(
                  height: 5,
                ),
                    button("report for an illegal thing","/intro",
                        Icons.camera_alt,context),
                SizedBox(
                  height: 5,
                ),
                button("Save object", "/save",
                    Icons.code,context),

                SizedBox(
                  height: 45,
                )
              ],
            ),
          ),


        ],
      ),
    );
  }

  Widget button(String name_, x, c,BuildContext context) {
    return RaisedButton(

      onPressed: ()=>Navigator.pushNamed(context, x),
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
