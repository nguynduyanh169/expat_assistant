import 'package:camera_camera/camera_camera.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class FoodCameraScreen extends StatefulWidget {
  _FoodCameraState createState() => _FoodCameraState();
}

class _FoodCameraState extends State<FoodCameraScreen> {
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.xmark,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.photo_on_rectangle,
              color: Colors.white,
            ),
            onPressed: () {
              getImage();
            },
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            CameraCamera(
              onFile: (file) {
                Navigator.pushNamed(context, RouteName.RESTAURANTS_BY_FOOD);
                print(file);
              },
            ),
            Positioned(
                left: SizeConfig.blockSizeHorizontal * 23,
                top: SizeConfig.blockSizeVertical * 78,
                child: Container(
                  child: Text(
                    "Take a food photo to recognize",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }

}