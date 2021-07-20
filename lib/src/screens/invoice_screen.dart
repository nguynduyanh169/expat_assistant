import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/session.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/utils/session_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

// ignore: must_be_immutable
class InvoiceScreen extends StatelessWidget {
  List<SessionDisplay> sessions = [];
  SpecialistDetails specialistDetails;
  SessionUtils _sessionUtils = SessionUtils();
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as InvoiceScreenArguments;
    sessions.addAll(args.selectedSessions);
    specialistDetails = args.specialistDetails;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        backgroundColor: AppColors.MAIN_COLOR,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'My Invoice',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: ExtendedImage.network(
                      specialistDetails.specialist.avatar,
                      fit: BoxFit.cover,
                      width: SizeConfig.blockSizeHorizontal * 26,
                      height: SizeConfig.blockSizeVertical * 14,
                      
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Text(
                    specialistDetails.specialist.fullname,
                    style: GoogleFonts.lato(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${sessions.length} sessions',
                    style: GoogleFonts.lato(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 25,
                    child: ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                              leading: Icon(
                                LineIcons.businessTime,
                                color: AppColors.MAIN_COLOR,
                              ),
                              title: Text(
                                sessions[index].startTime +
                                    "-" +
                                    sessions[index].endTime,
                                style: GoogleFonts.lato(),
                              ),
                              subtitle: Text(DateFormat('dd/MM/yyyy').format(sessions[index].dateOfSession), style: GoogleFonts.lato(fontSize: 11)),
                              trailing: Text(
                                  sessions[index].price.toString() + "VND",
                                  style: GoogleFonts.lato()),
                            ),
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: sessions.length),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: Text(
                      'Subtotal',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    trailing: Text(
                        '${_sessionUtils.caculateTotalPrice(sessionLists: sessions)}VND',
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
                    child: Text("Pay Now"),
                    onPressed: () {},
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

class InvoiceScreenArguments {
  final List<SessionDisplay> selectedSessions;
  final SpecialistDetails specialistDetails;
  const InvoiceScreenArguments(this.selectedSessions, this.specialistDetails);
}
