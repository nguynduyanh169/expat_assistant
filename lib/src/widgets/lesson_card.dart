import 'dart:io';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/conversation.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class LessonCard extends StatelessWidget {
  final Function vocabularyAction;
  final Function conversationAction;
  final Function downloadConversation;
  final Function downloadVocabulary;
  final HiveList conversations;
  final HiveList vocabularies;
  final String title;
  final String description;
  final String image;
  const LessonCard(
      {@required this.vocabularyAction,
      @required this.conversationAction,
      @required this.downloadConversation,
      @required this.title,
      @required this.description,
      @required this.image,
      @required this.conversations,
      @required this.downloadVocabulary,
      @required this.vocabularies});

  @override
  Widget build(BuildContext context) {
    HiveUtils _hiveUtils = HiveUtils();
    String filePath = _hiveUtils
                .getFilePath(boxName: HiveBoxName.LESSON_SRC, key: image)
                .srcPath !=
            null
        ? _hiveUtils
            .getFilePath(boxName: HiveBoxName.LESSON_SRC, key: image)
            .srcPath
        : null;
    print(filePath);
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 3,
          bottom: SizeConfig.blockSizeVertical * 2,
          left: SizeConfig.blockSizeHorizontal * 1,
          right: SizeConfig.blockSizeHorizontal * 1),
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
      child: ExpansionTile(
        leading: Image(
          width: SizeConfig.blockSizeHorizontal * 15,
          height: SizeConfig.blockSizeVertical * 6,
          fit: BoxFit.cover,
          image: filePath != null
              ? FileImage(File(filePath))
              : AssetImage('assets/images/demo_lesson.png'),
        ),
        title: Text(
          title,
          style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.lato(),
        ),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                color: Colors.black26,
                width: 0.5,
              ),
              bottom: BorderSide(
                color: Colors.black26,
                width: 0.5,
              ),
            )),
            child: ListTile(
              onTap: vocabularyAction,
              leading: Image(
                width: SizeConfig.blockSizeHorizontal * 10,
                height: SizeConfig.blockSizeVertical * 10,
                image: AssetImage('assets/images/vocabulary_icon.png'),
              ),
              title: Text(
                'Vocabulary',
                style: GoogleFonts.lato(),
              ),
              trailing: (vocabularies == null) || (vocabularies.length == 0)
                  ? IconButton(
                      icon: Icon(CupertinoIcons.square_arrow_down),
                      onPressed: downloadVocabulary,
                    )
                  : Container(
                      width: SizeConfig.blockSizeHorizontal * 10,
                      height: SizeConfig.blockSizeVertical * 10,
                    ),
            ),
          ),
          ListTile(
            onTap: conversationAction,
            leading: Image(
              width: SizeConfig.blockSizeHorizontal * 10,
              height: SizeConfig.blockSizeVertical * 10,
              image: AssetImage('assets/images/conversation_icon.png'),
            ),
            title: Text(
              'Conversation',
              style: GoogleFonts.lato(),
            ),
            trailing: (conversations == null) || (conversations.length == 0)
                ? IconButton(
                    icon: Icon(CupertinoIcons.square_arrow_down),
                    onPressed: downloadConversation,
                  )
                : Container(
                    width: SizeConfig.blockSizeHorizontal * 10,
                    height: SizeConfig.blockSizeVertical * 10,
                  ),
          )
        ],
      ),
    );
  }
}
