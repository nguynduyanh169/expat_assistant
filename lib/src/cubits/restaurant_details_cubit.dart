import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/models/location_details.dart';
import 'package:expat_assistant/src/repositories/restaurant_repository.dart';
import 'package:expat_assistant/src/states/restaurant_details_state.dart';

class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  RestaurantRepository restaurantRepository;
  RestaurantDetailsCubit(this.restaurantRepository)
      : super(
            const RestaurantDetailsState(status: RestaurantDetailsStatus.init));

  Future<void> getRestaurantInfo(String placeId) async {
    emit(state.copyWith(status: RestaurantDetailsStatus.loading));
    try {
      LocationDetails locationDetails =
          await restaurantRepository.getRestaurantDetails(placeId: placeId);
      if (locationDetails == null) {
        emit(state.copyWith(
            status: RestaurantDetailsStatus.loadError,
            message: 'An error occurs while loading restaurant information'));
      } else {
        emit(state.copyWith(
            status: RestaurantDetailsStatus.loaded,
            locationDetails: locationDetails));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: RestaurantDetailsStatus.loadError, message: e.toString()));
    }
  }
}
