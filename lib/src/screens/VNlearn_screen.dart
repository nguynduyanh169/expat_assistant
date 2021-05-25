import 'package:flutter/material.dart';

class VNlearnScreen extends StatefulWidget{
  _VNlearnScreenState createState() => _VNlearnScreenState();
}

class _VNlearnScreenState extends State<VNlearnScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Vietnamese Learn'),
      ),
      body: Container(
        child: Center(
          child: Text('Vietnamese Learn'),
        ),
      ),
    );
  }

}