import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/appointment_card.dart';
import 'package:expat_assistant/src/widgets/specialist_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class SpecialistsScreen extends StatefulWidget {
  _SpecialistsScreenState createState() => _SpecialistsScreenState();
}

class _SpecialistsScreenState extends State<SpecialistsScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 244, 244, 2),
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
        //leadingWidth: SizeConfig.blockSizeHorizontal * 10,
        automaticallyImplyLeading: true,
        //leading: Text('Learn Vietnamese', style: GoogleFonts.ubuntu(fontSize: 22),),
        title: Text(
          'Find your specialist',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        actions: [
          InkWell(
            child: Icon(CupertinoIcons.search),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
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
              child: AppointmentCard(
                action: () {
                  Navigator.pushNamed(context, RouteName.CALLING);
                },
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Let's find your specialist",
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
              height: SizeConfig.blockSizeVertical * 5,
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    //width: SizeConfig.blockSizeHorizontal * 30,
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(30, 193, 194, 30),
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
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Text('All Major',
                            style: GoogleFonts.lato(color: Colors.white))
                      ],
                    ),
                  ),
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
                          LineIcons.balanceScale,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Text('Lawyer', style: GoogleFonts.lato())
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
                          LineIcons.laptop,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Text('IT support', style: GoogleFonts.lato())
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
                          LineIcons.lightningBolt,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Text('Electrician', style: GoogleFonts.lato())
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
                          LineIcons.brain,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Text('Psychologist', style: GoogleFonts.lato())
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              height: SizeConfig.blockSizeVertical * 43,
              child: ListView(
                //padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
                children: <Widget>[
                  SpecialistCard(
                    action: () {
                      Navigator.pushNamed(
                          context, RouteName.SPECIALIST_DETAILS);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  SpecialistCard(
                    action: () {
                      Navigator.pushNamed(
                          context, RouteName.SPECIALIST_DETAILS);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  SpecialistCard(
                    action: () {
                      Navigator.pushNamed(
                          context, RouteName.SPECIALIST_DETAILS);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  SpecialistCard(
                    action: () {
                      Navigator.pushNamed(
                          context, RouteName.SPECIALIST_DETAILS);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
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
