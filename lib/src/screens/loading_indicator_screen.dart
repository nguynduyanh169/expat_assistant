import 'package:flutter/material.dart';

class LoadingIndicatorScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(
        child: CircularProgressIndicator(strokeWidth: 0.75,),
      ),),
    );
  }

}