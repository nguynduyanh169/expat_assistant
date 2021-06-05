import 'package:camera_camera/camera_camera.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantsScreen extends StatefulWidget {
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            CameraCamera(
              enableZoom: true,
              onFile: (file) {
                print(file);
              },
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(CupertinoIcons.xmark, color: Colors.white, size: 30,),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                Text('Take A Photo of food to find restaurants')
              ],
            )
          ],
        ),
      ),
    );
  }
}
