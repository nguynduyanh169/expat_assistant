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
}
