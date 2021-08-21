import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/conversation_practice_speaking_cubit.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/states/conversation_practice_speaking_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class ConversationPracticeSpeaking extends StatefulWidget {
  ConversationLocal conversation;
  Function openListening;

  ConversationPracticeSpeaking(
      {@required this.conversation, @required this.openListening});
  _ConversationPracticeSpeakingState createState() =>
      _ConversationPracticeSpeakingState(conversation, openListening);
}

class _ConversationPracticeSpeakingState
    extends State<ConversationPracticeSpeaking> {
  static final String FILE_RECORD = 'voice_record.acc';
  HiveUtils _hiveUtils = HiveUtils();
  ConversationLocal conversation;
  Function openListening;
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInit = false;
  bool _mRecorderIsInit = false;
  bool _mPlayBackReady = false;
  Icon recordIcon = Icon(
    Ionicons.mic_outline,
    size: 28,
    color: Colors.white,
  );

  String recordText = 'Please record your voice';

  _ConversationPracticeSpeakingState(this.conversation, this.openListening);

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder.openAudioSession();
    _mRecorderIsInit = true;
  }

  void record(String filePath) {
    _mRecorder
        .startRecorder(
      toFile: filePath,
    )
        .then((value) {
      setState(() {
        recordIcon = Icon(
          Ionicons.stop_outline,
          size: 28,
          color: Colors.white,
        );
        recordText = 'Recording...';
      });
    });
  }

  void stopRecorder() async {
    await _mRecorder.stopRecorder().then((value) {
      setState(() {
        _mPlayBackReady = true;
        recordIcon = Icon(
          Ionicons.mic_outline,
          size: 28,
          color: Colors.white,
        );
        recordText = 'Hear your record again';
      });
    });
  }

  getRecorderFn(String filePath) {
    if (!_mRecorderIsInit || !_mPlayer.isStopped) {
      return null;
    }
    return _mRecorder.isStopped ? record(filePath) : stopRecorder();
  }

  void play(String filePath) {
    assert(_mPlayerIsInit);
    _mPlayer.startPlayer(
        fromURI: filePath,
        whenFinished: () {
          setState(() {});
        });
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {});
    });
  }

  getPlaybackFn(String filePath) {
    if (!_mPlayerIsInit || !_mPlayBackReady || !_mRecorder.isStopped) {
      return null;
    }
    return _mPlayer.isStopped ? play(filePath) : stopPlayer();
  }

  getPlaybachForConversation(String filePath){
     if (!_mPlayerIsInit) {
      return null;
    }
    return _mPlayer.isStopped ? play(filePath) : stopPlayer();
  }

  @override
  void dispose() {
    _mPlayer.closeAudioSession();
    _mPlayer = null;
    _mRecorder.closeAudioSession();
    _mRecorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => ConversationPracticeSpeakingCubit(),
      child: BlocBuilder<ConversationPracticeSpeakingCubit,
          ConversationPracticeSpeakingState>(
        builder: (context, state) {
          if (state.status.isInit) {
            openTheRecorder().then((value) {
              setState(() {
                _mRecorderIsInit = true;
              });
            });

            _mPlayer.openAudioSession().then((value) {
              setState(() {
                _mPlayerIsInit = true;
              });
            });
            return Container(
               padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  right: SizeConfig.blockSizeHorizontal * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Listen and speak again',
                    style: GoogleFonts.lato(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 67,
                    alignment: Alignment.topCenter,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Container(
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 85,
                            height: SizeConfig.blockSizeVertical * 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26.withOpacity(0.1),
                                      offset: Offset(0.0, 6.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.10)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 5,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.blockSizeHorizontal * 70,
                                  height: SizeConfig.blockSizeVertical * 8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 0.5,
                                          color: AppColors.MAIN_COLOR)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 40,
                                        child: Text(
                                          recordText,
                                          style: GoogleFonts.lato(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 3,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          getPlaybackFn(FILE_RECORD);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.MAIN_COLOR,
                                            border: Border.all(
                                                color: AppColors.MAIN_COLOR),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Icon(
                                            Ionicons.volume_medium_outline,
                                            size: 22,
                                            color: Colors.white,
                                          ),
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  15,
                                          height: SizeConfig.blockSizeVertical *
                                              4.5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 7,
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 70,
                                  //padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig.blockSizeHorizontal * 3),
                                  height: SizeConfig.blockSizeVertical * 10,
                                  child: Text(
                                    conversation.conversation,
                                    style: GoogleFonts.lato(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                GFIconButton(
                                  padding: EdgeInsets.all(
                                      SizeConfig.blockSizeHorizontal * 5),
                                  onPressed: () {
                                    String file = _hiveUtils
                                        .getFilePath(
                                            boxName: HiveBoxName.LESSON_SRC,
                                            key: conversation.voiceLink)
                                        .srcPath;
                                    print(file);
                                    getPlaybachForConversation(file);
                                  },
                                  color: AppColors.MAIN_COLOR,
                                  icon: Icon(
                                    Ionicons.volume_medium_outline,
                                    size: 28,
                                  ),
                                  shape: GFIconButtonShape.circle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: SizeConfig.blockSizeHorizontal * 33,
                          top: SizeConfig.blockSizeVertical * 50,
                          child: GFIconButton(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 5),
                            onPressed: () {
                              getRecorderFn(FILE_RECORD);
                            },
                            color: AppColors.MAIN_COLOR,
                            icon: recordIcon,
                            shape: GFIconButtonShape.circle,
                          ),
                        )
                      ],
                    ),
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
                          onPressed: openListening),
                    ),
                  ),
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
