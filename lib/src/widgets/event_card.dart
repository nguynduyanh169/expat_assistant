import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EventCard extends StatelessWidget{
  Function eventAction;

  EventCard({@required this.eventAction});
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
            Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: Image(
                    // width: SizeConfig.blockSizeHorizontal * 90,
                    // height: SizeConfig.blockSizeVertical * 20,
                    image: AssetImage('assets/images/demo_event.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                  alignment: Alignment.bottomLeft,
                  height: SizeConfig.blockSizeVertical * 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: SizeConfig.blockSizeVertical * 4,),
                      Text('Business', style: GoogleFonts.lato(fontSize: 15, color: Colors.black54),),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 70,
                        child: Text('Learn how to make passive income', style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                      Row(
                        children: <Widget>[
                          Icon(CupertinoIcons.clock, size: 15, color: Color.fromRGBO(30, 193, 194, 30),),
                          Text('10:00 - 13:00', style: GoogleFonts.lato(fontSize: 12),),
                        ],
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                      Row(
                        children: <Widget>[
                          Icon(CupertinoIcons.placemark, size: 15, color: Color.fromRGBO(30, 193, 194, 30),),
                          Text('District 9,HCMC', style: GoogleFonts.lato(fontSize: 12),)
                        ],
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              left: SizeConfig.blockSizeHorizontal * 3,
              top: SizeConfig.blockSizeVertical * 15,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 18,
                height: SizeConfig.blockSizeVertical * 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('04', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(30, 193, 194, 30)),),
                    Text('SEP', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(30, 193, 194, 30)),)
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
            )
          ],
        ),
      ),
    );
  }

}