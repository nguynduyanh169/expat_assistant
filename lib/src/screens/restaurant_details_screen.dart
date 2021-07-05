import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/thumbnail_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        //toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Restaurant Details',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print('tapped');
                Navigator.popUntil(context, ModalRoute.withName(RouteName.HOME_PAGE));
              },
              icon: Icon(
                CupertinoIcons.home,
                color: Colors.black,
              )),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
      ),
      // body: Container(
      //   height: SizeConfig.blockSizeVertical * 87,
      //   child: ListView(
      //     children: <Widget>[
      //       ClipRRect(
      //         child: Image(
      //           height: SizeConfig.blockSizeVertical * 25,
      //           fit: BoxFit.cover,
      //           image: AssetImage('assets/images/demo_food.jpg'),
      //         ),
      //       ),
      //       SizedBox(
      //         height: SizeConfig.blockSizeVertical * 1,
      //       ),
      //       Container(
      //         padding:
      //         EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
      //         child: Text(
      //           'Phở Hoà',
      //           style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
      //         ),
      //       ),
      //       SizedBox(
      //         height: SizeConfig.blockSizeVertical * 2,
      //       ),
      //       Container(
      //         padding:
      //         EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
      //         child: Row(
      //           children: <Widget>[
      //             Container(
      //               padding: EdgeInsets.all(
      //                   SizeConfig.blockSizeHorizontal * 2),
      //               child: Icon(
      //                 LineIcons.mapMarked,
      //                 color: Colors.white,
      //               ),
      //               decoration: BoxDecoration(
      //                   color: Color.fromRGBO(30, 193, 194, 30),
      //                   border: Border.all(
      //                     color: Color.fromRGBO(30, 193, 194, 30),
      //                   ),
      //                   borderRadius:
      //                   BorderRadius.all(Radius.circular(20))),
      //             ),
      //             SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
      //             Container(
      //               padding: EdgeInsets.all(
      //                   SizeConfig.blockSizeHorizontal * 2),
      //               child: Icon(
      //                 LineIcons.phone,
      //                 color: Colors.white,
      //               ),
      //               decoration: BoxDecoration(
      //                   color: Color.fromRGBO(30, 193, 194, 30),
      //                   border: Border.all(
      //                     color: Color.fromRGBO(30, 193, 194, 30),
      //                   ),
      //                   borderRadius:
      //                   BorderRadius.all(Radius.circular(20))),
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         height: SizeConfig.blockSizeVertical * 2,
      //       ),
      //       Container(
      //         padding:
      //         EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
      //         child: Row(
      //           children: <Widget>[
      //             Icon(LineIcons.businessTime, color: Color.fromRGBO(30, 193, 194, 30),),
      //             SizedBox(
      //               width: SizeConfig.blockSizeHorizontal * 2,
      //             ),
      //             Text('10:00 AM - 12:00 AM', style: GoogleFonts.lato(),)
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         height: SizeConfig.blockSizeVertical * 1,
      //       ),
      //       Container(
      //         padding:
      //         EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
      //         child: Row(
      //           children: <Widget>[
      //             Icon(LineIcons.mapMarked, color: Color.fromRGBO(30, 193, 194, 30),),
      //             SizedBox(
      //               width: SizeConfig.blockSizeHorizontal * 2,
      //             ),
      //             Text('District 9, HCM city', style: GoogleFonts.lato(),)
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         height: SizeConfig.blockSizeVertical * 1,
      //       ),
      //       Container(
      //         padding:
      //         EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
      //         child: Row(
      //           children: <Widget>[
      //             Icon(LineIcons.starAlt, color: Color.fromRGBO(252, 191, 7, 30),),
      //             SizedBox(
      //               width: SizeConfig.blockSizeHorizontal * 2,
      //             ),
      //             Text('4.5', style: GoogleFonts.lato(),)
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         height: SizeConfig.blockSizeVertical * 1,
      //       ),
      //       Container(
      //         //height: SizeConfig.blockSizeVertical * 30,
      //         padding:
      //         EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
      //         child: Text(
      //           "Heri Purwanto's works engage with the viewers, as their dreamy compositions ask more than they answer - how do we imagine living with the imbalance we have created in our own habitat? Using the symbols of the cloud, the tree, and the little house, Heri Purwanto approaches the complex subject of climate change and environmental degradation in a humorous way.Born in Banyumas, Indonesia in 1975. Graduated from Indonesian Arts Institute, Yogyakarta. His work reflects how he feels about the complexities and problems of life expressed through the symbolic form of a house. His house is a “little world” - a place of refuge, where different kinds of socialisation amongst its occupants take place.",
      //           style: GoogleFonts.lato(fontSize: 15),
      //         ),
      //       ),
      //       Container(
      //         padding:
      //         EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      //         child: Text(
      //           'Images:',
      //           style: GoogleFonts.lato(
      //               fontSize: 16,
      //               fontWeight: FontWeight.w500,
      //               color: Color.fromRGBO(0, 99, 99, 30)),
      //         ),
      //       ),
      //       Container(
      //         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
      //         width: SizeConfig.blockSizeHorizontal * 50,
      //         height: SizeConfig.blockSizeVertical * 15,
      //         child: ListView(
      //           scrollDirection: Axis.horizontal,
      //           children: <Widget>[
      //             Container(
      //               width: SizeConfig.blockSizeHorizontal * 30,
      //               height: SizeConfig.blockSizeVertical * 15,
      //               decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(10.0),
      //                   boxShadow: [
      //                     BoxShadow(
      //                         color: Colors.black26.withOpacity(0.1),
      //                         offset: Offset(0.0, 6.0),
      //                         blurRadius: 10.0,
      //                         spreadRadius: 0.10)
      //                   ]),
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.all(Radius.circular(10)),
      //                 child: Image(
      //                   // width: SizeConfig.blockSizeHorizontal * 90,
      //                   // height: SizeConfig.blockSizeVertical * 20,
      //                   image: AssetImage('assets/images/demo_food.jpg'),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
      //             Container(
      //               width: SizeConfig.blockSizeHorizontal * 30,
      //               height: SizeConfig.blockSizeVertical * 15,
      //               decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(10.0),
      //                   boxShadow: [
      //                     BoxShadow(
      //                         color: Colors.black26.withOpacity(0.1),
      //                         offset: Offset(0.0, 6.0),
      //                         blurRadius: 10.0,
      //                         spreadRadius: 0.10)
      //                   ]),
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.all(Radius.circular(10)),
      //                 child: Image(
      //                   // width: SizeConfig.blockSizeHorizontal * 90,
      //                   // height: SizeConfig.blockSizeVertical * 20,
      //                   image: AssetImage('assets/images/demo_food.jpg'),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
      //             Container(
      //               width: SizeConfig.blockSizeHorizontal * 30,
      //               height: SizeConfig.blockSizeVertical * 15,
      //               decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(10.0),
      //                   boxShadow: [
      //                     BoxShadow(
      //                         color: Colors.black26.withOpacity(0.1),
      //                         offset: Offset(0.0, 6.0),
      //                         blurRadius: 10.0,
      //                         spreadRadius: 0.10)
      //                   ]),
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.all(Radius.circular(10)),
      //                 child: Image(
      //                   // width: SizeConfig.blockSizeHorizontal * 90,
      //                   // height: SizeConfig.blockSizeVertical * 20,
      //                   image: AssetImage('assets/images/demo_food.jpg'),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
      //             Container(
      //               width: SizeConfig.blockSizeHorizontal * 30,
      //               height: SizeConfig.blockSizeVertical * 15,
      //               decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(10.0),
      //                   boxShadow: [
      //                     BoxShadow(
      //                         color: Colors.black26.withOpacity(0.1),
      //                         offset: Offset(0.0, 6.0),
      //                         blurRadius: 10.0,
      //                         spreadRadius: 0.10)
      //                   ]),
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.all(Radius.circular(10)),
      //                 child: Image(
      //                   // width: SizeConfig.blockSizeHorizontal * 90,
      //                   // height: SizeConfig.blockSizeVertical * 20,
      //                   image: AssetImage('assets/images/demo_food.jpg'),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
      //             Container(
      //               width: SizeConfig.blockSizeHorizontal * 30,
      //               height: SizeConfig.blockSizeVertical * 15,
      //               decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(10.0),
      //                   boxShadow: [
      //                     BoxShadow(
      //                         color: Colors.black26.withOpacity(0.1),
      //                         offset: Offset(0.0, 6.0),
      //                         blurRadius: 10.0,
      //                         spreadRadius: 0.10)
      //                   ]),
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.all(Radius.circular(10)),
      //                 child: Image(
      //                   // width: SizeConfig.blockSizeHorizontal * 90,
      //                   // height: SizeConfig.blockSizeVertical * 20,
      //                   image: AssetImage('assets/images/demo_food.jpg'),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: Container(
          height: SizeConfig.blockSizeVertical * 89,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ClipRRect(
                    child: Image(
                      height: SizeConfig.blockSizeVertical * 25,
                      width: SizeConfig.blockSizeHorizontal * 100,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/demo_food.jpg'),
                    ),
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 60,
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig.blockSizeHorizontal * 3),
                height: SizeConfig.blockSizeVertical * 89,
                child: ListView(
                  children: [
                    SizedBox(height: SizeConfig.blockSizeVertical * 23,),
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
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Phở Hoà',
                            style: GoogleFonts.lato(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                    'Phở',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  )),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              Container(
                                  child: Text(
                                    '.',
                                    style: GoogleFonts.lato(fontSize: 15),
                                  )),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        LineIcons.starAlt,
                                        color: Color.fromRGBO(252, 191, 7, 30),
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal * 1,
                                      ),
                                      Container(
                                          child: Text(
                                            '4.5',
                                            style: GoogleFonts.lato(fontSize: 20),
                                          ))
                                    ],
                                  )),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              Container(
                                  child: Text(
                                    '.',
                                    style: GoogleFonts.lato(fontSize: 15),
                                  )),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              Container(
                                  child: Text(
                                    'Opening Now',
                                    style: GoogleFonts.lato(fontSize: 20, color: Colors.green),
                                  )),
                            ],
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                          Divider(
                            height: 1,
                            color: Colors.black45,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal *0.5),
                            leading: Icon(LineIcons.mapMarked, size: 30, color: Colors.green,),
                            title: Text('District 9, HCM city', style: GoogleFonts.lato(fontSize: 16),),
                            subtitle: Text('0.5 km', style: GoogleFonts.lato(fontSize: 13),),
                            trailing: Icon(CupertinoIcons.forward, size: 30,),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.black45,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal *0.5),
                            leading: Icon(LineIcons.businessTime, size: 30, color: Colors.green,),
                            title: Text('10:00 - 21:00', style: GoogleFonts.lato(fontSize: 16),),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.black45,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal *0.5),
                            leading: Icon(LineIcons.phoneVolume, size: 30, color: Colors.green,),
                            title: Text('0903456785', style: GoogleFonts.lato(fontSize: 16),),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                    Text(
                      'Images',
                      style: GoogleFonts.lato(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 99, 99, 30)),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 90,
                      height: SizeConfig.blockSizeVertical * 20,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          ThumbnailCard(),
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                          ThumbnailCard(),
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                          ThumbnailCard(),
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                          ThumbnailCard(),
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
