import 'package:expat_assistant/src/screens/event_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget{
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Container(
        child: Center(
          child: MaterialButton(
            child: Text('Go'),
            onPressed: (){
              Navigator.of(context).pushNamed('/eventdetail');
              //Navigator.push(context, new MaterialPageRoute(builder: (context) => new EventDetails()));
            },
          ),
        ),
      ),
    );
  }

}