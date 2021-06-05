import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/vocabulary_practice_speaking_cubit.dart';
import 'package:expat_assistant/src/states/vocabulary_practice_speaking_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class VocabularyPracticeSpeaking extends StatefulWidget {
  String vietnamese, english;

  VocabularyPracticeSpeaking(
      {@required this.vietnamese, @required this.english});

  _VocabularyPracticeSpeakingState createState() =>
      _VocabularyPracticeSpeakingState(vietnamese, english);
}

class _VocabularyPracticeSpeakingState
    extends State<VocabularyPracticeSpeaking> {
  String vietnamese, english;
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInit = false;
  bool _mRecorderIsInit = false;
  bool _mPlayBackReady = false;
  Icon recordIcon = Icon(LineIcons.microphone, size: 40, color: Colors.white,);
  String recordText = 'Please record your voice';
  String _filePath = 'voice_record.aac';

  _VocabularyPracticeSpeakingState(this.vietnamese, this.english);

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

  void record(){
    _mRecorder
        .startRecorder(
      toFile: _filePath,
    ).then((value) {
      setState(() {
        recordIcon = Icon(LineIcons.stopCircle, size: 40, color: Colors.white,);
        recordText = 'Recording...';
      });
    });
  }

  void stopRecorder() async {
    await _mRecorder.stopRecorder().then((value) {
      setState(() {
        _mPlayBackReady = true;
        recordIcon = Icon(LineIcons.microphone, size: 40, color: Colors.white,);
        recordText = 'Hear your record again';
      });
    });
  }

  getRecorderFn() {
    if (!_mRecorderIsInit || !_mPlayer.isStopped) {
      return null;
    }
    return _mRecorder.isStopped ? record() : stopRecorder();
  }

  void play() {
    assert(_mPlayerIsInit &&
        _mPlayBackReady &&
        _mRecorder.isStopped &&
        _mPlayer.isStopped);
    _mPlayer
        .startPlayer(
        fromURI: _filePath,
        whenFinished: () {
          setState(() {});
        })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {});
    });
  }

  getPlaybackFn() {
    if (!_mPlayerIsInit || !_mPlayBackReady || !_mRecorder.isStopped) {
      return null;
    }
    return _mPlayer.isStopped ? play() : stopPlayer();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
        create: (context) => VocabularyPracticeSpeakingCubit(),
        child: BlocBuilder<VocabularyPracticeSpeakingCubit, VocabularyPracticeSpeakingState>(
          builder: (context, state){
            if(state is Init) {
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
                      style: TextStyle(
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
                                    height: SizeConfig.blockSizeVertical * 5,),
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    height: SizeConfig.blockSizeVertical * 8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Colors.grey
                                        )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: SizeConfig.blockSizeHorizontal * 35,
                                          child: Text(
                                            recordText, style: TextStyle(fontSize: 12, color: Colors.grey),),
                                        ),
                                        SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                                        InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  30, 193, 194, 30),
                                              border: Border.all(color: Colors.black12),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Icon(CupertinoIcons.volume_up, size: 20, color: Colors.white,),
                                            width: SizeConfig.blockSizeHorizontal * 15,
                                            height: SizeConfig.blockSizeVertical * 4.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical * 10,),
                                  Container(
                                    height: SizeConfig.blockSizeVertical * 10,
                                    child: Text(
                                      vietnamese,
                                      style: GoogleFonts.raleway(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Color.fromRGBO(
                                        30, 193, 194, 30),
                                    radius: 30,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(CupertinoIcons.volume_up),
                                      color: Colors.white,
                                      onPressed: () {
                                        getPlaybackFn();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: SizeConfig.blockSizeHorizontal * 33,
                            top: SizeConfig.blockSizeVertical * 50,
                            child: ClipOval(
                              child: Material(
                                color: Color.fromRGBO(30, 193, 194, 30), // Button color
                                child: InkWell(
                                  splashColor: Colors.green, // Splash color
                                  onTap: () {
                                    getRecorderFn();
                                  },
                                  child: SizedBox(width: 65, height: 65, child: recordIcon),
                                ),
                              ),
                            )   ,
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        child: CupertinoButton(
                            color: Color.fromRGBO(30, 193, 194, 30),
                            child: Text("Check"),
                            onPressed: () {
                              print('ok');
                            }),
                      ),
                    ),
                  ],
                ),
              );
            }else{
              return Container();
            }
          },
        ),
    );
  }
}
