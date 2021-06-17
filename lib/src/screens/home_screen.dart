import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/appointment_card.dart';
import 'package:expat_assistant/src/widgets/event_card.dart';
import 'package:expat_assistant/src/widgets/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

class HomeScreen extends StatefulWidget {
  Function changeTab;

  HomeScreen({@required this.changeTab});

  _HomeScreenState createState() => _HomeScreenState(changeTab);
}

class _HomeScreenState extends State<HomeScreen> {
  Function _changeTab;

  _HomeScreenState(this._changeTab);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 244, 244, 30),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        elevation: 1,
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
          style: GoogleFonts.lato(fontSize: 22),
        ),
        actions: [
          InkWell(
            child: Icon(
              CupertinoIcons.bell_fill,
              size: 30,
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 5,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteName.PROFILE);
            },
            child: Container(
              child: Image(
                width: SizeConfig.blockSizeHorizontal * 11,
                height: SizeConfig.blockSizeVertical * 11,
                image: AssetImage('assets/images/profile.png'),
              ),
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
            left: SizeConfig.blockSizeHorizontal * 3,
            right: SizeConfig.blockSizeHorizontal * 3),
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
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RouteName.WALLET);
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 5,
                    right: SizeConfig.blockSizeHorizontal * 5),
                width: SizeConfig.blockSizeHorizontal * 95,
                height: SizeConfig.blockSizeVertical * 23,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color.fromRGBO(30, 193, 194, 100),
                        const Color.fromRGBO(30, 193, 194, 30),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26.withOpacity(0.1),
                          offset: Offset(0.0, 6.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.10)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 15,
                      height: SizeConfig.blockSizeVertical * 10,
                      child: Image.asset("assets/images/app_logo.png"),
                    ),
                    Container(
                      child: Text(
                        '3.362.000 VND',
                        style:
                        GoogleFonts.lato(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1.5,
                    ),
                    Container(
                      child: Text(
                        'Balance',
                        style:
                        GoogleFonts.lato(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Upcoming Appointment',
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 99, 99, 30)),
                  ),
                  Text('See more',
                      style: GoogleFonts.lato(
                          color: Color.fromRGBO(30, 193, 194, 30)))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  right: SizeConfig.blockSizeHorizontal * 5),
              child: AppointmentCard(),
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Upcoming Event',
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 99, 99, 30)),
                  ),
                  InkWell(
                    onTap: () {
                      _changeTab(2);
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
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: EventCard(
                eventAction: () {
                  Navigator.pushNamed(context, RouteName.EVENT_DETAILS);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Lasted News',
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 99, 99, 30)),
                  ),
                  InkWell(
                    onTap: () {
                      _changeTab(2);
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
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: NewsCard(
                newsAction: () {
                  Navigator.pushNamed(context, RouteName.EVENT_DETAILS);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
