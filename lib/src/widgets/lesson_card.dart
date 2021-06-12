import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonCard extends StatelessWidget {
  final Function vocabularyAction;
  final Function conversationAction;

  const LessonCard(
      {@required this.vocabularyAction, @required this.conversationAction});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 3,
          bottom: SizeConfig.blockSizeVertical * 2,
          left: SizeConfig.blockSizeHorizontal * 2,
          right: SizeConfig.blockSizeHorizontal * 3),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black26.withOpacity(0.1),
                offset: Offset(0.0, 6.0),
                blurRadius: 10.0,
                spreadRadius: 0.10)
          ]),
      child: ExpansionTile(
        leading: Image(
          image: AssetImage('assets/images/demo_lesson.png'),
        ),
        title: Text(
          'Greetings',
          style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('24 vocabularies/15 sentences', style: GoogleFonts.lato(),),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                //                   <--- left side
                color: Colors.black26,
                width: 0.5,
              ),
              bottom: BorderSide(
                //                   <--- left side
                color: Colors.black26,
                width: 0.5,
              ),
            )),
            child: ListTile(
              onTap: vocabularyAction,
              leading: Image(
                width: SizeConfig.blockSizeHorizontal * 10,
                height: SizeConfig.blockSizeVertical * 10,
                image: AssetImage('assets/images/vocabulary_icon.png'),
              ),
              title: Text('Vocabulary', style: GoogleFonts.lato(),),
              trailing: IconButton(
                icon: Icon(CupertinoIcons.square_arrow_down),
                onPressed: (){
                  print('download');
                },
              ),
            ),
          ),
          ListTile(
            onTap: conversationAction,
            leading: Image(
              width: SizeConfig.blockSizeHorizontal * 10,
              height: SizeConfig.blockSizeVertical * 10,
              image: AssetImage('assets/images/conversation_icon.png'),
            ),
            title: Text('Conversation', style: GoogleFonts.lato(),),
            trailing: IconButton(
              icon: Icon(CupertinoIcons.square_arrow_down),
              onPressed: (){
                print('download');
              },
            ),
          )
        ],
      ),
    );
  }
}
