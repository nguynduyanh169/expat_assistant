import 'package:expandable_text/expandable_text.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class EventDetailsScreen extends StatelessWidget {
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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Event Details',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print('tapped');
                Navigator.popUntil(context, ModalRoute.withName(RouteName.HOME_PAGE));
              },
              icon: Icon(
                CupertinoIcons.home,
                color: Colors.black,
              )),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 80,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ClipRRect(
                        child: Image(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: SizeConfig.blockSizeVertical * 25,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/demo_event.png'),
                        ),
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 40,
                      )
                    ],
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 80,
                    padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig.blockSizeHorizontal * 3),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: SizeConfig.blockSizeVertical * 23,),
                        Container(
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
                          padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Learn how to make passive income',
                                style: GoogleFonts.lato(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      child: Text(
                                        'Financial',
                                        style: GoogleFonts.lato(fontSize: 18, color: Colors.black54),
                                      )),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  Container(
                                      child: Text(
                                        '.',
                                        style: GoogleFonts.lato(fontSize: 15),
                                      )),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            LineIcons.userFriends,
                                            color: Colors.green,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: SizeConfig.blockSizeHorizontal * 1,
                                          ),
                                          Container(
                                              child: Text(
                                                '20',
                                                style: GoogleFonts.lato(fontSize: 18, color: Colors.black54),
                                              ))
                                        ],
                                      )),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  Container(
                                      child: Text(
                                        '.',
                                        style: GoogleFonts.lato(fontSize: 15),
                                      )),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  Container(
                                      child: Text(
                                        'Scheduled',
                                        style: GoogleFonts.lato(fontSize: 18, color: Colors.green),
                                      )),
                                ],
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                              Divider(
                                height: 1,
                                color: Colors.black45,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal *0.5),
                                leading: Icon(LineIcons.mapMarked, size: 30, color: Colors.green,),
                                title: Text('District 9, HCM city', style: GoogleFonts.lato(fontSize: 16),),
                                subtitle: Text('0.5 km', style: GoogleFonts.lato(fontSize: 13),),
                                trailing: Icon(CupertinoIcons.forward, size: 30,),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.black45,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal *0.5),
                                leading: Icon(LineIcons.calendar, size: 30, color: Colors.green,),
                                title: Text('September 4, 2021', style: GoogleFonts.lato(fontSize: 16),),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.black45,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal *0.5),
                                leading: Icon(LineIcons.clock, size: 30, color: Colors.green,),
                                title: Text('10:00 - 19:00', style: GoogleFonts.lato(fontSize: 16),),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                        Text(
                          'Description',
                          style: GoogleFonts.lato(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(0, 99, 99, 30)),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                        ExpandableText(
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                          expandText: 'read more',
                          collapseText: 'read less',
                          linkStyle: GoogleFonts.lato(fontSize: 13),
                          maxLines: 4,
                          linkColor: Colors.blue,
                          style: GoogleFonts.lato(wordSpacing: 1.5),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26.withOpacity(0.2),
                          offset: Offset(0.0, 6.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.10)
                    ]),
                height: SizeConfig.blockSizeVertical * 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 80,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(
                                      SizeConfig.blockSizeHorizontal * 4)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.MAIN_COLOR),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                  GoogleFonts.lato(fontSize: 17))),
                          child: Text("Join in"),
                          onPressed: () {}),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
