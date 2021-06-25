import 'dart:typed_data';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/vocabulary_practice_listening_cubit.dart';
import 'package:expat_assistant/src/models/character_description.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/states/vocabulary_practice_listening_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/tau.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sweetsheet/sweetsheet.dart';

// ignore: must_be_immutable
class VocabularyPracticeListening extends StatefulWidget {
  VocabularyLocal vocabulary;
  Function openSpeaking;
  BuildContext upperContext;

  VocabularyPracticeListening(
      {@required this.vocabulary, @required this.openSpeaking, @required this.upperContext});

  _VocabularyPracticeListeningState createState() =>
      _VocabularyPracticeListeningState(vocabulary, openSpeaking, upperContext);
}

class _VocabularyPracticeListeningState
    extends State<VocabularyPracticeListening> {
  VocabularyLocal _vocabulary;
  Function openSpeaking;
  BuildContext upperContext;
  String _learnerAns = "";
  List<CharacterDescription> chars = [];
  final SweetSheet _sweetSheet = SweetSheet();
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  HiveUtils _hiveUtils = HiveUtils();
  bool _mPlayerIsInit = false;
  Icon soundIcon = Icon(CupertinoIcons.play_arrow_solid);
  String soundText = "Tap to listen";

  _VocabularyPracticeListeningState(this._vocabulary, this.openSpeaking, this.upperContext);

  Widget _character(
      {@required CharacterDescription characterDescription,
      @required BuildContext context}) {
    return InkWell(
      onTap: () {
        if (characterDescription.canChoose == true) {
          BlocProvider.of<VocabularyPracticeListeningCubit>(context)
              .addCharacters(characterDescription);
        }
      },
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 10,
        height: SizeConfig.blockSizeVertical * 6,
        child: Center(
          child: Text(
            characterDescription.char,
            style: GoogleFonts.lato(
                color: characterDescription.fontColor,
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
        ),
        decoration: BoxDecoration(
            color: characterDescription.background,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26.withOpacity(0.05),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.10)
            ]),
      ),
    );
  }

  void closeAudioSession() {
    stopAudio();
    _mPlayer.closeAudioSession();
    _mPlayer = null;
  }

  void stopAudio() async {
    if (_mPlayer != null) {
      await _mPlayer.stopPlayer();
    }
  }

  void playAudio() async {
    print(_hiveUtils.getFilePath(boxName: HiveBoxName.LESSON_SRC, key: _vocabulary.voiceLink).srcPath);
    await _mPlayer.startPlayer(
        fromURI: _hiveUtils.getFilePath(boxName: HiveBoxName.LESSON_SRC, key: _vocabulary.voiceLink).srcPath,
        codec: Codec.mp3,
        whenFinished: () {
          setState(() {});
        });
  }

  getPlaybackFn() {
    if (!_mPlayerIsInit) {
      return null;
    }
    return _mPlayer.isStopped ? playAudio() : stopAudio();
  }

  @override
  void dispose() {
    closeAudioSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          VocabularyPracticeListeningCubit()..loadCharacters(_vocabulary.vocabulary),
      child: BlocConsumer<VocabularyPracticeListeningCubit,
          VocabularyPracticeListeningState>(
        listener: (context, state) {
          if (state is AddCharacter) {
            _learnerAns += state.char.char;
            for (CharacterDescription char in chars) {
              if (char.index == state.char.index) {
                char.background = Colors.black12;
                char.fontColor = Colors.grey;
                char.canChoose = false;
              }
            }
          } else if (state is CorrectAnswer) {
            _sweetSheet.show(
              isDismissible: false,
              context: context,
              title: Text("Correct", style: GoogleFonts.lato(),),
              description: Text('${_vocabulary.vocabulary.toUpperCase()}' +
                  '\nEnglish meaning: ${_vocabulary.description}',style: GoogleFonts.lato()),
              color: SweetSheetColor.SUCCESS,
              icon: CupertinoIcons.check_mark_circled_solid,
              positive: SweetSheetAction(
                onPressed: () {
                  openSpeaking(upperContext);
                  Navigator.of(context).pop();
                },
                title: 'NEXT',
                icon: CupertinoIcons.arrow_right_circle_fill,
              ),
            );
          } else if (state is IncorrectAnswer) {
            _sweetSheet.show(
              isDismissible: false,
              context: context,
              title: Text("Incorrect", style: GoogleFonts.lato()),
              description: Text('${_vocabulary.vocabulary.toUpperCase()}' +
                  '\nEnglish meaning: ${_vocabulary.description}', style: GoogleFonts.lato()),
              color: SweetSheetColor.DANGER,
              icon: CupertinoIcons.xmark_circle_fill,
              positive: SweetSheetAction(
                onPressed: () {
                  BlocProvider.of<VocabularyPracticeListeningCubit>(context)
                      .loadCharacters(_vocabulary.vocabulary);
                  Navigator.of(context).pop();
                },
                title: 'DO AGAIN',
                icon: CupertinoIcons.arrow_counterclockwise,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is Loaded ||
              state is AddCharacter ||
              state is IncorrectAnswer ||
              state is CorrectAnswer) {
            if (state is Loaded) {
              _learnerAns = '';
              chars.clear();
              int index = 0;
              for (var char in state.chars) {
                index = index + 1;
                CharacterDescription characterDescription =
                    new CharacterDescription(
                        char: char,
                        background: Colors.white,
                        fontColor: Colors.black,
                        canChoose: true,
                        index: index);
                chars.add(characterDescription);
              }
              _mPlayer.openAudioSession().then((value) => {
                    _mPlayerIsInit = true,
                  });
            }
            return Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  right: SizeConfig.blockSizeHorizontal * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Listen and correct the vocabulary',
                    style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: AppColors.MAIN_COLOR,
                        radius: 25,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: _mPlayer.isPlaying ? Icon(CupertinoIcons.stop_fill) : Icon(Ionicons.volume_medium_outline),
                          color: Colors.white,
                          onPressed: () {
                            getPlaybackFn();
                          },
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      Text(
                        _mPlayer.isPlaying ? 'Listening...': 'Tap to listen',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 13,
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<VocabularyPracticeListeningCubit>(
                                  context)
                              .loadCharacters(_vocabulary.vocabulary);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.MAIN_COLOR,
                            borderRadius: BorderRadius.circular(10.0),
                            //borderSide: new BorderSide(color: Colors.black12)
                          ),
                          width: SizeConfig.blockSizeHorizontal * 22,
                          height: SizeConfig.blockSizeVertical * 5,
                          child: Center(
                            child: Text(
                              'Reset',
                              style: GoogleFonts.lato(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                      height: SizeConfig.blockSizeVertical * 20,
                      width: SizeConfig.blockSizeHorizontal * 90,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10.0),
                        //borderSide: new BorderSide(color: Colors.black12)
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                        child: Text(
                          _learnerAns,
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        ),
                      )),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 30,
                    width: SizeConfig.blockSizeHorizontal * 85,
                    child: Center(
                      child: GridView.count(
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        crossAxisCount: 5,
                        children: List.generate(
                            chars.length,
                            (index) => _character(
                                characterDescription: chars[index],
                                context: context)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Center(
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 85,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty
                                  .all<EdgeInsets>(EdgeInsets.all(
                                  SizeConfig.blockSizeHorizontal * 4)),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  AppColors.MAIN_COLOR),
                              textStyle:
                              MaterialStateProperty.all<TextStyle>(
                                  GoogleFonts.lato(fontSize: 17))),
                          //: Color.fromRGBO(30, 193, 194, 30),
                          child: Text("Check"),
                          onPressed: () {
                            openSpeaking(upperContext);
                          }),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
