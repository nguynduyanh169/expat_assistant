import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class CallRoomScreen extends StatefulWidget {
  @override
  _CallRoomScreenState createState() => _CallRoomScreenState();
}

class _CallRoomScreenState extends State<CallRoomScreen> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool openSpeaker = false;
  RtcEngine _engine;
  @override
  void initState() {
    initialize('test', ClientRole.Broadcaster);
    super.initState();
  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  Future<void> initialize(String channelName, ClientRole role) async {
    print(channelName + role.toString());
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
    await _engine.joinChannel(Agora.TOKEN, channelName, null, 0);
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
        // print(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
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
        print(info);
      });
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args =
        ModalRoute.of(context).settings.arguments as CallingScreenArguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: Text(
          'Room 112',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.home,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: SizeConfig.blockSizeHorizontal * 15,
              child: ClipOval(
                child: Image(
                  fit: BoxFit.cover,
                  width: SizeConfig.blockSizeHorizontal * 30,
                  height: SizeConfig.blockSizeHorizontal * 30,
                  image: AssetImage('assets/images/demo_expert.jpg'),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 60,
              child: Text(
                'Dr. Ho Xuan Cuong',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 60,
              child: Text(
                '05:00',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.lato(fontSize: 15, color: AppColors.MAIN_COLOR),
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
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                    onPressed: () {
                      _onToggleMute();
                    },
                    color:
                        muted == true ? AppColors.MAIN_COLOR : Colors.black26,
                    icon: Icon(muted == true ? Ionicons.mic_off : Ionicons.mic),
                    shape: GFIconButtonShape.circle,
                  ),
                  GFIconButton(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
                    onPressed: () {
                      _onCallEnd(context);
                    },
                    color: Colors.red,
                    icon: Icon(CupertinoIcons.phone_down_fill),
                    shape: GFIconButtonShape.circle,
                  ),
                  GFIconButton(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
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
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    print(muted);
    _engine.muteLocalAudioStream(muted);
  }

  void _onOpenSpeaker() {
    setState(() {
      openSpeaker = !openSpeaker;
    });
    print(openSpeaker);
    _engine.setDefaultAudioRoutetoSpeakerphone(openSpeaker);
  }
}

class CallingScreenArguments {
  final String name;
  final ClientRole role;

  const CallingScreenArguments(this.name, this.role);
}
