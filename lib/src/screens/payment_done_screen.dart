import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/session.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/utils/event_bus_utils.dart';
import 'package:expat_assistant/src/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PaymentDoneScreen extends StatelessWidget {
  TextUtils _textUtils = TextUtils();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args = ModalRoute.of(context).settings.arguments as PaymentDoneArgs;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 2,
            right: SizeConfig.blockSizeHorizontal * 2),
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            ClipRRect(
              child: Image(
                height: SizeConfig.blockSizeVertical * 25,
                width: SizeConfig.blockSizeHorizontal * 60,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/success_pay.png'),
              ),
            ),
            Text(
              'Register Successful',
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 70,
              child: Text(
                'You have registry an consultant appointment with Dr. ${args.specialistDetails.specialist.fullname} on ${DateFormat.yMMMMd().format(args.sessionDisplay.dateOfSession)}. Here is the details of the appointment.',
                style:
                    GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              alignment: Alignment.center,
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
              child: Column(
                children: <Widget>[
                  Container(
                    height: SizeConfig.blockSizeVertical * 33,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text(
                            'Duration: ',
                            style: GoogleFonts.lato(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                              args.sessionDisplay.startTime +
                                  " - " +
                                  args.sessionDisplay.endTime,
                              style: GoogleFonts.lato()),
                        ),
                        ListTile(
                          leading: Text(
                            'Major: ',
                            style: GoogleFonts.lato(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                              args.specialistDetails.majors.first.name,
                              style: GoogleFonts.lato()),
                        ),
                        ListTile(
                          leading: Text(
                            'Language: ',
                            style: GoogleFonts.lato(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                              _textUtils.getLanguages(
                                  languages: args.specialistDetails.language),
                              style: GoogleFonts.lato()),
                        ),
                        ListTile(
                          leading: Text(
                            'Channel: ',
                            style: GoogleFonts.lato(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          trailing:
                              Text(args.channelName, style: GoogleFonts.lato()),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: Text(
                      'Price: ',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    trailing: Text('${args.sessionDisplay.price} VND',
                        style: GoogleFonts.lato()),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 10,
                    right: SizeConfig.blockSizeHorizontal * 10,
                    top: SizeConfig.blockSizeVertical * 1.75,
                    bottom: SizeConfig.blockSizeVertical * 1.75),
                height: SizeConfig.blockSizeVertical * 10,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.MAIN_COLOR),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            GoogleFonts.lato(fontSize: 17))),
                    child: Text("Done"),
                    onPressed: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName(RouteName.SPECIALISTS));
                      EventBusUtils.getInstance().fire(UpdateAppointment(true));
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentDoneArgs {
  final SessionDisplay sessionDisplay;
  final String channelName;
  final SpecialistDetails specialistDetails;

  PaymentDoneArgs(
      this.sessionDisplay, this.channelName, this.specialistDetails);
}
