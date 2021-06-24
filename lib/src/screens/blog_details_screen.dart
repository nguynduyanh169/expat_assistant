import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: true,
        // centerTitle: true,
        // title: Text(
        //   'Event Details',
        //   style: GoogleFonts.ubuntu(fontSize: 22),
        // ),
        actions: [
          IconButton(
              onPressed: () {
                print('tapped');
                Navigator.popUntil(context, ModalRoute.withName(RouteName.HOME_PAGE));
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
                  Text('7:50 PM, 31/05/2021', style: GoogleFonts.lato(),)
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
              child: Text(
                  'Every February on the lunar calendar, generations of villagers from Nha Trang in Khanh Hoa gather at the coastal ward of Vinh Truong to observe a special ceremony called lễ tế đức Ông as part of their New Year celebration. The ceremony is meant to be an occasion for locals to show their gratitude to the sea, and offer their prayers for a season of “calm water and bountiful harvest.” As an homage to her upbringing, graphic designer Tường Vân created a series of illustrations exploring the folktales behind these traditions to bring them to the mainstream.Vân is an alumni of Van Lang University. In 2018, she graduated at the top of her class in Graphic Design with her Lễ Cầu Ngư illustrations, which received considerable praise from faculty members. The project took inspiration from her affection for her hometown. “I grew up in Nha Trang, and I just thought that maybe I should use my artworks to represent my roots,” she acknowledged. The product of a three-month creative process, the project recapitulates the lively scenes of ',
              style: GoogleFonts.lato(fontSize: 13),),
            ),
          ],
        ),
      ),
    );
  }
}
