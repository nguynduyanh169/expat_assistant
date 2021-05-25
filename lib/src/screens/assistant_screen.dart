import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssistantScreen extends StatefulWidget{
  _AssistantScreenState createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        title: Text('Assistant'),
      ),
      body: Container(
        child: Center(
          child: Text('This is assistant'),
        ),
      ),
    );
  }

}