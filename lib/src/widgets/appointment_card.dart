import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentCard extends StatelessWidget {
  Function action;

  AppointmentCard({this.action});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: action,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
        decoration: BoxDecoration(
            color: Color.fromRGBO(30, 193, 194, 30),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26.withOpacity(0.1),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.10)
            ]),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      fit: BoxFit.cover,
                      width: SizeConfig.blockSizeHorizontal * 18,
                      height: SizeConfig.blockSizeVertical * 8,
                      image: AssetImage('assets/images/demo_expert.jpg'),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Dr. Xuan Cuong Ho',
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      Text(
                        'Lawyer',
                        style: GoogleFonts.lato(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 163, 161, 30),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.1),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: Row(
                children: <Widget>[
                  Icon(
                    CupertinoIcons.calendar_today,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Text(
                    'Sat, Aug 16, 9:00AM - 10:00 AM',
                    style: GoogleFonts.lato(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
          ],
        ),
      ),
    );
  }
}
