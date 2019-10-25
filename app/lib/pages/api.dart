import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Map> createPost(String url, Map body) async {
  print("post");
  String ip="192.168.1.3:5000/";

  print(ip+url);
  return http.post(ip+url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      return {"msg":4};
    }
    Map valueMap = json.decode(response.body);
    return valueMap;
  });
}

//var uri =("http://yousseffmasry04.pythonanywhere.com/codeRegistrate");




Future getdata(String url) async {
  String ip="192.168.1.3:5000/";

  var data;
  print(ip+url);
  http.Response response = await http.get(ip+url);
  data =response.body;
  var valueMap = json.decode(data);
  //print(valueMap["code"]);
  return valueMap;

}
Future<String> my_img_get(id) async {
  String ip="192.168.1.3:5000/";

  http.Response response1 = await http.get("${ip}img/$id");
  if (response1.statusCode == 200){
    return "${ip}img/$id";

  }
  else{
    print(response1.statusCode);
  }

}

