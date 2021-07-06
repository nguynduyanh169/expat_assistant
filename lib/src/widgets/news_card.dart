import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

// ignore: must_be_immutable
class NewsCard extends StatelessWidget {
  Function newsAction;

  NewsCard({@required this.newsAction});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    DateTimeUtils _dateUtils = DateTimeUtils();
    return InkWell(
      onTap: newsAction,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26.withOpacity(0.05),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.10)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Text(
                'Nha Trang Whale Worship Festival, as Portrayed in This Stunning Graduation Project',
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: Text(
                'Travel',
                style: GoogleFonts.lato(fontSize: 15, color: Colors.black54),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: Row(
                children: <Widget>[
                  Icon(
                    CupertinoIcons.clock,
                    size: 15,
                    color: Color.fromRGBO(30, 193, 194, 30),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Text(
                    'Monday, 31 May 2021 at 4:00 PM',
                    style: GoogleFonts.lato(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
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

// ignore: must_be_immutable
class ChannelCard extends StatelessWidget {
  ListBlog blog;
  Function openChannel;
  Function openNews;
  ChannelCard({@required this.blog, this.openChannel, this.openNews});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    DateTimeUtils _dateUtils = DateTimeUtils();
    return Container(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 1,
          bottom: SizeConfig.blockSizeVertical * 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black26.withOpacity(0.05),
                offset: Offset(0.0, 6.0),
                blurRadius: 10.0,
                spreadRadius: 0.10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: openChannel,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                width: SizeConfig.blockSizeHorizontal * 15,
                height: SizeConfig.blockSizeVertical * 20,
                image: NetworkImage(blog.channel.image),
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              blog.channel.channelName,
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              _dateUtils.caculateDays(date: blog.createDate).toString() +
                  " days ago",
              style: GoogleFonts.lato(),
            ),
          ),
          Divider(
            color: Colors.black45,
            height: 2,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          ClipRRect(
            child: Image(
              fit: BoxFit.cover,
              width: SizeConfig.blockSizeHorizontal * 101,
              height: SizeConfig.blockSizeVertical * 24.5,
              image: NetworkImage(blog.coverLink),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
            child: Text(
              blog.category.categoryName,
              style: GoogleFonts.lato(fontSize: 15, color: Colors.black54),
            ),
          ),
          InkWell(
            onTap: openNews,
            child: Container(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Text(
                blog.blogTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
            child: Row(
              children: <Widget>[
                Icon(
                  Ionicons.time_outline,
                  size: 15,
                  color: AppColors.MAIN_COLOR,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Text(
                  _dateUtils.getDateTimeForNews(startDateTime: blog.createDate),
                  style: GoogleFonts.lato(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
