import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/place.dart';

class RestaurantByFoodState extends Equatable {
  final String errorMessage;
  final RestaurantByFoodStatus status;
  final LocationList locations;
  final LocationList nextLocations;

  const RestaurantByFoodState(
      {this.errorMessage, this.status, this.locations, this.nextLocations});

  @override
  // TODO: implement props
  List<Object> get props => [status, locations, nextLocations, errorMessage];

  RestaurantByFoodState copyWith(
      {String errorMessage,
      RestaurantByFoodStatus status,
      LocationList locations,
      LocationList nextLocations}) {
    return RestaurantByFoodState(
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        locations: locations ?? this.locations,
        nextLocations: nextLocations ?? this.nextLocations);
  }
}

enum RestaurantByFoodStatus {
  init,
  loading,
  loaded,
  loadError,
  loadingMoreRestaurants,
  loadedMoreRestaurants,
  loadMoreRestaurantError
}

extension Explaination on RestaurantByFoodStatus {
  bool get isInit => this == RestaurantByFoodStatus.init;

  bool get isLoading => this == RestaurantByFoodStatus.loading;

  bool get isLoaded => this == RestaurantByFoodStatus.loaded;

  bool get isLoadError => this == RestaurantByFoodStatus.loadError;

  bool get isLoadingMoreRestaurants =>
      this == RestaurantByFoodStatus.loadingMoreRestaurants;

  bool get isLoadedMoreRestaurants =>
      this == RestaurantByFoodStatus.loadedMoreRestaurants;

  bool get isLoadMoreRestaurantError =>
      this == RestaurantByFoodStatus.loadMoreRestaurantError;
}
