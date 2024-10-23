import 'dart:convert';

import 'package:Quran/model/section_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Azkar extends StatefulWidget {
  late var id;
  late var name;
  Azkar({Key? key,required this.id,required this.name}) : super(key: key);
  @override
  State<Azkar> createState() => _AzkarState();
}

class _AzkarState extends State<Azkar> {
  List<SectionDetailModel> sectiondb=[];
  loadAzkat(int id){
    DefaultAssetBundle.of(context).loadString("assets/section_details_db.json").
      then((data) {
      var response = json.decode(data);
      response.forEach((sectiondata) {
      SectionDetailModel _sectiondata = SectionDetailModel.fromJson(sectiondata);
      if (_sectiondata.sectionId==id){
        sectiondb.add(_sectiondata);
      }
      });
      setState(() {});
      }).catchError((error) {
      print(error);
      });
  }
  @override
  void initState() {
    // TODO: implement initState
    loadAzkat(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) { return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(19, 27, 84,1),
      title: Text(widget.name,style: TextStyle(color:  Color.fromRGBO(238, 229, 212, 1),),),
    ),
    body:ListView.builder(
        itemCount: sectiondb.length,
        itemBuilder: (context,int i){
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            color: Color.fromRGBO(19, 27, 84,1),
            child: ListTile(
              contentPadding: EdgeInsets.all(8),

                title: Text("${sectiondb[i].reference!}",textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                textColor:  Color.fromRGBO(238, 229, 212, 1),
                subtitle:Text("${sectiondb[i].content!}",style: TextStyle(color: Color.fromRGBO(238, 229, 212, 1) , fontSize: 15),textDirection: TextDirection.rtl,),
          )
            );
        }) ,
  );
  }
}






