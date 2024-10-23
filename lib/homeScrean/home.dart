import 'dart:convert';

import 'package:Quran/homeScrean/almoshf.dart';
import 'package:Quran/homeScrean/azkar.dart';
import 'package:Quran/model/section_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();

}

class _homeState extends State<home> {
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
   int? _index=0;
  double? precent=0;
    int? num_tasbeh=0;
List<SectionModel> sections=[];
  void loadIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      precent = (prefs.getDouble('precent') ?? 0.0);
      _index = (prefs.getInt('current') ?? 0);
      num_tasbeh=(prefs.getInt('tasbeh')??0);
    });
  }
  void _changeIndex(int i,bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
     if (state) {_index = i;
      prefs.setInt('current', _index!);}else{
      precent =precent!+0.01;
      if (precent! >.9){
        precent=0.0;
        num_tasbeh=num_tasbeh!+1;
        prefs.setInt('tasbeh',num_tasbeh!);
      }
      prefs.setDouble('precent', precent!);}
    });
  }

   loadSections() async {
     DefaultAssetBundle.of(context)
         .loadString("assets/sections_db.json")
         .then((data) {
       var response = json.decode(data);
       response.forEach((section) {
         SectionModel _section = SectionModel.fromJson(section);
         sections.add(_section);
       });
       setState(() {});
     }).catchError((error) {
       print(error);
     });
   }


  GlobalKey<ScaffoldState>scaff=new GlobalKey<ScaffoldState>();
  ScrollController scrollController=ScrollController();
  List <String>surasNames=[];
  @override
  void initState() {
    // TODO: implement initState
    loadIndex();
    loadSections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(19, 27, 84,1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(19, 27, 84,1),
        title: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(45)),
          child: Text("home"),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Color.fromRGBO(19, 27, 84,1),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),

            Expanded(
                flex: 11,
                child: ListView.builder(
                  itemCount: quran.totalSurahCount,
                  itemBuilder: (context, int i) {
                   // surasNames.add("${quran.getSurahNameArabic(i+1)}");
                    return InkWell(
                        onLongPress: (){
                          var oldIndex=_index;
                          _changeIndex(i+1,true);
                          var snackbar=SnackBar(content: Row(children: [
                           Icon(Icons.warning_amber, color:Color.fromRGBO(238, 229, 212, 1) ,),
                           Text("changing mark !!?",style: TextStyle(color: Color.fromRGBO(238, 229, 212, 1)),)],)
                           ,duration: Duration(seconds: 2,milliseconds: 00),
                            onVisible: (){ _changeIndex(i+1,true);},behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              disabledTextColor: Colors.white,
                              label: "undo",
                              onPressed: () {_changeIndex(oldIndex!,true);  },
                            ),
                           );
                           ScaffoldMessenger.of(context).showSnackBar(snackbar);
                           Navigator.pop(context);
                         // scaff.currentState?.showSnackBar(snackbar);
                          },
                    splashColor:Color.fromRGBO(238, 229, 212, 1) ,
                    onTap: () {
                    print("go to read screan");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return almoshf(
                    i.toDouble()+1
                    , _index!);
                    }));
                    },
                    borderRadius: BorderRadius.circular(17),
                    child:listItem((i + 1).toDouble(), quran.getSurahNameArabic(i + 1),
                        quran.getVerseCount(i + 1).toString(),_index==i+1?true:false,)
                    );
                  },
                )

            ),

          ],
        ),
      ),
      body: PageView(children: [
        Container(color: Color.fromRGBO(238, 229, 212, 1) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            new CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 10.0,
              percent: precent!,
              animation: true,
              curve: Curves.easeInOutCubicEmphasized,
              animationDuration: 1900,
           //   circularStrokeCap:CircularStrokaCap.butt,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${(precent!*100).toInt()}",style: TextStyle(fontSize: 22,color:Color.fromRGBO(19, 27, 84,1),fontWeight: FontWeight.bold ),),
                  new Icon(Icons.all_inclusive,color:Color.fromRGBO(19, 27, 84,1),),
                ],
              ),
              header: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_circle_up,color:Color.fromRGBO(19, 27, 84,1),),
                  Text("$num_tasbeh x99",style: TextStyle(fontSize: 40,color:Color.fromRGBO(19, 27, 84,1),),),
                ],
              ),
              progressColor: Color.fromRGBO(19, 27, 84,1),
            ),

            ElevatedButton(onPressed: (){
              _changeIndex(_index!,false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:Color.fromRGBO(19, 27, 84,1) ,
              minimumSize: Size(100, 68),
              foregroundColor: Color.fromRGBO(19, 27, 84,1),
        
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      ),
 
              child: Icon(Icons.add,
               color: Color.fromRGBO(238, 229, 212, 1) ,
                ),
            )

          ],
        ),
        ),

    Container(
      color:Color.fromRGBO(238, 229, 212, 1)  ,
      child: CustomScrollView(
      slivers: [
      SliverList(
      delegate: SliverChildBuilderDelegate(
       (context, i) =>
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Azkar(id:sections[i].id,name: sections[i].name,);
          }));
          
        },
                    style: ElevatedButton.styleFrom(
              backgroundColor:Color.fromRGBO(19, 27, 84,1),
              minimumSize: Size(85, 80),
              foregroundColor: Color.fromRGBO(19, 27, 84,1),
        
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      ),
                // height: 80,
                // minWidth: 85,
                // splashColor: Color.fromRGBO(19, 27, 84,1),
                // shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                // color:Color.fromRGBO(19, 27, 84,1),
               child:
        Text("${sections[i].name}",style: TextStyle(color: Color.fromRGBO(238, 229, 212, 1) , fontSize: 22),),
             ),
      ),
      childCount: sections.length,
      ),
      )
      ],
      ),
    ),



      ],
      ),

    );
  }
}


class listItem extends StatelessWidget {
  final double i;
  final quranitem;
  final num_vers;
  final saved;
  const listItem(
    this.i,
    this.quranitem,
    this.num_vers,
  this.saved,
  );

  @override
  Widget build(BuildContext context) {
    print(quranitem);
    return  Card(
          margin: EdgeInsets.all(8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          shadowColor: Color.fromRGBO(19, 27, 84,1),
          color: Color.fromRGBO(238, 229, 212, 1) ,
          child: Stack(
            children:[ Container(
              padding: EdgeInsets.only(
                right: 8,
              ),
              margin: EdgeInsets.only(left: 22, right: 2),
              width: double.infinity,
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text(
                      num_vers,
                      style: TextStyle(color: Colors.black),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(46)),
                  )),
                  Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 24,
                        child: quran.getPlaceOfRevelation(i.toInt())=="Makkah"?
                        Text("مدنيه",style: TextStyle(fontWeight: FontWeight.bold),)
                            : Text("مكيه",style: TextStyle(fontWeight: FontWeight.bold),),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(46)),
                      )),
                  Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          " ${quranitem} ",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      )),

                  //item_bottom_bar(fav stare Icon ,text :number of ayat,kind(makya or madanya
                ],
              ),
              // ),
            ),
            Container(
              height: 60,
              width: 16,
              padding: EdgeInsets.only(top: 1,left: 5),
              alignment: Alignment.topLeft,
              //color: Color.fromRGBO(238, 229, 212, 1),
              child: saved?Icon(Icons.bookmark,color:Color.fromRGBO(19, 27, 84,1),size: 20, ):null,
            )
            ]
          ),
        );
  }
}

