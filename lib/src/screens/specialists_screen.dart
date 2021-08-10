import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/specialist_cubit.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/repositories/specialist_repository.dart';
import 'package:expat_assistant/src/screens/specialist_details_screen.dart';
import 'package:expat_assistant/src/states/specialists_state.dart';
import 'package:expat_assistant/src/utils/event_bus_utils.dart';
import 'package:expat_assistant/src/widgets/specialist_card.dart';
import 'package:expat_assistant/src/widgets/upcomming_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialistsScreen extends StatefulWidget {
  _SpecialistsScreenState createState() => _SpecialistsScreenState();
}

class _SpecialistsScreenState extends State<SpecialistsScreen> {
  int currentPage = 0;
  bool isReload = false;
  List<SpecialistDetails> specialists = [];
  ExpatAppointment appointment;
  final ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        BlocProvider.of<SpecialistCubit>(context).getSpecialists(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          SpecialistCubit(SpecialistRepository())..getSpecialists(currentPage),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(245, 244, 244, 2),
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
          automaticallyImplyLeading: true,
          title: Text(
            'Specialist',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(RouteName.HOME_PAGE));
              },
              child: Icon(CupertinoIcons.home),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Upcoming Appointment',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 99, 99, 30)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteName.UPCOMING_APPOINTMENT);
                      },
                      child: Text('See more',
                          style: GoogleFonts.lato(
                              color: Color.fromRGBO(30, 193, 194, 30))),
                    )
                  ],
                ),
              ),
              TodayAppointment(isReload),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Top Specialists",
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 99, 99, 30)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, RouteName.FILTER_SPECIALIST),
                      child: Text('See more',
                          style: GoogleFonts.lato(
                              color: Color.fromRGBO(30, 193, 194, 30))),
                    )
                  ],
                ),
              ),
              BlocBuilder<SpecialistCubit, SpecialistState>(
                builder: (context, state) {
                  setupScrollController(context);
                  bool isLoading = false;
                  if (state.status.isLoadingSpecialist) {
                    specialists = state.oldSpecialists;
                    isLoading = true;
                  } else if (state.status.isLoadedSpecialist) {
                    specialists = state.specialists;
                    currentPage = state.page;
                  }
                  return Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2,
                        right: SizeConfig.blockSizeHorizontal * 2),
                    height: SizeConfig.blockSizeVertical * 48,
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: specialists.length + (isLoading ? 1 : 0),
                      separatorBuilder: (context, index) => SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < specialists.length) {
                          return SpecialistCard(
                            spec: specialists[index],
                            action: () {
                              EventBusUtils.getInstance()
                                  .on<UpdateAppointment>()
                                  .listen((result) {
                                if (result.update) {
                                  setState(() {
                                    isReload = true;
                                  });
                                }
                              });
                              Navigator.pushNamed(
                                  context, RouteName.SPECIALIST_DETAILS,
                                  arguments: SpecialistDetailsArguments(
                                      specialists[index].specialist.specId));
                            },
                          );
                        } else {
                          Timer(Duration(milliseconds: 30), () {
                            scrollController.jumpTo(
                                scrollController.position.maxScrollExtent);
                          });
                          return Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Center(child: CupertinoActivityIndicator()),
                          );
                        }
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
