import 'package:expandable_text/expandable_text.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/restaurant_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantByFoodScreen extends StatefulWidget {
  _RestaurantByFoodState createState() => _RestaurantByFoodState();
}

class _RestaurantByFoodState extends State<RestaurantByFoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Phở',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print('tapped');
                Navigator.popUntil(context, ModalRoute.withName("/homePage"));
              },
              icon: Icon(CupertinoIcons.home, color: Colors.black,)),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
        height: SizeConfig.blockSizeVertical * 90,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.1),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Phở',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                  Row(
                    children: <Widget>[
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 29,
                        height: SizeConfig.blockSizeVertical * 12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26.withOpacity(0.1),
                                  offset: Offset(0.0, 6.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.10)
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image(
                            // width: SizeConfig.blockSizeHorizontal * 90,
                            // height: SizeConfig.blockSizeVertical * 20,
                            image: AssetImage('assets/images/demo_food.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 29,
                        height: SizeConfig.blockSizeVertical * 12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26.withOpacity(0.1),
                                  offset: Offset(0.0, 6.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.10)
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image(
                            // width: SizeConfig.blockSizeHorizontal * 90,
                            // height: SizeConfig.blockSizeVertical * 20,
                            image: AssetImage('assets/images/demo_food.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 29,
                        height: SizeConfig.blockSizeVertical * 12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26.withOpacity(0.1),
                                  offset: Offset(0.0, 6.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.10)
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image(
                            // width: SizeConfig.blockSizeHorizontal * 90,
                            // height: SizeConfig.blockSizeVertical * 20,
                            image: AssetImage('assets/images/demo_food.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                  ExpandableText(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                    expandText: 'read more',
                    collapseText: 'read less',
                    linkStyle: GoogleFonts.lato(),
                    maxLines: 4,
                    linkColor: Colors.blue,
                    style: GoogleFonts.lato(),
                  ),

                ],
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              child: Text(
                'Restaurants which have Phở dishes',
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              height: SizeConfig.blockSizeVertical * 60,
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
      ),
    );
  }
}
