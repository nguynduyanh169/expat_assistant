import 'dart:math';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/restaurant_details_cubit.dart';
import 'package:expat_assistant/src/models/location_details.dart';
import 'package:expat_assistant/src/repositories/restaurant_repository.dart';
import 'package:expat_assistant/src/states/restaurant_details_state.dart';
import 'package:expat_assistant/src/utils/places_utils.dart';
import 'package:expat_assistant/src/widgets/image_restaurant_card.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'map_screen.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LocationDetails locationDetails;
    final args =
        ModalRoute.of(context).settings.arguments as RestaurantDetailsArgs;
    String imageUrl;
    if (args.photoRef != null) {
      imageUrl =
          "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${args.photoRef}&key=${GooglePlaces.API_KEY}";
    }
    return BlocProvider(
      create: (context) => RestaurantDetailsCubit(RestaurantRepository())
        ..getRestaurantInfo(args.placeId),
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black38,
                height: 0.25,
              ),
              preferredSize: Size.fromHeight(0.25)),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColors.MAIN_COLOR,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(
            'Restaurant Details',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  print('tapped');
                  Navigator.popUntil(
                      context, ModalRoute.withName(RouteName.HOME_PAGE));
                },
                icon: Icon(
                  CupertinoIcons.home,
                  color: Colors.white,
                )),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
        ),
        body: BlocBuilder<RestaurantDetailsCubit, RestaurantDetailsState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return LoadingView(message: 'Loading...');
            } else if (state.status.isLoaded) {
              locationDetails = state.locationDetails;
            }
            return Container(
                height: SizeConfig.blockSizeVertical * 89,
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ClipRRect(
                          child: imageUrl == null
                              ? ExtendedImage.network(
                                  'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/restaurants%2Frestaurant_photo.png?alt=media&token=5c81b38c-1524-4ac5-a654-c2940f8f6040',
                                  height: SizeConfig.blockSizeVertical * 25,
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                  fit: BoxFit.cover,
                                )
                              : ExtendedImage.network(
                                  imageUrl,
                                  height: SizeConfig.blockSizeVertical * 25,
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 60,
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3),
                      height: SizeConfig.blockSizeVertical * 89,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 23,
                          ),
                          Container(
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
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  locationDetails.result.name.trim(),
                                  style: GoogleFonts.lato(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 1,
                                    ),
                                    Container(
                                        child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          LineIcons.starAlt,
                                          color:
                                              Color.fromRGBO(252, 191, 7, 30),
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  1,
                                        ),
                                        Container(
                                            child: Text(
                                          locationDetails.result.rating
                                              .toString(),
                                          style: GoogleFonts.lato(fontSize: 20),
                                        ))
                                      ],
                                    )),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 1,
                                    ),
                                    Container(
                                        child: Text(
                                      '.',
                                      style: GoogleFonts.lato(fontSize: 15),
                                    )),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 1,
                                    ),
                                    locationDetails.result.openingHours == null
                                        ? Container(
                                            child: Text(
                                            'Closed Now',
                                            style: GoogleFonts.lato(
                                                fontSize: 20,
                                                color: Colors.red),
                                          ))
                                        : Container(
                                            child: locationDetails.result
                                                        .openingHours.openNow ==
                                                    true
                                                ? Text(
                                                    'Opening Now',
                                                    style: GoogleFonts.lato(
                                                        fontSize: 20,
                                                        color: Colors.green),
                                                  )
                                                : Text(
                                                    'Closed Now',
                                                    style: GoogleFonts.lato(
                                                        fontSize: 20,
                                                        color: Colors.red),
                                                  )),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Divider(
                                  height: 1,
                                  color: Colors.black45,
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(context, RouteName.MAP,
                                        arguments: MapScreenArguments(
                                            locationDetails
                                                .result.geometry.location.lat,
                                            locationDetails
                                                .result.geometry.location.lng));
                                  },
                                  contentPadding: EdgeInsets.all(
                                      SizeConfig.blockSizeHorizontal * 0.5),
                                  leading: Icon(
                                    LineIcons.mapMarked,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    locationDetails.result.formattedAddress
                                        .trim(),
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    PlacesUtils.caculateDistance(
                                                args.currentLat,
                                                args.currentLng,
                                                locationDetails.result.geometry
                                                    .location.lat,
                                                locationDetails.result.geometry
                                                    .location.lng)
                                            .toString() +
                                        " km",
                                    style: GoogleFonts.lato(fontSize: 13),
                                  ),
                                  trailing: Icon(
                                    CupertinoIcons.forward,
                                    size: 20,
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Colors.black45,
                                ),
                                locationDetails.result.openingHours == null
                                    ? ListTile(
                                        contentPadding: EdgeInsets.all(
                                            SizeConfig.blockSizeHorizontal *
                                                0.5),
                                        leading: Icon(
                                          LineIcons.businessTime,
                                          size: 30,
                                          color: Colors.green,
                                        ),
                                        title: Text(
                                          'Not Available',
                                          style: GoogleFonts.lato(fontSize: 16),
                                        ),
                                      )
                                    : ExpansionTile(
                                        // contentPadding: EdgeInsets.all(
                                        //     SizeConfig.blockSizeHorizontal * 0.5),
                                        tilePadding: EdgeInsets.all(
                                            SizeConfig.blockSizeHorizontal *
                                                0.5),
                                        leading: Icon(
                                          LineIcons.businessTime,
                                          size: 30,
                                          color: Colors.green,
                                        ),
                                        title: Text(
                                          locationDetails.result.openingHours ==
                                                  null
                                              ? "Not Available"
                                              : PlacesUtils.checkToday(
                                                  locationDetails
                                                      .result
                                                      .openingHours
                                                      .weekdayText),
                                          style: GoogleFonts.lato(fontSize: 16),
                                        ),
                                        trailing: Icon(
                                          CupertinoIcons.forward,
                                          size: 20,
                                        ),
                                        children: <Widget>[
                                          for (var item in locationDetails
                                              .result.openingHours.weekdayText)
                                            ListTile(
                                              title: Text(
                                                item,
                                                style: GoogleFonts.lato(
                                                    fontWeight:
                                                        PlacesUtils.isToday(
                                                                item)
                                                            ? FontWeight.w700
                                                            : FontWeight.w500),
                                              ),
                                            )
                                        ],
                                      ),
                                Divider(
                                  height: 1,
                                  color: Colors.black45,
                                ),
                                ListTile(
                                  onTap: () async {
                                    if (locationDetails
                                            .result.formattedPhoneNumber !=
                                        null) {
                                      String callUrl =
                                          'tel://${locationDetails.result.formattedPhoneNumber}';
                                      if (await canLaunch(callUrl)) {
                                        await launch(callUrl);
                                      } else {
                                        throw 'Could not open the phone.';
                                      }
                                    }
                                  },
                                  contentPadding: EdgeInsets.all(
                                      SizeConfig.blockSizeHorizontal * 0.5),
                                  leading: Icon(
                                    LineIcons.phoneVolume,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                  trailing: Icon(
                                    CupertinoIcons.forward,
                                    size: 20,
                                  ),
                                  title: Text(
                                    locationDetails
                                                .result.formattedPhoneNumber ==
                                            null
                                        ? "Not available"
                                        : locationDetails
                                            .result.formattedPhoneNumber,
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Colors.black45,
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(
                                      SizeConfig.blockSizeHorizontal * 0.5),
                                  leading: Icon(
                                    LineIcons.utensils,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    locationDetails.result.types[0] +
                                        ", " +
                                        locationDetails.result.types[1],
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          Text(
                            'Images',
                            style: GoogleFonts.lato(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 99, 99, 30)),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          locationDetails.result.photos != null
                              ? Container(
                                  width: SizeConfig.blockSizeHorizontal * 90,
                                  height: SizeConfig.blockSizeVertical * 20,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => InkWell(
                                            onTap: () {
                                              ImageViewer.showImageSlider(
                                                images: [
                                                  "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${locationDetails.result.photos[index].photoReference}&key=${GooglePlaces.API_KEY}"
                                                ],
                                              );
                                            },
                                            child: ImageRestaurantCard(
                                              imageUrl:
                                                  "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${locationDetails.result.photos[index].photoReference}&key=${GooglePlaces.API_KEY}",
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                          ),
                                      itemCount:
                                          locationDetails.result.photos.length),
                                )
                              : Container(
                                  child: Column(
                                    children: <Widget>[
                                      ClipRRect(
                                        child: Image(
                                          height:
                                              SizeConfig.blockSizeVertical * 25,
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/no_photo.png'),
                                        ),
                                      ),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                                      Text('This restaurant does not have any photo', style: GoogleFonts.lato(),),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}

class RestaurantDetailsArgs {
  final String placeId;
  final String photoRef;
  final double currentLat;
  final double currentLng;

  RestaurantDetailsArgs(
      this.photoRef, this.placeId, this.currentLat, this.currentLng);
}
