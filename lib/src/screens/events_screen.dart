import 'dart:async';

import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/events_cubit.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/repositories/event_repository.dart';
import 'package:expat_assistant/src/repositories/location_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/states/events_state.dart';
import 'package:expat_assistant/src/widgets/event_card.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
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
    return BlocProvider(
      create: (context) => EventsCubit(
          EventRepository(), LocationRepository(), TopicRepository())
        ..loadEvents(currentPage),
      child: Scaffold(
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
            IconButton(
                onPressed: () {
                  print('tapped');
                },
                icon: Icon(
                  CupertinoIcons.search,
                  color: Colors.black,
                )),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 2,
                    top: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 2),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print('Category');
                      },
                      child: Container(
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.square_list,
                              color: Color.fromRGBO(30, 193, 194, 30),
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
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.placemark,
                              color: Color.fromRGBO(30, 193, 194, 30),
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
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.bookmark,
                              color: Color.fromRGBO(30, 193, 194, 30),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text('Is Going', style: GoogleFonts.lato())
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 2,
                    top: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 2),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2022));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.calendar,
                              color: Color.fromRGBO(30, 193, 194, 30),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text(
                              'From Date',
                              style: GoogleFonts.lato(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                  height: SizeConfig.blockSizeVertical * 66,
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
                              Navigator.pushNamed(context, '/eventDetail');
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
