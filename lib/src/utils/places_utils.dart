import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vector_math/vector_math.dart';

import 'dart:math' show sin, cos, sqrt, atan2, asin;
import 'package:flutter/services.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

class PlacesUtils {
  static Future<dynamic> getLocation() async {
    Location location = new Location();
    LocationData myLocation;
    String error;
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        return error;
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        return error;
      }
      myLocation = null;
    }
    return myLocation;
  }

  static Future<dynamic> getAddress(LocationData myLocation) async {
    String addressText;
    GeoCode geoCode = GeoCode();
    Address address = await geoCode.reverseGeocoding(
        latitude: myLocation.latitude, longitude: myLocation.longitude);
    addressText = (address.streetNumber != null
            ? address.streetNumber.toString() + " "
            : "") +
        address.streetAddress.toString() +
        ", " +
        address.city +
        ", " +
        address.region +
        ", " +
        address.countryName;
    return addressText;
  }

  static double caculateDistance(
    double currentLat,
    double currentLng,
    double positionLat,
    double positionLng,
  ) {
    final Distance distance = Distance();
    final double result = distance.as(
        LengthUnit.Kilometer,
        new LatLng(currentLat, currentLng),
        new LatLng(positionLat, positionLng));
    return result;
  }

  static String checkToday(List<String> weekDays) {
    String weekDay = DateFormat('EEEE').format(DateTime.now());
    String result;
    for (String day in weekDays) {
      if (day.contains(weekDay)) {
        result = day;
      }
    }
    return result;
  }

  static bool isToday(String weekDay) {
    bool check = false;
    String today = DateFormat('EEEE').format(DateTime.now());
    if (weekDay.contains(today)) {
      check = true;
    }
    return check;
  }
}
