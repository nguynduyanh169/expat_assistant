import 'package:expandable_text/expandable_text.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChannelScreen extends StatefulWidget{
  _ChannelState createState() => _ChannelState();
}

class _ChannelState extends State<ChannelScreen>{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 244, 244, 2),
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        backgroundColor: Colors.white,
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Travel News',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        // actions: [
        //   InkWell(
        //     child: Icon(
        //       CupertinoIcons.search,
        //       color: Colors.black,
        //       size: 30,
        //     ),
        //   ),
        //   SizedBox(
        //     width: SizeConfig.blockSizeHorizontal * 5,
        //   ),
        // ],
      ),
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        child: ListView(
          children: <Widget>[
            ClipRRect(
              child: Image(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 25,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/demo_channel.png'),
              ),

            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Container(
              padding:
              EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
              child: Text(
                'Travel News',
                style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding:
              EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: ExpandableText(
                'Breaking Travel News is the leading online resource for travel industry executives from around the world. From market intelligence, trend analysis and breaking news, to exclusive interviews, insightful features and perceptive videos, the site provides all the information insiders need to keep their fingers on the travel pulse.',
                expandText: 'read more',
                collapseText: 'read less',
                linkStyle: GoogleFonts.lato(),
                maxLines: 4,
                linkColor: Colors.blue,
                style: GoogleFonts.lato(fontSize: 15),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding:
              EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
              child: Text(
                'Recent News',
                style: GoogleFonts.lato(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 99, 99, 30)),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1),
              child: ChannelCard(),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1),
              child: ChannelCard(),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1),
              child: ChannelCard(),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1),
              child: ChannelCard(),
            ),
          ],
        ),
      ),
    );
  }

}