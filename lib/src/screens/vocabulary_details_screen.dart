import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/screens/practice_vocabulary_screen.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:expat_assistant/src/widgets/vocabulary_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VocabularyDetailScreen extends StatefulWidget {
  _VocabularyDetailState createState() => _VocabularyDetailState();
}

class _VocabularyDetailState extends State<VocabularyDetailScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  HiveUtils _hiveUtils = HiveUtils();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args = ModalRoute.of(context).settings.arguments
        as VocabularyDetailsScreenArguments;
    List<VocabularyLocal> vocabularyList = args.vocabularyList;
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 244, 244, 10),
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          args.title,
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
            height: SizeConfig.blockSizeVertical * 79.3,
            child: ListView.separated(
              itemCount: vocabularyList.length,
              separatorBuilder: (context, index) => SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              itemBuilder: (context, index) => VocabularyCard(
                vietnamese: vocabularyList[index].vocabulary,
                english: vocabularyList[index].description,
                imageLink: vocabularyList[index].imageLink,
                playAudio: () {
                  if (vocabularyList[index].voiceLink != null) {
                    String filePath = _hiveUtils
                        .getFilePath(
                            boxName: HiveBoxName.LESSON_SRC,
                            key: vocabularyList[index].voiceLink)
                        .srcPath;
                    assetsAudioPlayer.open(
                      Audio.file(filePath),
                    );
                  }
                },
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
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
                                EdgeInsets.all(
                                    SizeConfig.blockSizeHorizontal * 4)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.MAIN_COLOR),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                GoogleFonts.lato(fontSize: 17))),
                        child: Text("Practice"),
                        onPressed: () {
                          print('object');
                          Navigator.pushNamed(
                              context, RouteName.PRACTICE_VOCABULARY,
                              arguments: PracticeVocabularyScreenArguments(
                                  vocabularyList));
                        }),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class VocabularyDetailsScreenArguments {
  final String title;
  final List<VocabularyLocal> vocabularyList;

  VocabularyDetailsScreenArguments({this.title, this.vocabularyList});
}
