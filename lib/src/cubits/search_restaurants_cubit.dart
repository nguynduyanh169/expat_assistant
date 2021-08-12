import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/models/place.dart';
import 'package:expat_assistant/src/repositories/restaurant_repository.dart';
import 'package:expat_assistant/src/states/search_restaurants_state.dart';

class SearchRestaurantsCubit extends Cubit<SearchRestaurantState> {
  RestaurantRepository _restaurantRepository;

  SearchRestaurantsCubit(this._restaurantRepository)
      : super(const SearchRestaurantState(status: SearchRestaurantStatus.init));

  Future<void> searchRestaurantsByName(
      String locationText, String keyword) async {
    emit(state.copyWith(status: SearchRestaurantStatus.loading));
    try {
      LocationList result = await _restaurantRepository.getRestaurantByFoodName(
          foodName: keyword, location: locationText);
      if (result == null) {
        emit(state.copyWith(
            status: SearchRestaurantStatus.loadError,
            errorMessage: 'An error occurs while loading restaurants!'));
      } else {
        emit(state.copyWith(
            status: SearchRestaurantStatus.loaded, locations: result));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: SearchRestaurantStatus.loadError,
          errorMessage: e.toString()));
    }
  }

  Future<void> searchMoreRestaurants(LocationList oldData) async {
    if (!state.status.isLoadingMoreRestaurants) {
      emit(state.copyWith(
          status: SearchRestaurantStatus.loadingMoreRestaurants));
      try {
        LocationList nextData = await _restaurantRepository.getNextRestaurant(
            nextPageToken: oldData.nextPageToken);
        if (nextData == null) {
          emit(state.copyWith(
              status: SearchRestaurantStatus.loadMoreRestaurantError,
              nextLocations: oldData,
              errorMessage: "An error occurs while fetching data"));
        } else {
          oldData.htmlAttributions = nextData.htmlAttributions;
          oldData.nextPageToken = nextData.nextPageToken;
          oldData.results.addAll(nextData.results);
          emit(state.copyWith(
              status: SearchRestaurantStatus.loadedMoreRestaurants,
              nextLocations: oldData));
        }
      } on Exception catch (e) {
        emit(state.copyWith(
            status: SearchRestaurantStatus.loadMoreRestaurantError,
            nextLocations: oldData,
            errorMessage: e.toString()));
      }
    }
  }
}
