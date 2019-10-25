

import 'package:flutter/material.dart';




class ans extends StatefulWidget {
   int asx;


  ans({Key key, @required this.asx, }) : super(key: key);
  @override

  State<StatefulWidget> createState() {
    return MyApp(asx);
  }
}
class MyApp extends State<ans> {
  int asx;
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
          title: Text('answer'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body:asx!=-1?ListView(
            children: <Widget>[
          Column(
            children: <Widget>[
              asx==1?Image.network("https://images2.minutemediacdn.com/image/upload/c_fill,g_auto,h_1248,w_2220/f_auto,q_auto,w_1100/v1555356516/shape/mentalfloss/istock_000001881954_small.jpg"):Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQhGjh_L6hcjJunbd9xuF_BJxuAfRmsD3DknRp-muYrPBrxRq3t"),
            Text(asx==2?"wolfdog":"Boxer (dog)",style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900
            ),)
            ],
          ),
              Text(asx==2?"this type is very dangerous and no one should own it.":"it can be owned but is dangerous in the enclosed area"
                ,style: TextStyle(
                  color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 25

                ) ,),
              SizedBox(
                height: 20,
              ),
              Text(asx==2?"There are a range of experts who believe that they can distinguish a wolf, a wolfdog and dog apart but have been proven to be incorrect when providing their evidence before courts of law.":"The Boxer is a medium-sized, short-haired breed of dog, developed in Germany. The coat is smooth and tight-fitting; colors are fawn, brindled, or white, with or without white markings."
                ,style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 25

                ) ,)
  ],
        ):              Text("This is a beta release and we cannot identify your animal at this time"
          ,style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w400,
              fontSize: 25

          ) ,),
      ),
    );
  }
}