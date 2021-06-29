import 'package:expat_assistant/src/models/location.dart';
import 'package:expat_assistant/src/providers/location_provider.dart';
import 'package:flutter/cupertino.dart';

class LocationRepository {
  final LocationProvider _locationProvider = LocationProvider();

  Future<List<Location>> getLocationsByEventId(
      {@required String token, @required int eventId}){
        return _locationProvider.getLocationsByEventId(token: token, eventId: eventId);
      }
}
