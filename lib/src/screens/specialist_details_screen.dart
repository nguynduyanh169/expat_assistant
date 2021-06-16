import 'package:expandable_text/expandable_text.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class SpecialistDetailsScreen extends StatefulWidget {
  _SpecialistDetailsState createState() => _SpecialistDetailsState();
}

class _SpecialistDetailsState extends State<SpecialistDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 244, 244, 2),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Dr. Ho Xuan Cuong',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              height: SizeConfig.blockSizeVertical * 80,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: SizeConfig.blockSizeVertical * 14,
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            fit: BoxFit.cover,
                            width: SizeConfig.blockSizeHorizontal * 26,
                            height: SizeConfig.blockSizeVertical * 14,
                            image: AssetImage('assets/images/demo_expert.jpg'),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Dr. Xuan Cuong Ho',
                              style: GoogleFonts.lato(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Lawyer',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 0.7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Text(
                                  '5.0',
                                  style:
                                      GoogleFonts.lato(color: Colors.black54),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Language: ',
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'English, Japanese',
                                  style: GoogleFonts.lato(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Certificate: ',
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Bachelor Degree of Lawyer',
                                  style: GoogleFonts.lato(),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    "Profile",
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 99, 99, 30)),
                  ),
                  ExpandableText(
                    "Dr. Halley Lawrence is also a United States senator from Kentucky. She graduated from the University of Kentucky School of Law and holds the position of President of the State Bar Association's Law Students Association.",
                    expandText: 'read more',
                    collapseText: 'read less',
                    linkStyle: GoogleFonts.lato(),
                    maxLines: 6,
                    linkColor: Colors.blue,
                    style: GoogleFonts.lato(),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Text(
                    "Schedule",
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 99, 99, 30)),
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 60,
                    child: TableCalendar(
                      calendarStyle: CalendarStyle(
                        outsideTextStyle: GoogleFonts.lato(),
                        todayTextStyle: GoogleFonts.lato(),
                        defaultTextStyle: GoogleFonts.lato(),
                        disabledTextStyle: GoogleFonts.lato(color: Colors.grey),
                        selectedTextStyle: GoogleFonts.lato(color: Colors.white)
                      ),
                      calendarFormat: CalendarFormat.week,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 10, right: SizeConfig.blockSizeHorizontal * 10, top: SizeConfig.blockSizeVertical * 1.75, bottom: SizeConfig.blockSizeVertical * 1.75),
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
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4)),
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(30, 193, 194, 30)),
                          textStyle: MaterialStateProperty.all<TextStyle>(GoogleFonts.lato(fontSize: 17))
                      ),
                      child: Text("Make an Appointment"),
                      onPressed: () {

                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
