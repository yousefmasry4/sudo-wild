import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'answer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
var datain = null;
const List<String> length = const <String>[
  'Small',
  'medium',
  'large',
];
double _po = -20;
bool _visible = false;

class corgclass extends StatefulWidget {
  corgclass({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

int selected = 0;

class _HomePageState extends State<corgclass> {
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
  Future<String> imgserver(path,BuildContext context)async{
    String aaa;
    print(path);
      String ip="http://192.168.1.3:5000/img";
      // open a bytestream
      var stream = new http.ByteStream(DelegatingStream.typed(galleryFile == null?cameraFile.openRead():galleryFile.openRead()));
      // get file length
      var length;
      try {
        length = await galleryFile.length();
      }catch(err){
        length = await cameraFile.length();

      }
      // string to uri
      var uri = Uri.parse(ip);
      print(uri);
      // create multipart request
      var request = new http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: basename(path));

      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      print(response.statusCode);

      // listen for response
      await response.stream.transform(utf8.decoder).listen((value) {
        aaa= value;
      });
      print("ddddddddddd ${aaa.runtimeType}");
      return await aaa;
  }
  Widget build(BuildContext context) {
    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      print("You selected gallery image : " + galleryFile.path);
      var aaa=await imgserver(galleryFile.path,context);
      setState(() {
        selected = 0;
        print(aaa);
      });
      Navigator.of(context).push(
        // With MaterialPageRoute, you can pass data between pages,
        // but if you have a more complex app, you will quickly get lost.
        MaterialPageRoute(
          builder: (context) =>
              ans(asx: int.parse(aaa)),
        ),
      );

    }

    imageSelectorCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        //maxHeight: 50.0,
        //maxWidth: 50.0,
      );
      print("You selected camera image : " + cameraFile.path);
      var aaa=await imgserver(cameraFile.path,context);
      setState(() {
        selected = 0;
        print(aaa);
      });
      Navigator.of(context).push(
        // With MaterialPageRoute, you can pass data between pages,
        // but if you have a more complex app, you will quickly get lost.
        MaterialPageRoute(
          builder: (context) =>
              ans(asx: int.parse(aaa)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.green,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        title: Text('animals recognition'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
    child:     Text("this function can help you to recognition and detection animal name, type and more informations.",style: TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: 25

    ) ,)
          ),
          AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 1500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[


                button("Select Image from Gallery", imageSelectorGallery,
                    Icons.insert_photo),
                SizedBox(
                  height: 5,
                ),
                button("Select Image from Camera", imageSelectorCamera,
                    Icons.camera_alt),


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
