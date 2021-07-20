import 'package:event_bus/event_bus.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/event_details_cubit.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/repositories/event_repository.dart';
import 'package:expat_assistant/src/repositories/location_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/screens/map_screen.dart';
import 'package:expat_assistant/src/states/event_details_state.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:expat_assistant/src/utils/event_bus_utils.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

// ignore: must_be_immutable
class EventDetailsScreen extends StatelessWidget {
  EventShow event;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args = ModalRoute.of(context).settings.arguments
        as EventDetailsScreenArguments;
    DateTimeUtils _dateUtils = DateTimeUtils();
    return BlocProvider(
      create: (context) => EventDetailsCubit(
          EventRepository(), LocationRepository(), TopicRepository())
        ..getEventContent(eventId: args.eventId),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.popUntil(
                context, ModalRoute.withName(RouteName.HOME_PAGE)),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Colors.black38,
                height: 0.25,
              ),
              preferredSize: Size.fromHeight(0.25)),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColors.MAIN_COLOR,
          //toolbarHeight: SizeConfig.blockSizeVertical * 10,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(
            'Event Details',
            style: GoogleFonts.lato(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(RouteName.HOME_PAGE));
                },
                icon: Icon(
                  CupertinoIcons.home,
                  color: Colors.white,
                )),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
        ),
        body: BlocConsumer<EventDetailsCubit, EventDetailsState>(
            listener: (context, state) {
          if (state.status.isJoiningEvent) {
            CustomLoadingDialog.loadingDialog(
                context: context, message: 'Joining in...');
          }
          if (state.status.isUnjoiningEvent) {
            CustomLoadingDialog.loadingDialog(
                context: context, message: 'Unjoining...');
          } else if (state.status.isJoinEventFailed) {
            Navigator.pop(context);
            print('ok');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
            content: Text(
              'Cannot join this event!',
              style: GoogleFonts.lato(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            duration: const Duration(milliseconds: 1500),
            // width: SizeConfig.blockSizeHorizontal * 60,
            // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.fixed,
          ));
          } else if (state.status.isUnjoinEventFailed) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
            content: Text(
              'Cannot unjoin this event!',
              style: GoogleFonts.lato(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            duration: const Duration(milliseconds: 1500),
            // width: SizeConfig.blockSizeHorizontal * 60,
            // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.fixed,
          ));
          } else if (state.status.isJoinEventSuccess) {
            Navigator.pop(context);
            event.isJoined = true;
            EventBusUtils.getInstance()
                .fire(JoinedInEvent(event.content.eventId, true));
          } else if (state.status.isUnjoinEventSuccess) {
            Navigator.pop(context);
            event.isJoined = false;
            EventBusUtils.getInstance()
                .fire(JoinedInEvent(event.content.eventId, false));
          }
        }, builder: (context, state) {
          if (state.status.isLoadingContent) {
            return LoadingView(message: 'Loading...');
          } else {
            if (state.status.isLoadError) {
              print('error');
            }
            if (state.status.isLoadedContent) {
              event = state.eventContent;
            }
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: SizeConfig.blockSizeVertical * 78.2,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ClipRRect(
                              child: ExtendedImage.network(
                                event.content.eventCoverImage,
                                width: SizeConfig.blockSizeHorizontal * 100,
                                height: SizeConfig.blockSizeVertical * 25,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical * 40,
                            )
                          ],
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 80,
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3),
                          child: ListView(
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 23,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Colors.black26.withOpacity(0.1),
                                          offset: Offset(0.0, 6.0),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.10)
                                    ]),
                                padding: EdgeInsets.all(
                                    SizeConfig.blockSizeHorizontal * 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      event.content.eventTitle.trim(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.lato(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            child: Text(
                                          event.topic.topicDesc,
                                          style: GoogleFonts.lato(
                                              fontSize: 18,
                                              color: Colors.black54),
                                        )),
                                        SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  1,
                                        ),
                                        Container(
                                            child: Text(
                                          '.',
                                          style: GoogleFonts.lato(fontSize: 15),
                                        )),
                                        SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  1,
                                        ),
                                        Container(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              LineIcons.userFriends,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),
                                            Container(
                                                child: Text(
                                              '20',
                                              style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  color: Colors.black54),
                                            ))
                                          ],
                                        )),
                                        SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  1,
                                        ),
                                        Container(
                                            child: Text(
                                          '.',
                                          style: GoogleFonts.lato(fontSize: 15),
                                        )),
                                        SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  1,
                                        ),
                                        Container(
                                            child: Text(
                                          'Scheduled',
                                          style: GoogleFonts.lato(
                                              fontSize: 18,
                                              color: Colors.green),
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 1,
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.black45,
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RouteName.MAP,
                                            arguments: MapScreenArguments(
                                                event.location.locationLatitude,
                                                event.location
                                                    .locationLongitude));
                                      },
                                      contentPadding: EdgeInsets.all(
                                          SizeConfig.blockSizeHorizontal * 0.5),
                                      leading: Icon(
                                        LineIcons.mapMarked,
                                        size: 30,
                                        color: Colors.green,
                                      ),
                                      title: Text(
                                        event.location.locationName,
                                        style: GoogleFonts.lato(fontSize: 16),
                                      ),
                                      subtitle: Text(
                                        event.location.locationAddress,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.lato(fontSize: 13),
                                      ),
                                      trailing: Icon(
                                        CupertinoIcons.forward,
                                        size: 30,
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.black45,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.all(
                                          SizeConfig.blockSizeHorizontal * 0.5),
                                      leading: Icon(
                                        LineIcons.calendar,
                                        size: 30,
                                        color: Colors.green,
                                      ),
                                      title: Text(
                                        _dateUtils.getDateTimeForDetails(
                                            startDateTime:
                                                event.content.eventStartDate),
                                        style: GoogleFonts.lato(fontSize: 16),
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.black45,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.all(
                                          SizeConfig.blockSizeHorizontal * 0.5),
                                      leading: Icon(
                                        LineIcons.clock,
                                        size: 30,
                                        color: Colors.green,
                                      ),
                                      title: Text(
                                        _dateUtils.getStartEndHour(
                                            startDateTime:
                                                event.content.eventStartDate,
                                            endDateTime:
                                                event.content.eventEndDate),
                                        style: GoogleFonts.lato(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 2,
                              ),
                              Text(
                                'Description',
                                style: GoogleFonts.lato(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 99, 99, 30)),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 1,
                              ),
                              ExpandableText(
                                event.content.eventDesc,
                                expandText: 'read more',
                                collapseText: 'read less',
                                linkStyle: GoogleFonts.lato(fontSize: 13),
                                maxLines: 4,
                                linkColor: Colors.blue,
                                style: GoogleFonts.lato(wordSpacing: 1.5),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 1,
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 2,
                              ),
                              Text(
                                'Organizer',
                                style: GoogleFonts.lato(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 99, 99, 30)),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 1,
                              ),
                              ExpandableText(
                                event.content.organizers,
                                expandText: 'read more',
                                collapseText: 'read less',
                                linkStyle: GoogleFonts.lato(fontSize: 13),
                                maxLines: 4,
                                linkColor: Colors.blue,
                                style: GoogleFonts.lato(wordSpacing: 1.5),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                offset: Offset(0.0, 6.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.10)
                          ]),
                      height: SizeConfig.blockSizeVertical * 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 80,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(
                                                SizeConfig.blockSizeHorizontal *
                                                    4)),
                                    backgroundColor: event.isJoined == false
                                        ? MaterialStateProperty.all<Color>(
                                            AppColors.MAIN_COLOR)
                                        : MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(22, 160, 133, 2)),
                                    textStyle:
                                        MaterialStateProperty.all<TextStyle>(
                                            GoogleFonts.lato(fontSize: 17))),
                                child: event.isJoined == false
                                    ? Text("Join")
                                    : Text("Unjoin"),
                                onPressed: () {
                                  if (event.isJoined == false) {
                                    BlocProvider.of<EventDetailsCubit>(context)
                                        .joinEvent(
                                            eventId: event.content.eventId,
                                            expatId: 6);
                                  } else {
                                    BlocProvider.of<EventDetailsCubit>(context)
                                        .unJoinEvent(
                                            eventId: event.content.eventId,
                                            expatId: 6);
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}

class EventDetailsScreenArguments {
  final int eventId;
  const EventDetailsScreenArguments(this.eventId);
}
