import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Container(
          child: MaterialButton(
            child: Text('back'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

}