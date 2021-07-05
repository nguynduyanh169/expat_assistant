import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CallingScreen extends StatefulWidget {
  @override
  _CallingScreenState createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    await [Permission.microphone].request();

    RtcEngineConfig config = RtcEngineConfig(Agora.APP_ID);

    var engine = await RtcEngine.createWithConfig(config);

    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('joinChannelSuccess: ${channel} ${uid}');
      setState(
        () {
          _joined = true;
        },
      );
    }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = 0;
      });
    }));
    // Join channel with channel name as 123
    await engine.joinChannel(Agora.TOKEN, 'appointment_channel', null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Audio quickstart'),
      ),
      body: Center(
        child: Text('Please chat!'),
      ),
    );
  }
}
