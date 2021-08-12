import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/place.dart';

class SearchRestaurantState extends Equatable {
  final String errorMessage;
  final SearchRestaurantStatus status;
  final LocationList locations;
  final LocationList nextLocations;

  const SearchRestaurantState(
      {this.status, this.errorMessage, this.locations, this.nextLocations});

  SearchRestaurantState copyWith(
      {String errorMessage,
      SearchRestaurantStatus status,
      LocationList locations,
      LocationList nextLocations}) {
    return SearchRestaurantState(
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        locations: locations ?? this.locations,
        nextLocations: nextLocations ?? this.nextLocations);
  }

  @override
  // TODO: implement props
  List<Object> get props => [status, errorMessage, locations, nextLocations];
}

enum SearchRestaurantStatus {
  init,
  loading,
  loaded,
  loadError,
  loadingMoreRestaurants,
  loadedMoreRestaurants,
  loadMoreRestaurantError,
}

extension Explaination on SearchRestaurantStatus {
  bool get isInit => this == SearchRestaurantStatus.init;

  bool get isLoading => this == SearchRestaurantStatus.loading;

  bool get isLoaded => this == SearchRestaurantStatus.loaded;

  bool get isLoadError => this == SearchRestaurantStatus.loadError;

  bool get isLoadingMoreRestaurants =>
      this == SearchRestaurantStatus.loadingMoreRestaurants;

  bool get isLoadedMoreRestaurants =>
      this == SearchRestaurantStatus.loadedMoreRestaurants;

  bool get isLoadMoreRestaurantError =>
      this == SearchRestaurantStatus.loadMoreRestaurantError;
}
