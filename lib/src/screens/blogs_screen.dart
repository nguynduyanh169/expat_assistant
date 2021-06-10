import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogsScreen extends StatefulWidget{
  _BlogsScreenState createState()=> _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen>{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.ubuntu(fontSize: 22),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 3),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      print('Category');
                    },
                    child: Container(
                      padding:
                      EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.square_list,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text('Category')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 3),
              height: SizeConfig.blockSizeVertical * 80,
              child: ListView(
                children: <Widget>[
                  NewsCard(
                    newsAction: (){
                      Navigator.pushNamed(context, '/blogdetails');
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                  NewsCard(
                    newsAction: (){
                      Navigator.pushNamed(context, '/blogdetails');
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                  NewsCard(
                    newsAction: (){
                      Navigator.pushNamed(context, '/blogdetails');
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                  NewsCard(
                    newsAction: (){
                      Navigator.pushNamed(context, '/blogdetails');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}