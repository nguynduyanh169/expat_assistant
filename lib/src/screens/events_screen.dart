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
import 'package:expat_assistant/src/utils/event_bus_utils.dart';
import 'package:expat_assistant/src/widgets/alert_dialog_vocabulary.dart';
import 'package:expat_assistant/src/widgets/error.dart';
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

class _EventsScreenState extends State<EventsScreen>
    with AutomaticKeepAliveClientMixin<EventsScreen> {
  final ScrollController scrollController = ScrollController();
  int currentPage = 0;
  List<Topic> topicList = [];
  List<EventShow> events = [];
  bool checkFilterJoined = false;
  bool canPressFilter = false;
  bool checkFilterStatus = false;
  bool checkFilterTopic = false;
  String statusLable = "Status";
  String topicLable = "Category";

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<EventsCubit>(context).loadEvents(currentPage);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        backgroundColor: AppColors.MAIN_COLOR,
        //toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Events',
          style: GoogleFonts.lato(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          BlocProvider(
              create: (context) => SearchEventCubit(
                  EventRepository(), LocationRepository(), TopicRepository()),
              child: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      showSearch<EventShow>(
                          context: context,
                          delegate: SearchEvents(
                              eventSearchCubit:
                                  BlocProvider.of<SearchEventCubit>(context)));
                      EventBusUtils.getInstance()
                          .on<JoinedInEvent>()
                          .listen((result) {
                        final event = events.firstWhere(
                            (item) => item.content.eventId == result.eventId,
                            orElse: () => null);
                        setState(() => event.isJoined = result.joinedIn);
                      });
                    },
                    icon: Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
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
                  if (state.status.isLoadingJoinedInEvent) {
                    currentPage = 0;
                    checkFilterJoined = true;
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
                          onTap: () async {
                            if (canPressFilter == true) {
                              Topic topic =
                                  await showConfimationDialogForCategory(
                                      context: context, topics: topicList);
                              if (topic != null) {
                                setState(() {
                                  checkFilterTopic = true;
                                  checkFilterJoined = false;
                                  checkFilterStatus = false;
                                  statusLable = "Status";
                                  topicLable = topic.topicDesc;
                                });
                                BlocProvider.of<EventsCubit>(context)
                                    .pressCategory(topic.topicId);
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: checkFilterTopic == true
                                  ? AppColors.MAIN_COLOR
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.square_list,
                                  size: 16,
                                  color: checkFilterTopic == true
                                      ? Colors.white
                                      : AppColors.MAIN_COLOR,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text(
                                  topicLable,
                                  style: GoogleFonts.lato(
                                      color: checkFilterTopic == true
                                          ? Colors.white
                                          : Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        InkWell(
                          onTap: () async {
                            if (canPressFilter == true) {
                              EventStatus status =
                                  await showEventStatus(context: context);
                              if (status != null) {
                                setState(() {
                                  checkFilterJoined = false;
                                  checkFilterStatus = true;
                                  checkFilterTopic = false;
                                  topicLable = "Category";
                                  statusLable = status.content;
                                });
                                BlocProvider.of<EventsCubit>(context)
                                    .pressStatus(status.status.toString());
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: checkFilterStatus == true
                                  ? AppColors.MAIN_COLOR
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.app_badge,
                                  size: 16,
                                  color: checkFilterStatus == true
                                      ? Colors.white
                                      : AppColors.MAIN_COLOR,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text(statusLable,
                                    style: GoogleFonts.lato(
                                        color: checkFilterStatus == true
                                            ? Colors.white
                                            : Colors.black))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        InkWell(
                          onTap: () {
                            if (canPressFilter == true) {
                              setState(() {
                                checkFilterStatus = false;
                                statusLable = 'Status';
                                checkFilterTopic = false;
                                topicLable = "Category";
                              });
                              BlocProvider.of<EventsCubit>(context)
                                  .pressJoinedIn();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: checkFilterJoined == true
                                  ? AppColors.MAIN_COLOR
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.ticket,
                                  size: 16,
                                  color: checkFilterJoined == true
                                      ? Colors.white
                                      : AppColors.MAIN_COLOR,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('Joined In',
                                    style: GoogleFonts.lato(
                                        color: checkFilterJoined == true
                                            ? Colors.white
                                            : Colors.black))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentPage = 0;
                              events.clear();
                              checkFilterJoined = false;
                              checkFilterStatus = false;
                              statusLable = "Status";
                              canPressFilter = false;
                              topicLable = "Category";
                              checkFilterTopic = false;
                            });
                            BlocProvider.of<EventsCubit>(context)
                                .loadEvents(currentPage);
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
                if ((state.isFirstFetched && state.status.isLoading) ||
                    state.status.isLoadingJoinedInEvent ||
                    state.status.isLoadingEventByStatus ||
                    state.status.isLoadingEventTopic) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 30,
                      ),
                      LoadingView(message: 'Loading...')
                    ],
                  );
                } else if (state.status.isLoadJoinedInEventFailed ||
                    state.status.isLoadEventByStatusFailed ||
                    state.status.isLoadError) {
                  return DisplayError(
                      message: 'A problem occurs while loading events',
                      reload: () {
                        currentPage = 0;
                        events.clear();
                        checkFilterJoined = false;
                        checkFilterStatus = false;
                        statusLable = "Status";
                        canPressFilter = false;
                        topicLable = "Category";
                        checkFilterTopic = false;
                        BlocProvider.of<EventsCubit>(context)
                            .loadEvents(currentPage);
                      });
                      
                } else {
                  bool isLoading = false;
                  if (state.status.isLoading) {
                    events = state.oldEvents;
                    isLoading = true;
                  } else if (state.status.isLoaded) {
                    events = state.events;
                    currentPage = state.page;
                    canPressFilter = true;
                  } else if (state.status.isLoadJoinedInEventSuccess) {
                    events = state.joinedEvents;
                  } else if (state.status.isLoadEventByStatusSuccess) {
                    events = state.eventsByStatus;
                  } else if (state.status.isLoadedEventTopic) {
                    events = state.eventsByTopic;
                  }
                  return Container(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          currentPage = 0;
                          isLoading = false;
                          events.clear();
                          checkFilterJoined = false;
                          checkFilterStatus = false;
                          statusLable = "Status";
                          canPressFilter = false;
                          topicLable = "Category";
                          checkFilterTopic = false;
                        });
                        BlocProvider.of<EventsCubit>(context)
                            .loadEvents(currentPage);
                      },
                      child: LimitedBox(
                        maxHeight: SizeConfig.blockSizeVertical * 69.6,
                        child: ListView.separated(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 2,
                              right: SizeConfig.blockSizeHorizontal * 2,
                              top: SizeConfig.blockSizeVertical * 2),
                          controller: checkFilterJoined == false ||
                                  checkFilterStatus == false ||
                                  checkFilterTopic == false
                              ? scrollController
                              : null,
                          separatorBuilder: (context, index) => SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          itemCount: events.length + (isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < events.length) {
                              return EventCard(
                                content: events[index],
                                eventAction: () {
                                  EventBusUtils.getInstance()
                                      .on<JoinedInEvent>()
                                      .listen((event) {
                                    if (events[index].content.eventId ==
                                        event.eventId) {
                                      setState(() {
                                        events[index].isJoined = event.joinedIn;
                                      });
                                    }
                                  });
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
                                padding: const EdgeInsets.all(30.0),
                                child:
                                    Center(child: CupertinoActivityIndicator()),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void updateKeepAlive() {
    // TODO: implement updateKeepAlive
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
