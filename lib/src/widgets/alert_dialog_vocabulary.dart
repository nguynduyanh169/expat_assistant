import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<Topic> showConfimationDialogForCategory(
    {@required BuildContext context,
    @required Function action,
    @required List<Topic> topics}) async {
  int selected = 0;
  Topic selectedTopic;
  SizeConfig().init(context);
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select type of Event',
            style: GoogleFonts.lato(),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context, selectedTopic);
                },
                child: Text('CANCEL',
                    style: GoogleFonts.lato(
                        color: AppColors.MAIN_COLOR,
                        fontWeight: FontWeight.w700))),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, selectedTopic);
                },
                child: Text('CONFIRM',
                    style: GoogleFonts.lato(
                        color: AppColors.MAIN_COLOR,
                        fontWeight: FontWeight.w700)))
          ],
          content: SingleChildScrollView(
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Divider(),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: SizeConfig.blockSizeVertical * 40,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: topics.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                activeColor: AppColors.MAIN_COLOR,
                                title: Text(
                                  topics[index].topicDesc,
                                  style: GoogleFonts.lato(),
                                ),
                                value: index,
                                groupValue: selected,
                                onChanged: (value) {
                                  setState(() {
                                    selected = index;
                                    selectedTopic = topics[index];
                                  });
                                });
                          }),
                    ),
                    Divider(),
                  ],
                ),
              );
            }),
          ),
        );
      });
}
