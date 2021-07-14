import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/restaurants_cubit.dart';
import 'package:expat_assistant/src/states/restaurants_state.dart';
import 'package:expat_assistant/src/widgets/restaurant_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class RestaurantsScreen extends StatefulWidget {
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> with AutomaticKeepAliveClientMixin<RestaurantsScreen>{
  String _addressText = "Locating....";

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
        //toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Find your restaurant',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocProvider(
        create: (context) => RestaurantsCubit()..loadDataToScreen(),
        child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
          builder: (context, state) {
            if (state is LoadingScreen) {
              return Container(
                child: Text('loading'),
              );
            } else if (state is LoadScreenError) {
              return Container(
                child: Text(state.errorMessage),
              );
            } else {
              if (state is LoadScreenSuccess) {
                _addressText = state.currentAddress;
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
                        Container(
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
                    // Center(
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.pushNamed(context, '/foodCamera');
                    //     },
                    //     child: Container(
                    //       padding: EdgeInsets.all(
                    //           SizeConfig.blockSizeHorizontal * 3),
                    //       width: SizeConfig.blockSizeHorizontal * 75,
                    //       height: SizeConfig.blockSizeVertical * 12,
                    //       decoration: BoxDecoration(
                    //           color: Color.fromRGBO(255, 231, 229, 30),
                    //           borderRadius: BorderRadius.circular(10.0),
                    //           boxShadow: [
                    //             BoxShadow(
                    //                 color: Colors.black26.withOpacity(0.05),
                    //                 offset: Offset(0.0, 6.0),
                    //                 blurRadius: 10.0,
                    //                 spreadRadius: 0.10)
                    //           ]),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         children: <Widget>[
                    //           Container(
                    //             width: SizeConfig.blockSizeHorizontal * 29,
                    //             child: Text(
                    //               'Find restaurants by taking a food',
                    //               textAlign: TextAlign.center,
                    //               style: GoogleFonts.lato(color: Colors.black54),
                    //             ),
                    //           ),
                    //           Container(
                    //             width: SizeConfig.blockSizeHorizontal * 15,
                    //             height: SizeConfig.blockSizeVertical * 10,
                    //             child: Image.asset(
                    //                 "assets/images/camera_food_logo.png"),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 100,
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeHorizontal * 2,
                          bottom: SizeConfig.blockSizeHorizontal * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 75,
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 2,
                                right: SizeConfig.blockSizeHorizontal * 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromRGBO(
                                      30, 193, 194, 30), // set border color
                                  width: 1.0), // set border width
                              borderRadius: BorderRadius.all(Radius.circular(
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
                                      color: Color.fromRGBO(30, 193, 194, 30),
                                    ),
                                    iconSize: 30.0,
                                  ),
                                  hintStyle: GoogleFonts.lato()),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/foodCamera');
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
                      height: SizeConfig.blockSizeVertical * 5,
                      //padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            //width: SizeConfig.blockSizeHorizontal * 30,
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26.withOpacity(0.05),
                                      offset: Offset(0.0, 6.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.10)
                                ]),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  LineIcons.star,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('High Ratings', style: GoogleFonts.lato())
                              ],
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26.withOpacity(0.05),
                                      offset: Offset(0.0, 6.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.10)
                                ]),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  LineIcons.businessTime,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('Opening Now', style: GoogleFonts.lato())
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeHorizontal * 1),
                      height: SizeConfig.blockSizeVertical * 45.2,
                      child: ListView(
                        children: [
                          RestaurantCard(
                            restaurantAction: () {
                              Navigator.pushNamed(
                                  context, '/restaurantsDetail');
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          RestaurantCard(
                            restaurantAction: () {
                              Navigator.pushNamed(
                                  context, '/restaurantsDetail');
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          RestaurantCard(
                            restaurantAction: () {
                              Navigator.pushNamed(
                                  context, '/restaurantsDetail');
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          RestaurantCard(
                            restaurantAction: () {
                              Navigator.pushNamed(
                                  context, '/restaurantsDetail');
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          RestaurantCard(
                            restaurantAction: () {
                              Navigator.pushNamed(
                                  context, '/restaurantsDetail');
                            },
                          ),
                        ],
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
