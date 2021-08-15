import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

// ignore: must_be_immutable
class MessageForCall extends StatelessWidget {
  String title;
  String message;
  Function back;
  String image;

  MessageForCall({this.image, this.message, this.back, this.title});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
              width: SizeConfig.blockSizeHorizontal * 70,
              height: SizeConfig.blockSizeVertical * 30,
              fit: BoxFit.cover,
              image: AssetImage(image)),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            height: SizeConfig.blockSizeVertical * 15,
            child: Text(
              title,
              style:
                  GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            height: SizeConfig.blockSizeVertical * 15,
            child: Text(
              message,
              style:
                  GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 85,
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueAccent),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.lato(fontSize: 17))),
                child: Text("Retry"),
                onPressed: back),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CompletedInformationOfCall extends StatelessWidget {
  ExpatAppointment appointment;

  CompletedInformationOfCall({this.appointment});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
              width: SizeConfig.blockSizeHorizontal * 70,
              height: SizeConfig.blockSizeVertical * 15,
              fit: BoxFit.scaleDown,
              image: AssetImage('assets/images/schedule_done.png')),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            child: Text(
              'Appointment Completed!',
              style:
                  GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
            child: Text(
              'Appointment Information',
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(0, 99, 99, 30)),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    LineIcons.userCircleAlt,
                    color: AppColors.MAIN_COLOR,
                    size: 30,
                  ),
                  title: Text("Le Quang Bao",
                      style: GoogleFonts.lato(fontSize: 18)),
                ),
                ListTile(
                  leading: Icon(
                    LineIcons.businessTime,
                    color: AppColors.MAIN_COLOR,
                    size: 30,
                  ),
                  title: Text("2020/12/02 08:00 - 09:00",
                      style: GoogleFonts.lato(fontSize: 18)),
                ),
                ListTile(
                  leading: Icon(
                    LineIcons.star,
                    color: AppColors.MAIN_COLOR,
                    size: 30,
                  ),
                  title: Text("4.5", style: GoogleFonts.lato(fontSize: 18)),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
                  child: Text(
                    'Comment',
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 99, 99, 30)),
                  ),
                ),
                Container(
                    height: SizeConfig.blockSizeVertical * 20,
                    width: SizeConfig.blockSizeHorizontal * 90,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      child: Text(
                        'The specialist joined on time and answer ok',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
