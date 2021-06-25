import 'dart:io';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class VocabularyCard extends StatelessWidget{
  final String vietnamese, english, imageLink;
  final Function playAudio;

  VocabularyCard({@required this.vietnamese, @required this.english, this.imageLink, this.playAudio});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    HiveUtils _hiveUtils = HiveUtils();
    String filePath;
    if(imageLink != null) {
      filePath = _hiveUtils
          .getFilePath(boxName: HiveBoxName.LESSON_SRC, key: imageLink)
          .srcPath;
    }
    return Container(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 3,
          bottom: SizeConfig.blockSizeVertical * 2,
          left: SizeConfig.blockSizeHorizontal * 2,
          right: SizeConfig.blockSizeHorizontal * 3),
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
      child: ListTile(
        leading: Image(
          width: SizeConfig.blockSizeHorizontal * 15,
          height: SizeConfig.blockSizeVertical * 15,
          fit: BoxFit.cover,
          image: imageLink == null ? AssetImage('assets/images/demo_vocabulary.png') : FileImage(File(filePath)),
        ),
        title: Text(vietnamese, style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w600),),
        subtitle: Text(english, style: GoogleFonts.lato(fontSize: 15)),
        trailing: GFIconButton(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
          onPressed: playAudio,
          color: AppColors.MAIN_COLOR,
          icon: Icon(Ionicons.volume_medium_outline),
          shape: GFIconButtonShape.circle,
        ),
      ),
    );
  }

}