import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/restaurant_by_food_cubit.dart';
import 'package:expat_assistant/src/models/place.dart';
import 'package:expat_assistant/src/repositories/restaurant_repository.dart';
import 'package:expat_assistant/src/screens/restaurant_details_screen.dart';
import 'package:expat_assistant/src/states/restaurant_by_food_state.dart';
import 'package:expat_assistant/src/widgets/error.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/restaurant_card.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantByFoodScreen extends StatefulWidget {
  _RestaurantByFoodState createState() => _RestaurantByFoodState();
}

class _RestaurantByFoodState extends State<RestaurantByFoodScreen> {
  LocationList restaurantList;
  bool isLoadingMore = false;
  final ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<RestaurantByFoodCubit>(context)
            .getNextRestaurants(restaurantList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as RestaurantByFoodArgs;
    return BlocProvider(
      create: (context) => RestaurantByFoodCubit(RestaurantRepository())
        ..getRestaurantsByFood(args.foodName, args.locationText),
      child: Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: SizeConfig.blockSizeVertical * 25,
              backgroundColor: AppColors.MAIN_COLOR,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName(RouteName.HOME_PAGE));
                    },
                    icon: Icon(
                      CupertinoIcons.home,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 4,
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  args.foodName,
                  style: GoogleFonts.lato(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                background: Stack(
                  children: <Widget>[
                    ExtendedImage.network(
                      args.captureImage,
                      fit: BoxFit.cover,
                      width: SizeConfig.blockSizeHorizontal * 100,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                            Colors.black12.withOpacity(0.3),
                            Colors.black54,
                          ],
                              stops: [
                            0.0,
                            2.0
                          ])),
                    )
                  ],
                ),
              ),
            ),
            BlocConsumer<RestaurantByFoodCubit, RestaurantByFoodState>(
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
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 30,
                      ),
                      LoadingView(
                        message: 'Loading...',
                      )
                    ]),
                  );
                } else if (state.status.isLoadError) {
                  return DisplayError(
                      message: 'An error while getting restaurants',
                      reload: () {
                        BlocProvider.of<RestaurantByFoodCubit>(context)
                            .getRestaurantsByFood(args.foodName, args.locationText);
                      });
                } else {
                  if (state.status.isLoaded) {
                    restaurantList = state.locations;
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index < restaurantList.results.length) {
                        return Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            RestaurantCard(
                              currentLat: args.currentLat,
                              currentLng: args.currentLng,
                              placeInfomation: restaurantList.results[index],
                              restaurantAction: () {
                                Navigator.pushNamed(
                                    context, '/restaurantsDetail',
                                    arguments: RestaurantDetailsArgs(
                                        restaurantList.results[index].photos !=
                                                null
                                            ? restaurantList.results[index]
                                                .photos.first.photoReference
                                            : null,
                                        restaurantList.results[index].placeId,
                                        args.currentLat,
                                        args.currentLng));
                              },
                            ),
                          ],
                        );
                      } else {
                        Timer(Duration(milliseconds: 30), () {
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        });
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: CupertinoActivityIndicator()),
                        );
                      }
                    },
                        childCount: restaurantList.results.length +
                            (isLoadingMore ? 1 : 0)),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class RestaurantByFoodArgs {
  final String foodName;
  final String captureImage;
  final String locationText;
  final double currentLat;
  final double currentLng;

  RestaurantByFoodArgs(this.foodName, this.locationText, this.currentLat,
      this.currentLng, this.captureImage);
}
