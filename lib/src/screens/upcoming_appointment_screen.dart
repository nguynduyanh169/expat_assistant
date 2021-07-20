import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/appointment_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.MAIN_COLOR,
        automaticallyImplyLeading: true,
        title: Text(
          'Upcoming Appointment',
          style: GoogleFonts.lato(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(RouteName.HOME_PAGE));
            },
            child: Icon(CupertinoIcons.home),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: Text(
                'Upcoming appointment',
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 99, 99, 30)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: AppointmentCard(
                action: () {
                  Navigator.pushNamed(context, RouteName.CALL_ROOM);
                },
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: Text(
                'Future appointments',
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 99, 99, 30)),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2),
                  child: AppointmentCard(
                    action: () {
                      Navigator.pushNamed(context, RouteName.CALL_ROOM);
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2),
                  child: AppointmentCard(
                    action: () {
                      Navigator.pushNamed(context, RouteName.CALL_ROOM);
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2),
                  child: AppointmentCard(
                    action: () {
                      Navigator.pushNamed(context, RouteName.CALL_ROOM);
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2),
                  child: AppointmentCard(
                    action: () {
                      Navigator.pushNamed(context, RouteName.CALL_ROOM);
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2),
                  child: AppointmentCard(
                    action: () {
                      Navigator.pushNamed(context, RouteName.CALL_ROOM);
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
