import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/vocabulary_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VocabularyDetailScreen extends StatefulWidget{
  _VocabularyDetailState createState() => _VocabularyDetailState();
}

class _VocabularyDetailState extends State<VocabularyDetailScreen>{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        title: Text('24 Vocabulary of Greetings', style: GoogleFonts.ubuntu(fontSize: 22),),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              height: SizeConfig.blockSizeVertical * 81,
              child: ListView(
                children: <Widget>[
                  VocabularyCard(),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                  VocabularyCard(),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                  VocabularyCard(),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                  VocabularyCard(),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                  VocabularyCard(),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                  VocabularyCard(),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,)
                ],
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: CupertinoButton(
                  color: Color.fromRGBO(30, 193, 194, 30),
                  child: Text("Practice"),
                  onPressed: () {
                      Navigator.pushNamed(context, '/practicevocabulary');
                  }),
            ),
          ],
        )
      ),
    );
  }

}