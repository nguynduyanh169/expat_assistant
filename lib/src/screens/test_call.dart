import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/screens/call_room_screen.dart';
import 'package:expat_assistant/src/screens/calling_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class TestCallPage extends StatefulWidget {
  @override
  _TestCallPageState createState() => _TestCallPageState();
}

class _TestCallPageState extends State<TestCallPage> {
  final TextEditingController channelController = TextEditingController();
  bool _validateError = false;
  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Flutter QuickStart'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: channelController,
                    decoration: InputDecoration(
                      errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      hintText: 'Channel name',
                    ),
                  ))
                ],
              ),
              Column(
                children: [
                  ListTile(
                    title: Text(ClientRole.Broadcaster.toString()),
                    leading: Radio(
                      value: ClientRole.Broadcaster,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(ClientRole.Audience.toString()),
                    leading: Radio(
                      value: ClientRole.Audience,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onJoin,
                        child: Text('Join'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueAccent),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (channelController.text.isNotEmpty) {
      await _handleMic(Permission.microphone);
      await Navigator.pushNamed(context, RouteName.CALL_ROOM, arguments: CallingScreenArguments(channelController.text, _role));
    }
  }

  Future<void> _handleMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
