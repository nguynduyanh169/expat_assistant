import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/place.dart';
import 'package:expat_assistant/src/utils/places_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

// ignore: must_be_immutable
class RestaurantCard extends StatelessWidget {
  Function restaurantAction;
  Result placeInfomation;
  double currentLat;
  double currentLng;

  RestaurantCard(
      {this.restaurantAction,
      this.placeInfomation,
      this.currentLat,
      this.currentLng});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String imageUrl;
    if (placeInfomation.photos != null) {
      imageUrl =
          "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${placeInfomation.photos.first.photoReference}&key=${GooglePlaces.API_KEY}";
    }

    return InkWell(
      onTap: restaurantAction,
      child: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 3,
            right: SizeConfig.blockSizeHorizontal * 3),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26.withOpacity(0.1),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.10)
            ]),
        child: Row(
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeVertical * 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageUrl == null
                    ? ExtendedImage.network(
                        'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/restaurants%2Frestaurant_photo.png?alt=media&token=5c81b38c-1524-4ac5-a654-c2940f8f6040',
                        fit: BoxFit.cover,
                      )
                    : ExtendedImage.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 20,
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 3,
                  bottom: SizeConfig.blockSizeVertical * 3,
                  left: SizeConfig.blockSizeHorizontal * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1),
                    width: SizeConfig.blockSizeHorizontal * 40,
                    height: SizeConfig.blockSizeVertical * 3,
                    child: Text(
                      placeInfomation.name,
                      style: GoogleFonts.lato(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Text(
                          PlacesUtils.caculateDistance(currentLat, currentLng, placeInfomation.geometry.location.lat, placeInfomation.geometry.location.lng).toString() + " km",
                          style: GoogleFonts.lato(fontSize: 12),
                        )),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Container(
                            child: Text(
                          '.',
                          style: GoogleFonts.lato(fontSize: 12),
                        )),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              LineIcons.starAlt,
                              color: Color.fromRGBO(252, 191, 7, 30),
                              size: 14,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Container(
                                child: Text(
                              placeInfomation.rating == null
                                  ? '0.0'
                                  : placeInfomation.rating.toString(),
                              style: GoogleFonts.lato(fontSize: 12),
                            ))
                          ],
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 0.5,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Container(
                        width: SizeConfig.blockSizeHorizontal * 40,
                        child: Text(
                          placeInfomation.types != null
                              ?  placeInfomation.types[0] +
                                  ", " +
                                   placeInfomation.types[1]
                              : 'Not Available',
                          style: GoogleFonts.lato(
                              fontSize: 12, color: Colors.black54),
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 4.3,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Container(
                        width: SizeConfig.blockSizeHorizontal * 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            placeInfomation.openingHours == null
                                ? Container(
                                    child: Text(
                                    'Closed Now',
                                    style: GoogleFonts.lato(
                                        fontSize: 12, color: Colors.red),
                                  ))
                                : Container(
                                    child:
                                        placeInfomation.openingHours.openNow ==
                                                true
                                            ? Text(
                                                'Opening Now',
                                                style: GoogleFonts.lato(
                                                    fontSize: 12,
                                                    color: Colors.green),
                                              )
                                            : Text(
                                                'Closed Now',
                                                style: GoogleFonts.lato(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                              )),
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
