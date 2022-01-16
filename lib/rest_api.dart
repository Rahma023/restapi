import 'dart:convert';
import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class  RestApi extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Api"),
      ),
      body: HomePage(),
      
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataModel> dataList = [];
  bool isLoading = true;

  getData() async{
    final Url = Uri.parse('https://jsonkeeper.com/b/6L5J');
    http.Response response = await http.get(Url.headers:{
      'Accept': 'application/jason'
    });

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    setState(() {
      dataList = List<DataModel>.from(jsonData["data"].map(x) => DataModel.fromJson(x));
      isLoading = false;
    });
  }
  @override
  void initState(){
    getData();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      child: isLoading?Center(
        child: CircularProgressIndicator(),
      ): ListView(itemCount: dataList.length, itemBuilder: (context, index){
        return DataCard(languageName: dataList[index].languageName,
        languageDesc: dataList[index].languageDesc,
        languageImg: dataList[index].languageImg,);




      })
    
    );
  }
}

class DataCard extends StatelessWidget {
  final String languageName, languageDesc, languageImg;
  DataCard({required this.languageName, required this.languageDesc, required this.languageImg});
  //const DataCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Row(children: [
          CachedNetworkImage(imageUrl: languageImg,height: 80, width: 80, fit: BoxFit.fill,),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(languageName + "Language", style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,);
              SizedBox(
                height: 8,

              ),
              Container(
                width: 230,
                child: Text(
                  languageDesc,
                  maxLines: 20,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              )
            ],

          )

        ],),
      ),

      
    );
  }
}

class DataModel{

  DataModel({
    required languageName,
    required languageImg,
    required languageDesc,
  });
  String.languageName;
  String.languageImg;
  String.languageDesc;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    languageName: json['languageName'],
    languageDesc: json['languageDesc'],
    languageImg: json['languageImg'],
  );


}

