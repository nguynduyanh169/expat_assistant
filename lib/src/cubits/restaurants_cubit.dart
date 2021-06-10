import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/states/restaurants_state.dart';
import 'package:flutter/services.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit() : super(Init());

  Future<void> loadDataToScreen() async {
    LocationData myLocation;
    String error;
    String addressText;
    Location location = new Location();
    GeoCode geoCode = GeoCode();
    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        emit(LoadScreenError(error));
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        emit(LoadScreenError(error));
      }
      myLocation = null;
    }
    try {
      print(myLocation.latitude.toString() +" - " + myLocation.longitude.toString());
      Address address = await geoCode.reverseGeocoding(
          latitude: myLocation.latitude, longitude: myLocation.longitude);
      addressText = (address.streetNumber != null ? address.streetNumber.toString() + " " : "") +
          address.streetAddress.toString() +
          ", " +
          address.city +
          ", " +
          address.region +
          ", " +
          address.countryName;
      print(addressText);
      emit(LoadScreenSuccess(addressText));
    } catch (e) {
      emit(LoadScreenError(e.toString()));
    }
  }
}
