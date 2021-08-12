import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/models/place.dart';
import 'package:expat_assistant/src/repositories/restaurant_repository.dart';
import 'package:expat_assistant/src/states/restaurant_by_food_state.dart';

class RestaurantByFoodCubit extends Cubit<RestaurantByFoodState> {
  RestaurantRepository restaurantRepository;
  RestaurantByFoodCubit(this.restaurantRepository)
      : super(const RestaurantByFoodState(status: RestaurantByFoodStatus.init));

  Future<void> getRestaurantsByFood(
      String foodName, String locationText) async {
    emit(state.copyWith(status: RestaurantByFoodStatus.loading));
    try {
      LocationList result = await restaurantRepository.getRestaurantByFoodName(
          foodName: foodName, location: locationText);
      if (result == null) {
        emit(state.copyWith(
            status: RestaurantByFoodStatus.loadError,
            errorMessage: 'An error occurs while loading restaurants!'));
      } else {
        emit(state.copyWith(
            status: RestaurantByFoodStatus.loaded, locations: result));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: RestaurantByFoodStatus.loadError,
          errorMessage: e.toString()));
    }
  }

  Future<void> getNextRestaurants(LocationList oldData) async {
    if (!state.status.isLoadingMoreRestaurants) {
      emit(state.copyWith(
          status: RestaurantByFoodStatus.loadingMoreRestaurants));
      try {
        LocationList nextData = await restaurantRepository.getNextRestaurant(
            nextPageToken: oldData.nextPageToken);
        if (nextData == null) {
          emit(state.copyWith(
              status: RestaurantByFoodStatus.loadMoreRestaurantError,
              nextLocations: oldData,
              errorMessage: "An error occurs while fetching data"));
        } else {
          oldData.htmlAttributions = nextData.htmlAttributions;
          oldData.nextPageToken = nextData.nextPageToken;
          oldData.results.addAll(nextData.results);
          emit(state.copyWith(
              status: RestaurantByFoodStatus.loadedMoreRestaurants,
              nextLocations: oldData));
        }
      } on Exception catch (e) {
        emit(state.copyWith(
            status: RestaurantByFoodStatus.loadMoreRestaurantError,
            nextLocations: oldData,
            errorMessage: e.toString()));
      }
    }
  }
}
