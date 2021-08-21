import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/majors_filter_cubit.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:expat_assistant/src/utils/events_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

Future<Topic> showConfimationDialogForCategory(
    {@required BuildContext context,
    @required List<Topic> topics}) async {
  Topic selectedTopic;
  SizeConfig().init(context);
  selectedTopic = await showDialog(
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
                  Navigator.pop(context);
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
                                value: topics[index],
                                groupValue: selectedTopic,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTopic = value;
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
  return selectedTopic;
}

Future<Category> showCategory(
    {@required BuildContext context, @required List<Category> list}) async {
  int selected = 0;
  Category category = list.first;
  SizeConfig().init(context);
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select priority',
            style: GoogleFonts.lato(),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CANCEL',
                    style: GoogleFonts.lato(
                        color: AppColors.MAIN_COLOR,
                        fontWeight: FontWeight.w700))),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, category);
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
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                activeColor: AppColors.MAIN_COLOR,
                                title: Text(
                                  list[index].categoryName,
                                  style: GoogleFonts.lato(),
                                ),
                                value: index,
                                groupValue: selected,
                                onChanged: (value) {
                                  setState(() {
                                    selected = index;
                                    category = list[selected];
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

Future<EventStatus> showEventStatus({
  @required BuildContext context,
}) async {
  SizeConfig().init(context);
  List<EventStatus> eventStatus = EventUtils.getAllEventStatus();
  EventStatus result = await showDialog(
      context: context,
      builder: (context) {
        EventStatus selectedStatus;
        return AlertDialog(
            title: Text(
              'Select status',
              style: GoogleFonts.lato(),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL',
                      style: GoogleFonts.lato(
                          color: AppColors.MAIN_COLOR,
                          fontWeight: FontWeight.w700))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, selectedStatus);
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
                            itemCount: eventStatus.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile(
                                  activeColor: AppColors.MAIN_COLOR,
                                  title: Text(
                                    eventStatus[index].content,
                                    style: GoogleFonts.lato(),
                                  ),
                                  value: eventStatus[index],
                                  groupValue: selectedStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedStatus = value;
                                    });
                                  });
                            }),
                      ),
                      Divider(),
                    ],
                  ),
                );
              }),
            ));
      });
  return result;
}

Future<bool> showCameraOptions({@required BuildContext context}) async {
  SizeConfig().init(context);
  bool result = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Ionicons.camera_outline),
              title: Text(
                'Take a food photo to find your restaurants.',
                style: GoogleFonts.lato(),
              ),
              onTap: () {
                Navigator.pop(context, false);
              },
            ),
            ListTile(
              leading: Icon(Ionicons.image_outline),
              title: Text(
                'Choose a food photo to find your restaurants.',
                style: GoogleFonts.lato(),
              ),
              onTap: () {
                Navigator.pop(context, true);
              },
            )
          ],
        );
      });
  return result;
}
