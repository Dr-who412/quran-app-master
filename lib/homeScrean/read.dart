import 'package:quran/quran.dart'as quran;
import 'package:flutter/material.dart';
class read extends StatefulWidget {
  final index_cr;
  const read(this.index_cr, {Key? key,}) : super(key: key);

  @override
  State<read> createState() => _readState();
}

class _readState extends State<read> {
var navI=1;
  @override
  Widget build(BuildContext context) {
    print(quran.getSurahPages(1));
    print(quran.getSurahCountByPage(1));
    return  Scaffold(
      appBar: AppBar(
        title: Text(quran.getSurahName(widget.index_cr)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: quran.getVerseCount(navI),
            itemBuilder: (context, index) {
              return Text(
                    quran.getVerse(widget.index_cr, index + 1, verseEndSymbol: true),
                    textAlign: TextAlign.right,

                );
            },
          ),
        ),
      )
    );
  }
}
