import 'package:bubble/bubble.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversationDetailScreen extends StatefulWidget{
  _ConversationDetailState createState() => _ConversationDetailState();
}

class _ConversationDetailState extends State<ConversationDetailScreen> {
  Widget _leftBubble(String vietnamese, String english){
    return Row(
      children: [
        Bubble(
          radius: Radius.circular(10),
          color: Color.fromRGBO(233, 233, 235, 30),
          elevation: 0.5,
          margin: BubbleEdges.only(top: 10),
          nip: BubbleNip.leftBottom,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(vietnamese, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                Text(english)
              ],
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Color.fromRGBO(30, 193, 194, 30),
          radius: 20,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(CupertinoIcons.play_arrow_solid),
            color: Colors.white,
            onPressed: () {
              print("play");
            },
          ),
        ),
      ],
    );
  }

  Widget _rightBubble(String vietnamese, String english){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          backgroundColor: Color.fromRGBO(30, 193, 194, 30),
          radius: 20,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(CupertinoIcons.play_arrow_solid),
            color: Colors.white,
            onPressed: () {
              print("play");
            },
          ),
        ),
        Bubble(
          radius: Radius.circular(10),
          color: Color.fromRGBO(0, 155, 255, 30),
          elevation: 0.5,
          margin: BubbleEdges.only(top: 10),
          nip: BubbleNip.rightBottom,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(vietnamese, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                Text(english, style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        title: Text('Conversation of Greetings', style: GoogleFonts.ubuntu(fontSize: 22),),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 24,
                image: AssetImage('assets/images/demo_conversation.png'),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 55,
              child: ListView(
                children: <Widget>[
                  _leftBubble(' Hi Jason, Sorry to bother you. I have a question for you.', 'Chào Jason, xin lỗi vì đã làm phiền bạn. Nhưng tôi muốn hỏi bạn một câu.'),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                  _rightBubble('OK, what’s up?', 'Được chứ, có chuyện gì vậy?')
                ],
              ),
            ),
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
        ),
      ),
    );
  }
}