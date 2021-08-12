import 'package:expat_assistant/src/models/location_details.dart';
import 'package:expat_assistant/src/models/place.dart';
import 'package:expat_assistant/src/providers/restaurant_provider.dart';
import 'package:flutter/cupertino.dart';

class RestaurantRepository {
  final RestaurantProvider _restaurantProvider = RestaurantProvider();

  Future<dynamic> detectFood({@required String imageUrl}) async {
    return _restaurantProvider.detectFood(imageUrl: imageUrl);
  }

  Future<LocationList> getNearbyRestaurant({@required String location}) {
    return _restaurantProvider.getNearbyRestaurant(location: location);
  }

  Future<LocationList> getNextRestaurant({@required String nextPageToken}) {
    return _restaurantProvider.getNextRestaurant(nextPageToken: nextPageToken);
  }

  Future<LocationDetails> getRestaurantDetails({@required String placeId}) {
    return _restaurantProvider.getRestaurantDetails(placeId: placeId);
  }

  Future<LocationList> getRestaurantByFoodName(
      {@required String foodName, @required String location}) {
    return _restaurantProvider.getRestaurantByFoodName(
        foodName: foodName, location: location);
  }
}
