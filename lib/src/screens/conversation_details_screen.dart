import 'package:bubble/bubble.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

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
                Text(vietnamese, style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),),
                Text(english, style: GoogleFonts.lato(),)
              ],
            ),
          ),
        ),
        // CircleAvatar(
        //   backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        //   radius: 20,
        //   child: IconButton(
        //     padding: EdgeInsets.zero,
        //     icon: Icon(CupertinoIcons.play_arrow_solid),
        //     color: Colors.white,
        //     onPressed: () {
        //       print("play");
        //     },
        //   ),
        // ),
        GFIconButton(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
          onPressed: (){
            print('hear');
          },
          color: Color.fromRGBO(30, 193, 194, 30),
          icon: Icon(CupertinoIcons.ear),
          shape: GFIconButtonShape.circle,
        )
      ],
    );
  }

  Widget _rightBubble(String vietnamese, String english){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GFIconButton(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
          onPressed: (){
            print('hear');
          },
          color: Color.fromRGBO(30, 193, 194, 30),
          icon: Icon(CupertinoIcons.ear),
          shape: GFIconButtonShape.circle,
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
                Text(english, style: GoogleFonts.lato(color: Colors.white),)
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
    final args = ModalRoute.of(context).settings.arguments as ConversationDetailScreenArguments;
    HiveList conversations = args.conversations;
    List<ConversationLocal> conversationLocal = [];
    for(var item in conversations){
      conversationLocal.add(item);
    }
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        backgroundColor: Colors.white,
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(args.title, style: GoogleFonts.lato(fontSize: 22, color: Colors.black),),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 24,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/demo_conversation.png'),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 55,
              child: ListView.separated(
                itemCount: conversationLocal.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                itemBuilder: (context, index) {
                  if(index % 2 == 0){
                   return _leftBubble(conversationLocal[index].conversation, conversationLocal[index].description);
                  }else{
                    return _rightBubble(conversationLocal[index].conversation, conversationLocal[index].description);
                  }
                },
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

class ConversationDetailScreenArguments{
  final HiveList conversations;
  final String title;
  ConversationDetailScreenArguments(this.conversations, this.title);

}