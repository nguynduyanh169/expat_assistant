import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogsScreen extends StatefulWidget {
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
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
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        actions: [
          InkWell(
            child: Icon(
              CupertinoIcons.search,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 5,
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 13,
              color: Colors.white,
              padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 1,
                top: SizeConfig.blockSizeHorizontal * 2,
                right: SizeConfig.blockSizeHorizontal * 1,
                bottom: SizeConfig.blockSizeHorizontal * 2,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 85,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.CHANNEL);
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 22,
                            // padding:
                            // EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(300),
                                  child: Image(
                                    width: SizeConfig.blockSizeHorizontal * 15,
                                    height: SizeConfig.blockSizeVertical * 7,
                                    image: AssetImage(
                                        'assets/images/demo_channel.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Text(
                                    'Travel News',
                                    style: GoogleFonts.lato(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('Category');
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 22,
                            // padding:
                            // EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(300),
                                  child: Image(
                                    width: SizeConfig.blockSizeHorizontal * 15,
                                    height: SizeConfig.blockSizeVertical * 7,
                                    image: AssetImage(
                                        'assets/images/demo_channel.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Text(
                                    'Travel News',
                                    style: GoogleFonts.lato(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('Category');
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 22,
                            // padding:
                            // EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(300),
                                  child: Image(
                                    width: SizeConfig.blockSizeHorizontal * 15,
                                    height: SizeConfig.blockSizeVertical * 7,
                                    image: AssetImage(
                                        'assets/images/demo_channel.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Text(
                                    'Travel News',
                                    style: GoogleFonts.lato(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('Category');
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 22,
                            // padding:
                            // EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(300),
                                  child: Image(
                                    width: SizeConfig.blockSizeHorizontal * 15,
                                    height: SizeConfig.blockSizeVertical * 7,
                                    image: AssetImage(
                                        'assets/images/demo_channel.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Text(
                                    'Travel News',
                                    style: GoogleFonts.lato(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 12,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'ALL',
                          style: GoogleFonts.lato(),
                        )),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  top: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 1),
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
                        borderRadius: BorderRadius.circular(20.0),
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
                          Text(
                            'Category',
                            style: GoogleFonts.lato(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1),
              height: SizeConfig.blockSizeVertical * 64.3,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1,
                        right: SizeConfig.blockSizeHorizontal * 1),
                    child: ChannelCard(),
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
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1,
                        right: SizeConfig.blockSizeHorizontal * 1),
                    child: ChannelCard(),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
