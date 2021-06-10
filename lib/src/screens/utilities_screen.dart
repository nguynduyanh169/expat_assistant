import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UtilitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Utilities',
          style: GoogleFonts.ubuntu(fontSize: 22),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
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
                width: SizeConfig.blockSizeHorizontal * 85,
                height: SizeConfig.blockSizeVertical * 30,
                child: Row(
                  children: <Widget>[
                    Image(
                        width: SizeConfig.blockSizeHorizontal * 30,
                        height: SizeConfig.blockSizeVertical * 20,
                        image: AssetImage('assets/images/expert_logo.png')),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Find your specialist', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Container(
                          width: SizeConfig.blockSizeVertical * 25,
                          child: Text(
                              'Have an appointment with specialists, they will help you to solve your problems.'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/vietnameselearns');
              },
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 85,
                height: SizeConfig.blockSizeVertical * 30,
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
                child: Row(
                  children: <Widget>[
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 4,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Learn Vietnamese', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Container(
                          width: SizeConfig.blockSizeVertical * 22,
                          child: Text(
                              'Learn Vietnamese through vocabulary and sentence'),
                        ),
                      ],
                    ),
                    Image(
                        width: SizeConfig.blockSizeHorizontal * 30,
                        height: SizeConfig.blockSizeVertical * 20,
                        image: AssetImage('assets/images/vietnamese_logo.png')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
