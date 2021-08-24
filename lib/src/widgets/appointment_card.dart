import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AppointmentCard extends StatelessWidget {
  Function action;
  ExpatAppointment appointment;
  DateTimeUtils _dateTimeUtils = DateTimeUtils();

  AppointmentCard({this.action, this.appointment});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: action,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
        decoration: BoxDecoration(
            color: AppColors.MAIN_COLOR,
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
                    child: ExtendedImage.network(
                      appointment.session.specialist.avatar == null
                          ? 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/expat%2Fuser.png?alt=media&token=b8ddb06c-347e-419b-95e7-d28a30d93c1a'
                          : appointment.session.specialist.avatar,
                      fit: BoxFit.cover,
                      width: SizeConfig.blockSizeHorizontal * 18,
                      height: SizeConfig.blockSizeVertical * 9,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        appointment.session.specialist.fullname,
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      Text(
                        appointment.major == null
                            ? "Not available"
                            : appointment.major.name,
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
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
                    _dateTimeUtils.getDateTimeAppointment(
                        appointment.session.startTime,
                        appointment.session.endTime),
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
