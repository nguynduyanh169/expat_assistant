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
        //leadingWidth: SizeConfig.blockSizeHorizontal * 10,
        automaticallyImplyLeading: false,
        title: Text('Home', style: GoogleFonts.ubuntu(fontSize: 22),),
        actions: [
          InkWell(child: Icon(CupertinoIcons.news_solid, size: 30,),),
          SizedBox(width: SizeConfig.blockSizeHorizontal * 5,),
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
        child: Center(
          child: Text('This is Home'),
        ),
      ),
    );
  }

}