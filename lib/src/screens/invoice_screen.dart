import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class InvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          style: GoogleFonts.lato(fontSize: 22, color: Colors.white),
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
                    child: Image(
                      fit: BoxFit.cover,
                      width: SizeConfig.blockSizeHorizontal * 26,
                      height: SizeConfig.blockSizeVertical * 14,
                      image: AssetImage('assets/images/demo_expert.jpg'),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Text(
                    'Dr. Ho Xuan Cuong',
                    style: GoogleFonts.lato(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'September 21, 11:00',
                    style: GoogleFonts.lato(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: Icon(LineIcons.businessTime),
                    title: Text(
                      '11:00 - 11:30',
                      style: GoogleFonts.lato(),
                    ),
                    trailing: Text('30.000 VND', style: GoogleFonts.lato()),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: Icon(LineIcons.businessTime),
                    title: Text(
                      '11:00 - 11:30',
                      style: GoogleFonts.lato(),
                    ),
                    trailing: Text('30.000 VND', style: GoogleFonts.lato()),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: Icon(LineIcons.businessTime),
                    title: Text(
                      '11:00 - 11:30',
                      style: GoogleFonts.lato(),
                    ),
                    trailing: Text('30.000 VND', style: GoogleFonts.lato()),
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
                    trailing: Text('90.000 VND', style: GoogleFonts.lato()),
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
                              EdgeInsets.all(
                                  SizeConfig.blockSizeHorizontal * 2)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.MAIN_COLOR),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              GoogleFonts.lato(fontSize: 17))),
                      child: Text("Pay Now"),
                      onPressed: () {
                        
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
