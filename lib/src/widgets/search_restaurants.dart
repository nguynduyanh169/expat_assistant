import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/search_restaurants_cubit.dart';
import 'package:expat_assistant/src/models/place.dart';
import 'package:expat_assistant/src/screens/restaurant_details_screen.dart';
import 'package:expat_assistant/src/states/search_restaurants_state.dart';
import 'package:expat_assistant/src/widgets/restaurant_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loading.dart';

class SearchRestaurant extends SearchDelegate<Result> {
  final SearchRestaurantsCubit searchRestaurantsCubit;
  final ScrollController scrollController = ScrollController();
  LocationList restaurantList;
  final String locationText;
  final double currentLat;
  final double currentLng;
  bool isLoadingMore = false;
  String keywords = '';

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        searchRestaurantsCubit.searchMoreRestaurants(restaurantList);
      }
    });
  }

  SearchRestaurant(
      {this.currentLat,
      this.currentLng,
      this.locationText,
      this.searchRestaurantsCubit});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          query = '';
        },
        icon: BackButtonIcon());
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0.5,
      ),
      primaryColor: AppColors.MAIN_COLOR,
      textTheme:
          TextTheme(title: GoogleFonts.lato(fontSize: 20, color: Colors.white)),
      primaryIconTheme: IconThemeData(
        size: 50,
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixStyle: GoogleFonts.lato(fontSize: 20, color: Colors.white54),
        border: InputBorder.none,
        hintStyle: GoogleFonts.lato(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Enter food or restaurant name......';

  @override
  Widget buildResults(BuildContext context) {
    SizeConfig().init(context);
    if (query.isNotEmpty) {
      keywords = query;
      searchRestaurantsCubit.searchRestaurantsByName(locationText, keywords);
    }
    return BlocConsumer<SearchRestaurantsCubit, SearchRestaurantState>(
        bloc: searchRestaurantsCubit,
        listener: (context, state) {
          if (state.status.isLoadingMoreRestaurants) {
            isLoadingMore = true;
          } else if (state.status.isLoadedMoreRestaurants) {
            isLoadingMore = false;
            restaurantList = state.nextLocations;
          } else if (state.status.isLoadMoreRestaurantError) {
            isLoadingMore = false;
            restaurantList = state.nextLocations;
          }
        },
        builder: (context, state) {
          setupScrollController(context);
          if (state.status.isLoading) {
            return LoadingViewForRestaurant(message: 'Loading...');
          } else {
            if (state.status.isLoaded) {
              restaurantList = state.locations;
            } else if (state.status.isLoadError) {
              print('error');
            }
            return Container(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 1),
              height: SizeConfig.blockSizeVertical * 90,
              child: ListView.separated(
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index < restaurantList.results.length) {
                    return RestaurantCard(
                      currentLat: currentLat,
                      currentLng: currentLng,
                      placeInfomation: restaurantList.results[index],
                      restaurantAction: () {
                        Navigator.pushNamed(context, '/restaurantsDetail',
                            arguments: RestaurantDetailsArgs(
                                restaurantList.results[index].photos != null
                                    ? restaurantList.results[index].photos.first
                                        .photoReference
                                    : null,
                                restaurantList.results[index].placeId,
                                currentLat,
                                currentLng));
                      },
                    );
                  } else {
                    Timer(Duration(milliseconds: 30), () {
                      scrollController
                          .jumpTo(scrollController.position.maxScrollExtent);
                    });
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: CupertinoActivityIndicator()),
                    );
                  }
                },
                itemCount:
                    restaurantList.results.length + (isLoadingMore ? 1 : 0),
                separatorBuilder: (context, index) => SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
              ),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
