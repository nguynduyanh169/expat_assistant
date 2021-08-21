import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              child: ExtendedImage.network(
                blog.channel.image,
                width: SizeConfig.blockSizeHorizontal * 15,
                height: SizeConfig.blockSizeVertical * 20,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              blog.channel.channelName,
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              _dateUtils.caculateDays(date: blog.createDate),
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
            child: ExtendedImage.network(
              blog.coverLink,
              fit: BoxFit.cover,
              width: SizeConfig.blockSizeHorizontal * 101,
              height: SizeConfig.blockSizeVertical * 24.5,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  blog.category.categoryName.toUpperCase(),
                  style: GoogleFonts.lato(fontSize: 15, color: Colors.black54),
                ),
                Text(
                  _dateUtils.getDateTimeForNews(startDateTime: blog.createDate),
                  style: GoogleFonts.lato(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: openNews,
            child: Container(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
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
        ],
      ),
    );
  }
}
