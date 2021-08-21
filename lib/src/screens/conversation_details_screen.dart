import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bubble/bubble.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/screens/practice_conversation_screen.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ConversationDetailScreen extends StatefulWidget {
  _ConversationDetailState createState() => _ConversationDetailState();
}

class _ConversationDetailState extends State<ConversationDetailScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  HiveUtils _hiveUtils = HiveUtils();
  Widget _leftBubble(String vietnamese, String english, String voiceLink) {
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
                Text(
                  vietnamese,
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  english,
                  style: GoogleFonts.lato(),
                )
              ],
            ),
          ),
        ),
        GFIconButton(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
          onPressed: () {
            if (voiceLink != null) {
              String filePath = _hiveUtils
                  .getFilePath(boxName: HiveBoxName.LESSON_SRC, key: voiceLink)
                  .srcPath;
              assetsAudioPlayer.open(
                Audio.file(filePath),
              );
            }
          },
          color: AppColors.MAIN_COLOR,
          icon: Icon(Ionicons.volume_medium_outline),
          shape: GFIconButtonShape.circle,
        )
      ],
    );
  }

  Widget _rightBubble(String vietnamese, String english, String voiceLink) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GFIconButton(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
          onPressed: () {
            if (voiceLink != null) {
              String filePath = _hiveUtils
                  .getFilePath(boxName: HiveBoxName.LESSON_SRC, key: voiceLink)
                  .srcPath;
              assetsAudioPlayer.open(
                Audio.file(filePath),
              );
            }
          },
          color: AppColors.MAIN_COLOR,
          icon: Icon(Ionicons.volume_medium_outline),
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
                Text(
                  vietnamese,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  english,
                  style: GoogleFonts.lato(color: Colors.white),
                )
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
    final args = ModalRoute.of(context).settings.arguments
        as ConversationDetailScreenArguments;
    List<ConversationLocal> conversationLocal = args.conversations;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          args.title,
          style: GoogleFonts.lato(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26.withOpacity(0.2),
                    offset: Offset(0.0, 6.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.10)
              ]),
          height: SizeConfig.blockSizeVertical * 9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 80,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.MAIN_COLOR),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            GoogleFonts.lato(fontSize: 17))),
                    child: Text("Practice"),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteName.PRACTICE_CONVERSATION,
                          arguments: PracticeConversationScreenArguments(
                              conversationLocal));
                    }),
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: ExtendedImage.network(
                conversationLocal.first.imageLink,
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 24,
                fit: BoxFit.scaleDown,
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 54.5,
              child: ListView.separated(
                itemCount: conversationLocal.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    return _leftBubble(
                        conversationLocal[index].conversation,
                        conversationLocal[index].description,
                        conversationLocal[index].voiceLink);
                  } else {
                    return _rightBubble(
                        conversationLocal[index].conversation,
                        conversationLocal[index].description,
                        conversationLocal[index].voiceLink);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConversationDetailScreenArguments {
  final List<ConversationLocal> conversations;
  final String title;
  ConversationDetailScreenArguments(this.conversations, this.title);
}
