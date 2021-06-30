import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/appointment_card.dart';
import 'package:expat_assistant/src/widgets/event_card.dart';
import 'package:expat_assistant/src/widgets/news_card.dart';
import 'package:expat_assistant/src/widgets/thumbnail_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen();

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 244, 244, 30),
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        backgroundColor: Colors.white,
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        elevation: 0.5,
        foregroundColor: Colors.black54,
        automaticallyImplyLeading: false,
        leading: Container(
          child: Image(
            width: SizeConfig.blockSizeHorizontal * 11,
            height: SizeConfig.blockSizeVertical * 11,
            image: AssetImage('assets/images/app_icon.png'),
          ),
        ),
        title: Text(
          'Home',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        actions: [
          InkWell(
            child: Icon(
              CupertinoIcons.bell,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 3,
          )
        ],
        centerTitle: false,
      ),
      body: Container(
        height: SizeConfig.blockSizeVertical * 90,
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 1,
            right: SizeConfig.blockSizeHorizontal * 1),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              child: Text(
                'Welcome Bao!',
                style:
                    GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 2,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 90,
              height: SizeConfig.blockSizeVertical * 20,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ThumbnailCard(),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  ThumbnailCard(),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  ThumbnailCard(),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  ThumbnailCard(),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Services',
                    style: GoogleFonts.lato(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 99, 99, 30)),
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Container(
                    //width: SizeConfig.blockSizeHorizontal * 30,
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
                          LineIcons.hamburger,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Text('Nearby Restaurants', style: GoogleFonts.lato())
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
                          LineIcons.phoneVolume,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Text('Incoming Appointments', style: GoogleFonts.lato())
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
                          LineIcons.calendarCheck,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Text('Incoming Events', style: GoogleFonts.lato())
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
                          LineIcons.book,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Text('Latest Vietnamese Lessons',
                            style: GoogleFonts.lato())
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Lasted News',
                    style: GoogleFonts.lato(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 99, 99, 30)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.BLOGS);
                    },
                    child: Text('See more',
                        style: GoogleFonts.lato(
                            color: Color.fromRGBO(30, 193, 194, 30))),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1),
              child: ChannelCard(),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1),
              child: ChannelCard(),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1),
              child: ChannelCard(),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1),
              child: ChannelCard(),
            ),
          ],
        ),
      ),
    );
  }
}
