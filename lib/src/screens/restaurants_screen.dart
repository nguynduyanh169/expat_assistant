import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantsScreen extends StatefulWidget {
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: Container(
        child: Center(
          child: Text('This is restaurants'),
        ),
      ),
    );
  }
}
