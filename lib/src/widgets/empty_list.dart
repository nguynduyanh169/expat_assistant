import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EmptyList extends StatelessWidget {
  String title;
  String message;
  Function back;
  String image;

  EmptyList({this.image, this.message, this.back, this.title});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
              width: SizeConfig.blockSizeHorizontal * 70,
              height: SizeConfig.blockSizeVertical * 30,
              fit: BoxFit.cover,
              image: AssetImage(image)),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            height: SizeConfig.blockSizeVertical * 15,
            child: Text(
              title,
              style:
                  GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            height: SizeConfig.blockSizeVertical * 15,
            child: Text(
              message,
              style:
                  GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 85,
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueAccent),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.lato(fontSize: 17))),
                child: Text("Retry"),
                onPressed: back),
          )
        ],
      ),
    );
  }
}
