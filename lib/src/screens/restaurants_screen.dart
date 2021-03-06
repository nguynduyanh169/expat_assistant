import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/restaurants_cubit.dart';
import 'package:expat_assistant/src/cubits/search_restaurants_cubit.dart';
import 'package:expat_assistant/src/models/place.dart';
import 'package:expat_assistant/src/repositories/restaurant_repository.dart';
import 'package:expat_assistant/src/screens/food_camera_screen.dart';
import 'package:expat_assistant/src/screens/restaurant_by_food_screen.dart';
import 'package:expat_assistant/src/screens/restaurant_details_screen.dart';
import 'package:expat_assistant/src/states/restaurants_state.dart';
import 'package:expat_assistant/src/widgets/alert_dialog_vocabulary.dart';
import 'package:expat_assistant/src/widgets/error.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:expat_assistant/src/widgets/restaurant_card.dart';
import 'package:expat_assistant/src/widgets/search_restaurants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

class RestaurantsScreen extends StatefulWidget {
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen>
    with AutomaticKeepAliveClientMixin<RestaurantsScreen> {
  String _addressText = "Locating....";
  double currentLat = 0;
  double currentLng = 0;
  final picker = ImagePicker();
  LocationList restaurantList;
  bool isLoadingMore = false;
  final ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<RestaurantsCubit>(context)
            .getNextRestaurants(restaurantList);
      }
    });
  }

  Future getImage(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      BlocProvider.of<RestaurantsCubit>(context).uploadImage(file);
    } else {
      CustomSnackBar.showSnackBar(
          context: context,
          message: 'No image selected!',
          color: Colors.blueAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(245, 244, 244, 30),
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        backgroundColor: AppColors.MAIN_COLOR,
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Find your restaurant',
          style: GoogleFonts.lato(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            RestaurantsCubit(RestaurantRepository())..loadDataToScreen(),
        child: BlocConsumer<RestaurantsCubit, RestaurantsState>(
          listener: (context, state) {
            if (state.status.isUploadingImage) {
              CustomLoadingDialog.loadingDialog(
                  context: context, message: 'Please wait...');
            } else if (state.status.isUploadedImage) {
              BlocProvider.of<RestaurantsCubit>(context)
                  .detectFood(state.imageUrl);
            } else if (state.status.isUploadImageError) {
              Navigator.pop(context);
              CustomSnackBar.showSnackBar(
                  context: context,
                  message: 'An error occurs while uploading image',
                  color: Colors.red);
            } else if (state.status.isRecognizeSuccess) {
              Navigator.pop(context);
              Navigator.pushNamed(context, RouteName.RESTAURANTS_BY_FOOD,
                  arguments: RestaurantByFoodArgs(
                      state.foodName,
                      "$currentLat,$currentLng",
                      currentLat,
                      currentLng,
                      state.imageUrl));
            } else if (state.status.isRecognizeFoodError) {
              Navigator.pop(context);
              CustomSnackBar.showSnackBar(
                  context: context,
                  message: state.errorMessage,
                  color: Colors.red);
            } else if (state.status.isLoadingMoreRestaurants) {
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
            } else if (state.status.isLoadError) {
              return DisplayError(
                  message: 'An error while getting restaurants',
                  reload: () {
                    BlocProvider.of<RestaurantsCubit>(context)
                        .loadDataToScreen();
                  });
            } else {
              if (state.status.isLoaded) {
                _addressText = state.currentAddress;
                restaurantList = state.locations;
                currentLat = state.currentLat;
                currentLng = state.currentLng;
              }
              return Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 2,
                    right: SizeConfig.blockSizeHorizontal * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Container(
                      child: Text(
                        'Your location: ',
                        style: GoogleFonts.lato(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 99, 99, 30)),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            BlocProvider.of<RestaurantsCubit>(context)
                                .loadDataToScreen();
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2),
                            child: Icon(
                              LineIcons.crosshairs,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                                color: AppColors.MAIN_COLOR,
                                border: Border.all(
                                  color: AppColors.MAIN_COLOR,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 80,
                          child: Text(
                            _addressText,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    BlocProvider(
                      create: (context) =>
                          SearchRestaurantsCubit(RestaurantRepository()),
                      child: Builder(
                        builder: (context) => Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeHorizontal * 2,
                              bottom: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  showSearch<Result>(
                                      context: context,
                                      delegate: SearchRestaurant(
                                          currentLat: currentLat,
                                          currentLng: currentLng,
                                          locationText: currentLat.toString() +
                                              "," +
                                              currentLng.toString(),
                                          searchRestaurantsCubit: BlocProvider
                                              .of<SearchRestaurantsCubit>(
                                                  context)));
                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 75,
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color.fromRGBO(30, 193, 194,
                                            30), // set border color
                                        width: 1.0), // set border width
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10.0)), // set rounded corner radius
                                  ),
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                        hintText: '   What do you want to eat?',
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            CupertinoIcons.search,
                                            color: Color.fromRGBO(
                                                30, 193, 194, 30),
                                          ),
                                          iconSize: 30.0,
                                          onPressed: () {},
                                        ),
                                        hintStyle: GoogleFonts.lato()),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  bool check =
                                      await showCameraOptions(context: context);
                                  if (check) {
                                    getImage(context);
                                  } else {
                                    Navigator.pushNamed(context, '/foodCamera',
                                        arguments: FoodCameraArguments(
                                          currentLat,
                                          currentLng,
                                          currentLat.toString() +
                                              "," +
                                              currentLng.toString(),
                                        ));
                                  }
                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  height: SizeConfig.blockSizeVertical * 10,
                                  child: Image.asset(
                                      "assets/images/camera_food_logo.png"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Near you ',
                        style: GoogleFonts.lato(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 99, 99, 30)),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeHorizontal * 1),
                      height: SizeConfig.blockSizeVertical * 51,
                      child: ListView.separated(
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          if (index < restaurantList.results.length) {
                            return RestaurantCard(
                              currentLat: currentLat,
                              currentLng: currentLng,
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
                                        currentLat,
                                        currentLng));
                              },
                            );
                          } else {
                            Timer(Duration(milliseconds: 30), () {
                              scrollController.jumpTo(
                                  scrollController.position.maxScrollExtent);
                            });
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  Center(child: CupertinoActivityIndicator()),
                            );
                          }
                        },
                        itemCount: restaurantList.results.length +
                            (isLoadingMore ? 1 : 0),
                        separatorBuilder: (context, index) => SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  // ignore: todo
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
