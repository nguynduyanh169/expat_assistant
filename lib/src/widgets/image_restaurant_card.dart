import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageRestaurantCard extends StatelessWidget {
  final String imageUrl;

  ImageRestaurantCard({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        child: ExtendedImage.network(
              imageUrl,
              width: SizeConfig.blockSizeHorizontal * 40,
              height: SizeConfig.blockSizeVertical * 20,
              fit: BoxFit.cover,
            ),
      ),
    );
  }
}
