import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.black54),
          imageProvider: AssetImage('assets/images/demo_food.jpg'),
        )
    );
  }

}