import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Home', style: GoogleFonts.ubuntu(fontSize: 22),),
        actions: [
          InkWell(
            child: Icon(CupertinoIcons.bell_fill, size: 30,),
          ),
          SizedBox(width: SizeConfig.blockSizeHorizontal * 5,),
          InkWell(
            child: Container(
              child: Image(
                width: SizeConfig.blockSizeHorizontal * 11,
                height: SizeConfig.blockSizeVertical * 11,
                image: AssetImage('assets/images/profile.png'),
              ),
            ),
          ),
          SizedBox(width: SizeConfig.blockSizeHorizontal * 3,)
        ],
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig.blockSizeHorizontal *3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              child: Text('Welcome Bao,', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1,),
            Container(
              child: Text('Good evening!', style: TextStyle(fontSize: 25),),
            ),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 2,),
            Container(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5, right: SizeConfig.blockSizeHorizontal * 5),
              width: SizeConfig.blockSizeHorizontal * 95,
              height: SizeConfig.blockSizeVertical * 23,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromRGBO(30, 193, 194, 100),
                      const Color.fromRGBO(30, 193, 194, 30),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.1),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 15,
                    height: SizeConfig.blockSizeVertical * 10,
                    child: Image.asset("assets/images/app_logo.png"),
                  ),
                  Container(
                    child: Text('3.362.000 VND', style: TextStyle(fontSize: 25, color: Colors.white),),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
                  Container(
                    child: Text('Balance', style: TextStyle(fontSize: 20, color: Colors.white),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}