import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/call_room_cubit.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/models/room_call.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/screens/feedback_call_screen.dart';
import 'package:expat_assistant/src/states/call_room_state.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class CallRoomScreen extends StatefulWidget {
  @override
  _CallRoomScreenState createState() => _CallRoomScreenState();
}

class _CallRoomScreenState extends State<CallRoomScreen> {
  Timer timer;
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool openSpeaker = false;
  bool isOnline = false;
  RtcEngine _engine;
  final interval = const Duration(seconds: 1);
  int timerMaxSeconds = 60;
  int currentSeconds = 0;
  ExpatAppointment appointment;
  RoomCall roomCall;
  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  Future<void> initialize(
      String channelName, ClientRole role, int uid, String agoraToken) async {
    print(uid);
    if (Agora.APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine(role);
    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    await _engine.joinChannel(agoraToken, channelName, null, uid);
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
        print(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        isOnline = true;
        _infoStrings.add(info);
        print(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
        print('onLeaveChannel');
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
        isOnline = true;
        print(info);
      });
      startTimeout();
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
        print(info);
      });
    }));
  }

  Future<void> _initAgoraRtcEngine(ClientRole role) async {
    _engine = await RtcEngine.create(Agora.APP_ID);
    await _engine.setAudioProfile(
        AudioProfile.MusicHighQuality, AudioScenario.MEETING);
    await _engine.disableVideo();
    await _engine.enableAudio();
    await _engine.adjustPlaybackSignalVolume(400);
    await _engine.adjustRecordingSignalVolume(400);
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(role);
  }

  void startTimeout([int milliseconds]) {
    var duration = interval;
    timer = Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args = ModalRoute.of(context).settings.arguments as CallRoomArgs;
    return BlocProvider(
      create: (context) => CallRoomCubit(AppointmentRepository())
        ..getAppointmentById(args.appointmentId),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          title: Text(
            'Calling',
            style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: BlocConsumer<CallRoomCubit, CallRoomState>(
          listener: (context, state) {
            if (state.status.isLoadedRoom) {
              timerMaxSeconds = state.seconds;
              appointment = state.appointment;
              roomCall = state.roomCall;
              initialize(Agora.CHANNEL_NAME, ClientRole.Broadcaster,
                  roomCall.uid, roomCall.token);
            }
          },
          builder: (context, state) {
            if (state.status.isLoadingRoom) {
              return LoadingView(message: 'Loading...');
            } else {
              return Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: isOnline ? Colors.green : Colors.red,
                          width: 4.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 15,
                        child: ClipOval(
                          child: ExtendedImage.network(
                              appointment.session.specialist.avatar,
                              fit: BoxFit.cover,
                              width: SizeConfig.blockSizeHorizontal * 30,
                              height: SizeConfig.blockSizeHorizontal * 30),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 3,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      child: Text(
                        appointment.session.specialist.fullname,
                        textAlign: TextAlign.center,
                        style:
                            GoogleFonts.lato(fontSize: 22, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      child: Text(
                        timerText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            fontSize: 15, color: AppColors.MAIN_COLOR),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 30,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GFIconButton(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            onPressed: () {
                              _onToggleMute();
                            },
                            color: muted == true
                                ? AppColors.MAIN_COLOR
                                : Colors.black26,
                            icon: Icon(muted == true
                                ? Ionicons.mic_off
                                : Ionicons.mic),
                            shape: GFIconButtonShape.circle,
                          ),
                          GFIconButton(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 5),
                            onPressed: () {
                              _onCallEnd(context, appointment);
                            },
                            color: Colors.red,
                            icon: Icon(CupertinoIcons.phone_down_fill),
                            shape: GFIconButtonShape.circle,
                          ),
                          GFIconButton(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            onPressed: () {
                              _onOpenSpeaker();
                            },
                            color: openSpeaker == true
                                ? AppColors.MAIN_COLOR
                                : Colors.black26,
                            icon: Icon(openSpeaker == true
                                ? Ionicons.volume_high
                                : Ionicons.volume_medium),
                            shape: GFIconButtonShape.circle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context, ExpatAppointment appointment) {
    if (isOnline == false) {
      Navigator.pop(context);
    } else if (currentSeconds >= 5) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'End the consultant',
                style: GoogleFonts.lato(),
              ),
              content: Text(
                  'Your time still have much. Do you want to end the consultant session?',
                  style: GoogleFonts.lato(
                    color: Colors.black54,
                  )),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('CANCEL',
                        style: GoogleFonts.lato(
                            color: AppColors.MAIN_COLOR,
                            fontWeight: FontWeight.w700))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text('CONFIRM',
                        style: GoogleFonts.lato(
                            color: AppColors.MAIN_COLOR,
                            fontWeight: FontWeight.w700)))
              ],
            );
          }).then((value) {
        if (value == true) {
          Navigator.pushReplacementNamed(context, RouteName.FEEDBACK,
              arguments: FeedbackArgs(appointment.conAppId,
                  appointment.session.specialist.fullname));
        } else {
          return;
        }
      });
    } else {
      Navigator.pushReplacementNamed(context, RouteName.FEEDBACK,
          arguments: FeedbackArgs(
              appointment.conAppId, appointment.session.specialist.fullname));
    }
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onOpenSpeaker() {
    setState(() {
      openSpeaker = !openSpeaker;
    });
    _engine.setDefaultAudioRoutetoSpeakerphone(openSpeaker);
  }
}

class CallRoomArgs {
  final int appointmentId;
  CallRoomArgs({this.appointmentId});
}
