import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/lesson_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class VNlearnScreen extends StatefulWidget {
  _VNlearnScreenState createState() => _VNlearnScreenState();
}

class _VNlearnScreenState extends State<VNlearnScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 244, 244, 10),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        //leadingWidth: SizeConfig.blockSizeHorizontal * 10,
        automaticallyImplyLeading: true,
        //leading: Text('Learn Vietnamese', style: GoogleFonts.ubuntu(fontSize: 22),),
        title: Text(
          'Learn Vietnamese',
          style: GoogleFonts.lato(fontSize: 22),
        ),
        actions: [
          InkWell(
            child: Icon(CupertinoIcons.search),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
        child: ListView(
          children: <Widget>[
            LessonCard(
              vocabularyAction: () {
                Navigator.pushNamed(context, '/vocabularyDetails');
              },
              conversationAction: (){
                Navigator.pushNamed(context, '/conversationDetails');
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            LessonCard(
              vocabularyAction: () {
                Navigator.pushNamed(context, '/vocabularyDetails');
              },
              conversationAction: (){
                Navigator.pushNamed(context, '/conversationDetails');
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            LessonCard(
              vocabularyAction: () {
                Navigator.pushNamed(context, '/vocabularyDetails');
              },
              conversationAction: (){
                Navigator.pushNamed(context, '/conversationDetails');
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            LessonCard(
              vocabularyAction: () {
                Navigator.pushNamed(context, '/vocabularyDetails');
              },
              conversationAction: (){
                Navigator.pushNamed(context, '/conversationDetails');
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            LessonCard(
              vocabularyAction: () {
                Navigator.pushNamed(context, '/vocabularyDetails');
              },
              conversationAction: (){
                Navigator.pushNamed(context, '/conversationDetails');
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            LessonCard(
              vocabularyAction: () {
                Navigator.pushNamed(context, '/vocabularyDetails');
              },
              conversationAction: (){
                Navigator.pushNamed(context, '/conversationDetails');
              },
            ),
          ],
        ),
      ),
    );
  }
}
