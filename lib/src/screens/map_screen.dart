import 'dart:async';

import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double _lat = 10.9748588;
  double _lng = 106.891206;
  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  CameraPosition _currentPosition;
  PermissionStatus _permissionGranted;

  @override
  initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args =
        ModalRoute.of(context).settings.arguments as MapScreenArguments;
    if (args.lat != null && args.long != null) {
      _lat = args.lat;
      _lng = args.long;
    }
    _currentPosition = CameraPosition(
      target: LatLng(_lat, _lng),
      zoom: 12,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Ionicons.chevron_back_circle,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Map',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          InkWell(
            onTap: () async {
              String googleUrl =
                  'https://www.google.com/maps/search/?api=1&query=$_lat,$_lng';
              if (await canLaunch(googleUrl)) {
                await launch(googleUrl);
              } else {
                throw 'Could not open the map.';
              }
            },
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
              child: Container(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26.withOpacity(0.05),
                          offset: Offset(0.0, 6.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.10)
                    ]),
                child: Row(
                  children: <Widget>[
                    Icon(
                      LineIcons.mapAlt,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 1,
                    ),
                    Text('Get Direction',
                        style: GoogleFonts.lato(color: Colors.black)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          initialCameraPosition: _currentPosition,
          markers: {
            Marker(
              markerId: MarkerId('current'),
              position: LatLng(_lat, _lng),
            )
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}

class MapScreenArguments {
  final double lat;
  final double long;
  MapScreenArguments(this.lat, this.long);
}
