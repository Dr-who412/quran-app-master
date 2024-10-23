import 'package:Quran/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart'as quran;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
class almoshf extends StatefulWidget {
   final double currentIndex;
   final int savedIndex;
  const almoshf(this.currentIndex, this.savedIndex,{Key? key}) : super(key: key);

  @override
  State<almoshf> createState() => _almoshfState();
}

class _almoshfState extends State<almoshf> {

   final ItemScrollController itemsc=ItemScrollController();
  _almoshfState();
  @override
  void initState() {
    setState(() {
      print("scrolled");
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  var showdetals=false;
  GlobalKey<ScaffoldState> scaffKay=new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(19, 27, 84,1),
      body: Stack(
        children: [ScrollablePositionedList.builder(
           //  itemScrollController: itemsc,
          initialScrollIndex: widget.currentIndex.toInt()-1,
            itemCount: quran.totalSurahCount.toInt(),
            itemBuilder: (Context,sura_index){
              String suraVerses='';
              var length= quran.getVerseCount(sura_index+1);
              for(int i=1;i<=length;i++) {
                suraVerses=suraVerses+quran.getVerse(sura_index+1,i,verseEndSymbol:true);
              }
              suraVerses=suraVerses.toString();
              print(suraVerses);
              return GestureDetector(
                onLongPressCancel: (){
                 var snackBar=SnackBar(
                     width:160,
                     duration: Duration(seconds: 1,microseconds: 30),
                     behavior: SnackBarBehavior.floating,
                     backgroundColor:Color.fromRGBO(19, 27, 84,.5) ,
                     content: Container(
                       height: 50,
                       color: Colors.black12,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:[
                           Text("${quran.getSurahNameArabic(sura_index+1)}",
                             style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                           ),
                           Text("${quran.getJuzNumber(sura_index+1,2)} الجزء",
                             style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                           )
                         ], ),));
                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    showdetals=true;
                    print("ok");
                  Duration(seconds: 2);
                  print("okkkkay");
                    showdetals=false;
                  });
                },
                onDoubleTap: (){
                  var snackBar=SnackBar(
                      width:160,
                      duration: Duration(seconds: 1,microseconds: 30),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor:Color.fromRGBO(19, 27, 84,.5) ,
                      content: Container(
                        height: 50,
                        color: Colors.black12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text("${quran.getSurahNameArabic(sura_index+1)}",
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                            ),
                            Text("${quran.getJuzNumber(sura_index+1,2)} الجزء",
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                            )
                          ], ),));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                onTap: (){
                  var snackBar=SnackBar(
                      width:160,
                      duration: Duration(seconds: 1,microseconds: 30),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor:Color.fromRGBO(19, 27, 84,.5) ,
                      content: Container(
                        height: 50,
                        color: Colors.black12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text("${quran.getSurahNameArabic(sura_index+1)}",
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                            ),
                            Text("${quran.getJuzNumber(sura_index+1,2)} الجزء",
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                            )
                          ], ),));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                onLongPress: (){
                 var snackbar_savemark=SnackBar(content:  Card(color: Colors.white,),
                 width: 200,
                   elevation: 12,
                   duration: Duration(seconds: 5),
                   behavior: SnackBarBehavior.floating,

                 ) ;
                  var snackBar=SnackBar(
                      width:160,
                      duration: Duration(seconds: 1,microseconds: 30),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor:Color.fromRGBO(19, 27, 84,.5) ,
                      content: Container(
                        height: 50,
                        color: Colors.black12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text("${quran.getSurahNameArabic(sura_index+1)}",
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                            ),
                            Text("${quran.getJuzNumber(sura_index+1,2)} الجزء",
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                            )
                          ], ),));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                 ScaffoldMessenger.of(context).showSnackBar(snackbar_savemark);
                },
                child: Card(
                  borderOnForeground: true,
                  color:Color.fromRGBO(238, 229, 212, 1),
                  margin: EdgeInsets.only(top: 2,bottom:1,right: 6,left: 6),
                 shadowColor:  Color.fromRGBO(19, 27, 84,1),
                  child:Stack(
                    children:[
                     SafeArea(
                       top: false,
                     left: true,
                     right: true,
                     child: Container(
                       
                         child: Column(
                           children: [
                             Container(
                               color: Colors.black12,
                                 width:double.infinity,
                                 height: 70,
                                 child: Stack(
                                   children: [
                                     Image.asset('images/images.jpg',
                                       width: double.infinity,
                                       height: double.infinity,
                                       fit: BoxFit.fill,
                                     ),
                                     Center(
                                         child: Text(quran.getSurahNameArabic(sura_index+1)
                                           ,style: TextStyle(fontWeight: FontWeight.bold,
                                             fontSize: 30,overflow: TextOverflow.visible,),)
                                     ),

                                   ],
                             )),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 if (widget.savedIndex==sura_index+1)
                                   IconButton(onPressed: (){},
                                       splashColor: Color.fromRGBO(
                                           239, 109, 109, 1.0),
                                       color: Colors.redAccent,
                                       highlightColor: Color.fromRGBO(
                                           239, 109, 109, 1.0),
                                       icon:  Icon(Icons.bookmark, size:50 ,

                                       color: Color.fromRGBO(19, 27, 84,1),
                                     )
                                 ) else IconButton(onPressed: (){},
                                   icon:  Icon(Icons.bookmark_border_outlined, size:50 ,
                                  color: Color.fromRGBO(238, 229, 212, 1),
                                  ),),
                                 Text(quran.basmala,style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                                 SizedBox(width: 12,)
                               ],
                             ),
                             Container(
                               padding: EdgeInsets.all(14),
                               child: Text(suraVerses,
                                 style: TextStyle(fontSize:14,fontWeight:FontWeight.w800,overflow: TextOverflow.clip,),
                                 textAlign: TextAlign.center,
                                 strutStyle: StrutStyle(leadingDistribution: TextLeadingDistribution.even),
                               ),
                             ),
                           ],
                         )
                     ),
                   ),

                   ],
                 ),
          ),
              );
        }),
       // showdetals? Center(child: Container(color: Colors.black, width: 80,height: 40,)) :Container(),
     ],
      )
    );
  }
}
class suraData extends StatelessWidget {
  final surain;
  const suraData({Key? key, this.surain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
          itemBuilder: (context, index) {
            return Text(
              quran.getVerse(surain, index + 1, verseEndSymbol: true),
              textAlign: TextAlign.right,

            );
          },
      ),
    );
  }
}
