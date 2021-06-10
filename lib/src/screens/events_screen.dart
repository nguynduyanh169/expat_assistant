import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/event_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsScreen extends StatefulWidget {
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
          'Events',
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
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 3),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      print('Category');
                    },
                    child: Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.square_list,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text('Category')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.placemark,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text('Places')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.bookmark,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text('Is Going')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 3),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      print('tapped');
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2022));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.calendar,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text('From Date')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 66,
              child: ListView(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 5,
                    right: SizeConfig.blockSizeHorizontal * 5,
                    top: SizeConfig.blockSizeVertical * 2),
                children: <Widget>[
                  EventCard(
                    eventAction: () {
                      Navigator.pushNamed(context, '/eventdetail');
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  EventCard(
                    eventAction: () {
                      Navigator.pushNamed(context, '/eventdetail');
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  EventCard(
                    eventAction: () {
                      Navigator.pushNamed(context, '/eventdetail');
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
