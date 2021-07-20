import 'dart:collection';

import 'package:expandable_text/expandable_text.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/specialist_details_cubit.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/models/session.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/repositories/specialist_repository.dart';
import 'package:expat_assistant/src/screens/invoice_screen.dart';
import 'package:expat_assistant/src/states/specialis_details_state.dart';
import 'package:expat_assistant/src/utils/session_utils.dart';
import 'package:expat_assistant/src/utils/text_utils.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:table_calendar/table_calendar.dart';

class SpecialistDetailsScreen extends StatefulWidget {
  _SpecialistDetailsState createState() => _SpecialistDetailsState();
}

class _SpecialistDetailsState extends State<SpecialistDetailsScreen> {
  ValueNotifier<List<SessionDisplay>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  bool isChecked = false;
  SpecialistDetails specialistDetails;
  LinkedHashMap<DateTime, List<SessionDisplay>> kSession;
  List<SessionDisplay> selectedSessions = [];
  SessionUtils _sessionUtils = SessionUtils();
  TextUtils _textUtils = TextUtils();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<SessionDisplay> _getEventsForDay(DateTime day) {
    // Implementation example
    return kSession[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _displaySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: GoogleFonts.lato(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(milliseconds: 1500),
      // width: SizeConfig.blockSizeHorizontal * 60,
      // Width of the SnackBar.
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      backgroundColor: Colors.blueAccent,

      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args =
        ModalRoute.of(context).settings.arguments as SpecialistDetailsArguments;
    return BlocProvider(
      create: (context) => SpecialistDetailsCubit(SpecialistRepository())
        ..getSpecialistDetails(args.specId),
      child: Scaffold(
        appBar: AppBar(
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
            'Specialist Infomation',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(RouteName.HOME_PAGE));
                },
                icon: Icon(CupertinoIcons.home)),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 10,
                right: SizeConfig.blockSizeHorizontal * 10,
                top: SizeConfig.blockSizeVertical * 1.75,
                bottom: SizeConfig.blockSizeVertical * 1.75),
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
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 70,
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.MAIN_COLOR),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.lato(fontSize: 17))),
                child: Text("Make an Appointment"),
                onPressed: () => selectedSessions.length == 0
                    ? _displaySnackBar(context, 'Please pick your session!')
                    : Navigator.pushNamed(context, RouteName.INVOICE,
                        arguments: InvoiceScreenArguments(
                            selectedSessions, specialistDetails)),
              ),
            ),
          ),
        ),
        body: BlocBuilder<SpecialistDetailsCubit, SpecialistDetailState>(
          builder: (context, state) {
            if (state.status.isLoadingSpecialistDetail) {
              return LoadingView(message: 'Loading...');
            } else {
              if (state.status.isLoadedSpecialistDetail) {
                kSession = state.sessions;
                specialistDetails = state.specialistDetails;
                _selectedDay = _focusedDay;
                _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
              }
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      height: SizeConfig.blockSizeVertical * 78.4,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: SizeConfig.blockSizeVertical * 14,
                            child: Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: ExtendedImage.network(
                                    specialistDetails.specialist.avatar,
                                    fit: BoxFit.cover,
                                    width: SizeConfig.blockSizeHorizontal * 26,
                                    height: SizeConfig.blockSizeVertical * 14,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 2,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      specialistDetails.specialist.fullname,
                                      style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      specialistDetails.majors.first.name,
                                      style: GoogleFonts.lato(),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.blockSizeVertical * 0.7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        RatingBar.builder(
                                          itemSize: 14,
                                          initialRating: specialistDetails
                                              .specialist.rating,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 1.0),
                                          itemBuilder: (context, _) => Icon(
                                            CupertinoIcons.star_fill,
                                            color:
                                                Color.fromRGBO(252, 191, 7, 30),
                                            size: 12,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text(
                                          specialistDetails.specialist.rating
                                              .toString(),
                                          style: GoogleFonts.lato(
                                              color: Colors.black54),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Language: ',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          _textUtils.getLanguages(
                                              languages: specialistDetails.language),
                                          style: GoogleFonts.lato(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Certificate: ',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          'Bachelor Degree of Lawyer',
                                          style: GoogleFonts.lato(),
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          softWrap: false,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Text(
                            "Profile",
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 99, 99, 30)),
                          ),
                          ExpandableText(
                            specialistDetails.specialist.biography,
                            expandText: 'read more',
                            collapseText: 'read less',
                            linkStyle: GoogleFonts.lato(),
                            maxLines: 6,
                            linkColor: Colors.blue,
                            style: GoogleFonts.lato(),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Text(
                            "Schedule",
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 99, 99, 30)),
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 60,
                            child: Column(
                              children: <Widget>[
                                TableCalendar<SessionDisplay>(
                                  locale: 'en_US',
                                  firstDay: kFirstDay,
                                  lastDay: kLastDay,
                                  focusedDay: _focusedDay,
                                  selectedDayPredicate: (day) =>
                                      isSameDay(_selectedDay, day),
                                  calendarFormat: _calendarFormat,
                                  eventLoader: _getEventsForDay,
                                  startingDayOfWeek: StartingDayOfWeek.monday,
                                  calendarStyle: CalendarStyle(
                                    outsideDaysVisible: false,
                                  ),
                                  onDaySelected: _onDaySelected,
                                  onFormatChanged: (format) {
                                    if (_calendarFormat != format) {
                                      setState(() {
                                        _calendarFormat = format;
                                      });
                                    }
                                  },
                                  onPageChanged: (focusedDay) {
                                    _focusedDay = focusedDay;
                                  },
                                ),
                                Expanded(
                                  child: ValueListenableBuilder<
                                      List<SessionDisplay>>(
                                    valueListenable: _selectedEvents,
                                    builder: (context, value, _) {
                                      return ListView.separated(
                                        itemCount: value.length,
                                        itemBuilder: (context, index) {
                                          return GFCheckboxListTile(
                                              value: value[index].isChoosen,
                                              size: 20,
                                              avatar: Icon(
                                                LineIcons.businessTime,
                                                color: _sessionUtils
                                                        .checkDisableSession(
                                                            value[index])
                                                    ? Colors.grey
                                                    : AppColors.MAIN_COLOR,
                                              ),
                                              title: Text(
                                                value[index].toString(),
                                                style: GoogleFonts.lato(
                                                    color: _sessionUtils
                                                            .checkDisableSession(
                                                                value[index])
                                                        ? Colors.grey
                                                        : Colors.black),
                                              ),
                                              description: Text(
                                                  value[index]
                                                          .price
                                                          .toString() +
                                                      "VND",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 11,
                                                      color: _sessionUtils
                                                              .checkDisableSession(
                                                                  value[index])
                                                          ? Colors.grey
                                                          : Colors.black)),
                                              activeBgColor: Colors.green,
                                              inactiveBorderColor: Colors.grey,
                                              type: GFCheckboxType.circle,
                                              activeIcon: Icon(
                                                Icons.check,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                              onChanged: (changeValue) {
                                                if (_sessionUtils
                                                        .checkDisableSession(
                                                            value[index]) ==
                                                    false) {
                                                  setState(() {
                                                    value[index].isChoosen =
                                                        changeValue;
                                                    if (value[index]
                                                            .isChoosen ==
                                                        true) {
                                                      selectedSessions
                                                          .add(value[index]);
                                                    } else {
                                                      selectedSessions.removeWhere(
                                                          (element) =>
                                                              value[index]
                                                                  .sessionId ==
                                                              element
                                                                  .sessionId);
                                                    }
                                                  });
                                                } else {
                                                  _displaySnackBar(context,
                                                      'Cannot select this session!');
                                                }
                                              });
                                        },
                                        separatorBuilder: (context, index) =>
                                            Divider(color: Colors.grey),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class SpecialistDetailsArguments {
  final int specId;

  const SpecialistDetailsArguments(this.specId);
}
