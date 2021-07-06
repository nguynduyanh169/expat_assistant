import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

class BlogDetailsScreen extends StatelessWidget {
  String test = "<div ><h2>TITLE HEADING</h2><h5>Title description, Sep 2, 2017</h5><img src='https://cdn.tuoitre.vn/thumb_w/586/2021/7/5/logo-hk-1625514745021872118477.jpg' alt='Flowers in Chania' width='560' height='345'><p>Some text..</p><p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p></div>";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dom.Document document = htmlparser.parse(test);
    return Scaffold(
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
            "Nha Trang's Whale Worship Festival, as Portrayed in This Stunning Graduation Project",
            style: GoogleFonts.lato(fontSize: 20, color: Colors.black),
          ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(RouteName.HOME_PAGE));
              },
              icon: Icon(CupertinoIcons.home)),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ClipRRect(
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/demo_news.png'),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: Row(
                children: <Widget>[
                  Text(
                    'TRAVEL',
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                  ),
                  Text(' | '),
                  Text(
                    '7:50 PM, 31/05/2021',
                    style: GoogleFonts.lato(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: Text(
                "Nha Trang's Whale Worship Festival, as Portrayed in This Stunning Graduation Project",
                style: GoogleFonts.lato(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: Html(
                data: test,
                // document: document,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
