import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageRestaurantCard extends StatelessWidget {
  final String title;

  ImageRestaurantCard({this.title});
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
              image: NetworkImage(
                  'https://images.foody.vn/res/g105/1046039/prof/s640x400/foody-upload-api-foody-mobile-45-200909134828.jpg'),
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
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2,
                  bottom: SizeConfig.blockSizeHorizontal * 2),
              alignment: Alignment.bottomLeft,
              width: SizeConfig.blockSizeHorizontal * 40,
              height: SizeConfig.blockSizeVertical * 20,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
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
