import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/events_cubit.dart';
import 'package:expat_assistant/src/cubits/search_event_cubit.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:expat_assistant/src/repositories/event_repository.dart';
import 'package:expat_assistant/src/repositories/location_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/screens/event_details_screen.dart';
import 'package:expat_assistant/src/states/events_state.dart';
import 'package:expat_assistant/src/widgets/event_card.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/search_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsScreen extends StatefulWidget {
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final ScrollController scrollController = ScrollController();
  int currentPage = 0;
  List<Topic> topicList = [];

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<EventsCubit>(context).loadEvents(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 244, 244, 30),
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        backgroundColor: Colors.white,
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Events',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        actions: [
          BlocProvider(
              create: (context) => SearchEventCubit(
                  EventRepository(), LocationRepository(), TopicRepository()),
              child: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      print('ok');
                      showSearch<EventShow>(
                          context: context,
                          delegate: SearchEvents(
                              eventSearchCubit:
                                  BlocProvider.of<SearchEventCubit>(context)));
                    },
                    icon: Icon(
                      CupertinoIcons.search,
                      color: Colors.black,
                    )),
              )),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => EventsCubit(
            EventRepository(), LocationRepository(), TopicRepository())
          ..loadEvents(currentPage),
        child: Container(
          child: Column(
            children: <Widget>[
              BlocBuilder<EventsCubit, EventsState>(
                builder: (context, state) {
                  if (state.status.isLoaded) {
                    if (state.isFirstFetched == true) {
                      topicList = state.topicList;
                    }
                  }
                  return Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 10,
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        right: SizeConfig.blockSizeHorizontal * 2,
                        bottom: SizeConfig.blockSizeHorizontal * 4),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            BlocProvider.of<EventsCubit>(context)
                                .chooseTopic(context, topicList);
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.square_list,
                                  size: 16,
                                  color: AppColors.MAIN_COLOR,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text(
                                  'Category',
                                  style: GoogleFonts.lato(),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.placemark,
                                  size: 16,
                                  color: AppColors.MAIN_COLOR,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('Places', style: GoogleFonts.lato())
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.ticket,
                                  size: 16,
                                  color: AppColors.MAIN_COLOR,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('Joined In', style: GoogleFonts.lato())
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2022),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.calendar,
                                  size: 16,
                                  color: AppColors.MAIN_COLOR,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text(
                                  'Date',
                                  style: GoogleFonts.lato(),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.refresh_bold,
                                  size: 16,
                                  color: AppColors.MAIN_COLOR,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('Refresh', style: GoogleFonts.lato())
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
                setupScrollController(context);
                if (state.isFirstFetched && state.status.isLoading) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 30,
                      ),
                      LoadingView(message: 'Loading')
                    ],
                  );
                }
                List<EventShow> events = [];
                bool isLoading = false;
                if (state.status.isLoading) {
                  events = state.oldEvents;
                  isLoading = true;
                } else if (state.status.isLoaded) {
                  events = state.events;
                  currentPage = state.page;
                }
                return Container(
                  height: SizeConfig.blockSizeVertical * 67.6,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        currentPage = 0;
                        isLoading = false;
                        events.clear();
                      });
                      BlocProvider.of<EventsCubit>(context)
                          .loadEvents(currentPage);
                    },
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2,
                          top: SizeConfig.blockSizeVertical * 2),
                      controller: scrollController,
                      separatorBuilder: (context, index) => SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      itemCount: events.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < events.length) {
                          return EventCard(
                            content: events[index],
                            eventAction: () {
                              Navigator.pushNamed(
                                  context, RouteName.EVENT_DETAILS,
                                  arguments: EventDetailsScreenArguments(
                                      events[index].content.eventId));
                            },
                          );
                        } else {
                          Timer(Duration(milliseconds: 30), () {
                            scrollController.jumpTo(
                                scrollController.position.maxScrollExtent);
                          });
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(child: CupertinoActivityIndicator()),
                          );
                        }
                      },
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
