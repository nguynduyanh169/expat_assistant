import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/utils/text_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

// ignore: must_be_immutable
class SpecialistCard extends StatelessWidget {
  TextUtils _textUtils = TextUtils();
  Function action;
  SpecialistDetails spec;
  SpecialistCard({@required this.action, @required this.spec});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: action,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26.withOpacity(0.1),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.10)
            ]),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: ExtendedImage.network(
                spec.specialist.avatar,
                fit: BoxFit.cover,
                width: SizeConfig.blockSizeHorizontal * 30,
                height: SizeConfig.blockSizeVertical * 15,
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  spec.specialist.fullname,
                  style: GoogleFonts.lato(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: Text(
                      spec.majors.first.name,
                      style: GoogleFonts.lato(fontSize: 12),
                    )),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 1,
                    ),
                    Container(
                        child: Text(
                      '.',
                      style: GoogleFonts.lato(fontSize: 12),
                    )),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 1,
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          LineIcons.starAlt,
                          color: Color.fromRGBO(252, 191, 7, 30),
                          size: 14,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Container(
                            child: Text(
                          spec.specialist.rating.toStringAsFixed(1),
                          style: GoogleFonts.lato(fontSize: 12),
                        ))
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Language: ',
                      style: GoogleFonts.lato(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      _textUtils.getLanguages(languages: spec.language),
                      style: GoogleFonts.lato(fontSize: 15),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
