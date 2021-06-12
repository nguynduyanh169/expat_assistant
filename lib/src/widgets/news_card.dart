import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCard extends StatelessWidget{

  Function newsAction;

  NewsCard({@required this.newsAction});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: newsAction,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Text('Nha Trang Whale Worship Festival, as Portrayed in This Stunning Graduation Project', style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1,),
            Container(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: Row(
                children: <Widget>[
                  Icon(CupertinoIcons.clock, size: 15, color: Color.fromRGBO(30, 193, 194, 30),),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                  Text('Monday, 31 May 2021 at 4:00 PM', style: GoogleFonts.lato(fontSize: 12),),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            ClipRRect(
              child: Image(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 24.5,
                image: AssetImage('assets/images/demo_news.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}