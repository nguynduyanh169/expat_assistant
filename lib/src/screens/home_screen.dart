import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

class HomeScreen extends StatefulWidget{
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        //leadingWidth: SizeConfig.blockSizeHorizontal * 10,
        leading: InkWell(
          child: Container(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
            width: SizeConfig.blockSizeHorizontal * 3,
            height: SizeConfig.blockSizeVertical * 2,
            child: Image(
              width: SizeConfig.blockSizeHorizontal * 1,
              height: SizeConfig.blockSizeVertical * 0.5,
              image: AssetImage('assets/images/profile.png'),
            ),
          ),
        ),
        title: OutlineSearchBar(
          hintText: 'Search....',
        ),
        actions: [
          InkWell(
            child: Icon(CupertinoIcons.bell_fill),
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('This is Home'),
        ),
      ),
    );
  }

}