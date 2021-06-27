import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/conversation_practice_listening_cubit.dart';
import 'package:expat_assistant/src/models/character_description.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/states/conversation_practice_listening_state.dart';
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
class ConversationPracticeListening extends StatefulWidget {
  ConversationLocal conversation;
  Function openSpeaking;

  ConversationPracticeListening({this.conversation, this.openSpeaking});

  _ConversationPracticeListeningState createState() =>
      _ConversationPracticeListeningState(conversation, openSpeaking);
}

class _ConversationPracticeListeningState
    extends State<ConversationPracticeListening> {
  ConversationLocal conversation;
  Function openSpeaking;
  String _learnerAns = "";
  List<CharacterDescription> words = [];
  final SweetSheet _sweetSheet = SweetSheet();
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  HiveUtils _hiveUtils = HiveUtils();
  bool _mPlayerIsInit = false;

  _ConversationPracticeListeningState(this.conversation, this.openSpeaking);

  Widget _character(
      {@required CharacterDescription character,
      @required BuildContext context}) {
    return InkWell(
      onTap: () {
        if (character.canChoose == true) {
          if (character.canChoose == true) {
          BlocProvider.of<ConversationPracticeListeningCubit>(context)
              .addCharacters(character);
        }
        }
      },
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 10,
        height: SizeConfig.blockSizeVertical * 6,
        child: Center(
          child: Text(
            character.char,
            style: GoogleFonts.lato(
                color: character.fontColor,
                fontWeight: FontWeight.w600,
                fontSize: 15),
          ),
        ),
        decoration: BoxDecoration(
            color: character.background,
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
    print(_hiveUtils
        .getFilePath(
            boxName: HiveBoxName.LESSON_SRC, key: conversation.voiceLink)
        .srcPath);
    await _mPlayer.startPlayer(
      fromURI: _hiveUtils
          .getFilePath(
              boxName: HiveBoxName.LESSON_SRC, key: conversation.voiceLink)
          .srcPath,
      codec: Codec.mp3,
    );
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
      create: (context) => ConversationPracticeListeningCubit()
        ..loadCharacters(conversation.conversation),
      child: BlocConsumer<ConversationPracticeListeningCubit,
          ConversationPracticeListeningState>(
        listener: (context, state) {
          if (state.status.isAddCharacter) {
            _learnerAns += state.word.char;
            _learnerAns += " ";
            for (CharacterDescription word in words) {
              if (word.index == state.word.index) {
                word.background = Colors.black12;
                word.fontColor = Colors.grey;
                word.canChoose = false;
              }
            }
          } else if (state.status.isCorrect) {
            _sweetSheet.show(
              isDismissible: false,
              context: context,
              title: Text(
                "Correct",
                style: GoogleFonts.lato(),
              ),
              description: Text(
                  '${conversation.conversation.toUpperCase()}' +
                      '\nEnglish meaning: ${conversation.description}',
                  style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500)),
              color: SweetSheetColor.SUCCESS,
              icon: CupertinoIcons.check_mark_circled_solid,
              positive: SweetSheetAction(
                onPressed: () {
                  openSpeaking();
                  Navigator.of(context).pop();
                },
                title: 'NEXT',
                icon: CupertinoIcons.arrow_right_circle_fill,
              ),
            );
          } else if (state.status.isIncorrect) {
            _sweetSheet.show(
              isDismissible: false,
              context: context,
              title: Text("Incorrect", style: GoogleFonts.lato()),
              description: Text(
                  '${conversation.conversation.toUpperCase()}' +
                      '\nEnglish meaning: ${conversation.description}',
                  style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500)),
              color: SweetSheetColor.DANGER,
              icon: CupertinoIcons.xmark_circle_fill,
              positive: SweetSheetAction(
                onPressed: () {
                  BlocProvider.of<ConversationPracticeListeningCubit>(context)
                      .loadCharacters(conversation.conversation);
                  Navigator.of(context).pop();
                },
                title: 'DO AGAIN',
                icon: CupertinoIcons.arrow_counterclockwise,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status.isLoaded ||
              state.status.isAddCharacter ||
              state.status.isIncorrect ||
              state.status.isCorrect) {
            if (state.status.isLoaded) {
              _learnerAns = '';
              words.clear();
              int index = 0;
              for (var word in state.words) {
                index = index + 1;
                CharacterDescription characterDescription =
                    new CharacterDescription(
                        char: word,
                        background: Colors.white,
                        fontColor: Colors.black,
                        canChoose: true,
                        index: index);
                words.add(characterDescription);
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
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                          icon: _mPlayer.isPlaying
                              ? Icon(CupertinoIcons.stop_fill)
                              : Icon(Ionicons.volume_medium_outline),
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
                        _mPlayer.isPlaying ? 'Listening...' : 'Tap to listen',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 13,
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<ConversationPracticeListeningCubit>(
                                  context)
                              .loadCharacters(conversation.conversation);
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
                              fontSize: 20),
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
                            words.length,
                            (index) => _character(
                                character: words[index], context: context)),
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
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(
                                      SizeConfig.blockSizeHorizontal * 4)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.MAIN_COLOR),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                  GoogleFonts.lato(fontSize: 17))),
                          //: Color.fromRGBO(30, 193, 194, 30),
                          child: Text("Check"),
                          onPressed: () {
                            BlocProvider.of<ConversationPracticeListeningCubit>(
                                    context)
                                .checkAnswer(
                                    _learnerAns, conversation.conversation);
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
