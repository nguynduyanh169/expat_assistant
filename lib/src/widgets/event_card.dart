import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:extended_image/extended_image.dart';
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
    DateTimeUtils _dateUtils = DateTimeUtils();
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
              child: ExtendedImage.network(
                content.content.eventCoverImage,
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 25,
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
                      content.content.eventTitle.trim(),
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
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
                        _dateUtils.getStartEndHour(
                            startDateTime: content.content.eventStartDate,
                            endDateTime: content.content.eventEndDate),
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
                      _dateUtils
                          .getStartDay(
                              startDateTime: content.content.eventStartDate)
                          .toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.MAIN_COLOR),
                    ),
                    Text(
                      _dateUtils
                          .getStartMonthText(
                              startDateTime: content.content.eventStartDate)
                          .toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.MAIN_COLOR),
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
            ),
            Positioned(
              left: SizeConfig.blockSizeHorizontal * 2,
              top: SizeConfig.blockSizeVertical * 2,
              child: content.isJoined == true
                  ? Icon(
                      CupertinoIcons.ticket_fill,
                      color: Colors.green,
                    )
                  : Icon(
                      CupertinoIcons.ticket_fill,
                      color: Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
