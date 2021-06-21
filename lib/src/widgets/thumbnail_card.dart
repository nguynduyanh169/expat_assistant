import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThumbnailCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Image(
              width: SizeConfig.blockSizeHorizontal * 40,
              height: SizeConfig.blockSizeVertical * 20,
              image: AssetImage('assets/images/demo_thumb.jpg'),
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                    Colors.grey.withOpacity(0),
                    Colors.black,
                  ],
                      stops: [
                    0.0,
                    2.0
                  ])),
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1,
                  bottom: SizeConfig.blockSizeHorizontal * 2),
              alignment: Alignment.bottomRight,
              width: SizeConfig.blockSizeHorizontal * 40,
              height: SizeConfig.blockSizeVertical * 20,
              child: Text(
                'Introduction about our application',
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
