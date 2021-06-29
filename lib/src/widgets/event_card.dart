import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  Function eventAction;
  EventShow content;

  EventCard({@required this.eventAction, @required this.content});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: eventAction,
      child: Container(
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
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 25,
                image: NetworkImage(content.content.eventCoverImage),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              alignment: Alignment.bottomLeft,
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.black87.withOpacity(0.3),
                        Colors.black,
                      ],
                      stops: [
                        0.0,
                        2.0
                      ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 4,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 70,
                    child: Text(
                      content.content.eventTitle,
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    content.topic.topicDesc,
                    style: GoogleFonts.lato(fontSize: 15, color: Colors.white),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.clock_fill,
                        size: 15,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1,
                      ),
                      Text(
                        '10:00 - 13:00',
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.placemark_fill,
                        size: 15,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1,
                      ),
                      Text(
                        content.location.locationName,
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                ],
              ),
            ),
            Positioned(
              left: SizeConfig.blockSizeHorizontal * 75,
              top: SizeConfig.blockSizeVertical * 2,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 18,
                height: SizeConfig.blockSizeVertical * 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '04',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(30, 193, 194, 30)),
                    ),
                    Text(
                      'SEP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(30, 193, 194, 30)),
                    )
                  ],
                ),
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
              ),
            ),
            Positioned(
              left: SizeConfig.blockSizeHorizontal * 75,
              top: SizeConfig.blockSizeVertical * 20,
              child: Container(
                alignment: Alignment.center,
                width: SizeConfig.blockSizeHorizontal * 18,
                height: SizeConfig.blockSizeVertical * 3,
                child: Text('Scheduled',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26.withOpacity(0.1),
                          offset: Offset(0.0, 6.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.10)
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
