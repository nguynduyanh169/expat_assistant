import 'package:camera_camera/camera_camera.dart';
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

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  String _addressText = "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(30, 193, 194, 30),
          toolbarHeight: SizeConfig.blockSizeVertical * 10,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Find Your Restaurant',
            style: GoogleFonts.ubuntu(fontSize: 22),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  print('tapped');
                },
                icon: Icon(CupertinoIcons.search)),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
        ),
      body: BlocProvider(
        create: (context) => RestaurantsCubit()..loadDataToScreen(),
        child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
          builder: (context, state){
            if(state is LoadingScreen){
              return Container(
                child: Text('loading'),
              );
            }else if(state is LoadScreenError){
              return Container(
                child: Text(state.errorMessage),
              );
            }else{
              if(state is LoadScreenSuccess){
                _addressText = state.currentAddress;
              }
              return Container(
                padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig.blockSizeHorizontal *3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                    Container(
                      child: Text('Your location: ', style: TextStyle(color: Colors.black54, fontSize: 15),),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                          child: Icon(LineIcons.crosshairs, color: Colors.white,),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(30, 193, 194, 30),
                              border: Border.all(
                                color: Color.fromRGBO(30, 193, 194, 30),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 80,
                          child: Text(_addressText,),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                        width: SizeConfig.blockSizeHorizontal * 75,
                        height: SizeConfig.blockSizeVertical * 12,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 231, 229, 30),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26.withOpacity(0.05),
                                  offset: Offset(0.0, 6.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.10)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 29,
                              child: Text('Find restaurants by taking a food', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),),
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 15,
                              height: SizeConfig.blockSizeVertical * 10,
                              child: Image.asset("assets/images/camera_food_logo.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 3,
                    ),
                    Container(
                      child: Text('Near you ', style: TextStyle(color: Colors.black87, fontSize: 15),),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Container(
                      height: SizeConfig.blockSizeVertical * 50.5,
                      child: ListView(
                        children: [
                          RestaurantCard(),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                          RestaurantCard(),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                          RestaurantCard(),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                          RestaurantCard(),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                          RestaurantCard(),
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
}
