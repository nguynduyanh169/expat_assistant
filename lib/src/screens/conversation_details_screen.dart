import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationDetailScreen extends StatefulWidget{
  _ConversationDetailState createState() => _ConversationDetailState();
}

class _ConversationDetailState extends State<ConversationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversation Details'),
      ),
      body: Container(
        child: Center(
          child: Text('This is Conversation details'),
        ),
      ),
    );
  }
}