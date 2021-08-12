import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/location_details.dart';

class RestaurantDetailsState extends Equatable {
  final String message;
  final LocationDetails locationDetails;
  final RestaurantDetailsStatus status;
  final String imageUrl;

  const RestaurantDetailsState(
      {this.imageUrl, this.locationDetails, this.message, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [imageUrl, locationDetails, message, status];

  RestaurantDetailsState copyWith(
      {String message,
      String imageUrl,
      LocationDetails locationDetails,
      RestaurantDetailsStatus status}) {
    return RestaurantDetailsState(
        message: message ?? this.message,
        imageUrl: imageUrl ?? this.imageUrl,
        locationDetails: locationDetails ?? this.locationDetails,
        status: status ?? this.status);
  }
}

enum RestaurantDetailsStatus { init, loading, loaded, loadError }

extension Explaination on RestaurantDetailsStatus {
  bool get isInit => this == RestaurantDetailsStatus.init;

  bool get isLoading => this == RestaurantDetailsStatus.loading;

  bool get isLoaded => this == RestaurantDetailsStatus.loaded;

  bool get isLoadError => this == RestaurantDetailsStatus.loadError;
}
