import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:image_picker/image_picker.dart';

int selected = 0;

var linkfile;
//save the result of camera file
class data_homemain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return data_home();
  }
}

class data_home extends State<data_homemain> {
  @override

  File cameraFile;
  File galleryFile;
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
        linkfile=galleryFile;
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
        linkfile=cameraFile;
      });
    }

    return Scaffold(

        appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.green,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        title: Text('report'),
    leading: IconButton(icon:Icon(Icons.arrow_back),
    onPressed:() => Navigator.pop(context, false),
    ),
        ),

      body:  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text("help us detect any illegal wildlife materials.",style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 25

              ) ,),
            ),
            InputWidget(50.0, 0.0, 1000, "Feed Back",null,20),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text("Where did this happen ?",style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 25

              ) ,),
            ),
            InputWidget(0.0, 0.0, 500, "location data",null,1),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text("Links to illegal trading posts orwebsites:"
                  ,style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 25

              ) ,),
            ),
            InputWidget(0, 50.0, 1000, "social links",null,1),
            Text("attach any image of the illegal materials"
              ,style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 25

              ) ,),
            Center(
            child:Row(

              children: <Widget>[
                SizedBox(
                  width: 100,
                ),
                FlatButton(
                  color: Colors.lightGreen,
                  onPressed:imageSelectorGallery,
                  child: Text("gallery"),
                ),
                SizedBox(
                  width: 40,
                ),
                FlatButton(
                  color: Colors.lightGreenAccent,
                  onPressed:imageSelectorCamera,
                  child: Text("camera"),
                ),
              ],
            ),
      ),
            SizedBox(
              height: 40,
            ),
            linkfile!=null?new Image.file(linkfile,scale: 5,):
            Text("you didn`t upload any image"
              ,style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 25

              ) ,),
            FlatButton(

              color: Colors.green,
              onPressed: (){

              },

              child: Text("submit"),
            )
          ],
        )


      ),
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
class InputWidget extends StatelessWidget {
  final double topRight;
  final double bottomRight;
  final int max;
  final String back;
  String error =null;
  int line=1;
  InputWidget(this.topRight, this.bottomRight,this.max,this.back,[this.error,this.line]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40, bottom: 30),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(bottomRight),
                  topRight: Radius.circular(topRight))),
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
            child: TextField(
              maxLines: line,
              maxLength: max,
              keyboardType:TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorText: error !=null ? error : null,
                  hintText: back,

                  hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
            ),
          ),
        ),
      ),
    );
  }
}