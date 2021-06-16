import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class EventDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Event Details',
          style: GoogleFonts.lato(fontSize: 22),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print('tapped');
                Navigator.popUntil(context, ModalRoute.withName("/homePage"));
              },
              icon: Icon(CupertinoIcons.home)),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 80,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/demo_event.png'),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                    child: Text(
                      'Wednesday - June 04, 2021',
                      style: GoogleFonts.lato(color: Color.fromRGBO(201, 148, 41, 30)),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                    child: Text(
                      'Learn how to make passive income',
                      style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                          EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            children: <Widget>[
                              Icon(CupertinoIcons.time, color: Color.fromRGBO(30, 193, 194, 30),),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              Text('10:00 AM - 12:00 AM')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Container(
                          padding:
                          EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            children: <Widget>[
                              Icon(CupertinoIcons.location, color: Color.fromRGBO(30, 193, 194, 30),),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              Text('District 9, HCM city')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Container(
                          padding:
                          EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            children: <Widget>[
                              Icon(CupertinoIcons.person_2, color: Color.fromRGBO(30, 193, 194, 30)),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              Text('20 people will going', style: GoogleFonts.lato(),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                    child: Text(
                      'Description',
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 30,
                    padding:
                    EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                    child: Text(
                      "Heri Purwanto's works engage with the viewers, as their dreamy compositions ask more than they answer - how do we imagine living with the imbalance we have created in our own habitat? Using the symbols of the cloud, the tree, and the little house, Heri Purwanto approaches the complex subject of climate change and environmental degradation in a humorous way.Born in Banyumas, Indonesia in 1975. Graduated from Indonesian Arts Institute, Yogyakarta. His work reflects how he feels about the complexities and problems of life expressed through the symbolic form of a house. His house is a “little world” - a place of refuge, where different kinds of socialisation amongst its occupants take place.",
                      style: GoogleFonts.lato(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26.withOpacity(0.2),
                          offset: Offset(0.0, 6.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.10)
                    ]),
                height: SizeConfig.blockSizeVertical * 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/map');
                      },
                      child: Container(
                        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
                        child: Icon(LineIcons.alternateMapMarked, size: 35, color: Color.fromRGBO(30, 193, 194, 30),),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 70,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4)),
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(30, 193, 194, 30)),
                          ),
                          child: Text("Join in"),
                          onPressed: () {

                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}