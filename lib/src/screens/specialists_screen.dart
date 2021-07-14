import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/specialist_cubit.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/repositories/specialist_repository.dart';
import 'package:expat_assistant/src/screens/specialist_details_screen.dart';
import 'package:expat_assistant/src/states/specialists_state.dart';
import 'package:expat_assistant/src/widgets/appointment_card.dart';
import 'package:expat_assistant/src/widgets/specialist_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class SpecialistsScreen extends StatefulWidget {
  _SpecialistsScreenState createState() => _SpecialistsScreenState();
}

class _SpecialistsScreenState extends State<SpecialistsScreen> {
  int currentPage = 0;
  List<ListSpec> specialists = [];
  final ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
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
              onTap: (){
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
                    Text('See more',
                        style: GoogleFonts.lato(
                            color: Color.fromRGBO(30, 193, 194, 30)))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 5,
                    right: SizeConfig.blockSizeHorizontal * 5),
                child: AppointmentCard(
                  action: () {
                    Navigator.pushNamed(context, RouteName.CALL_ROOM);
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Let's find your specialist",
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 99, 99, 30)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, RouteName.FILTER_SPECIALIST),
                      child: Text('See more',
                          style: GoogleFonts.lato(
                              color: Color.fromRGBO(30, 193, 194, 30))),
                    )
                  ],
                ),
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 5,
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    right: SizeConfig.blockSizeHorizontal * 2),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      decoration: BoxDecoration(
                          color: AppColors.MAIN_COLOR,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.05),
                                offset: Offset(0.0, 6.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text('All Major',
                              style: GoogleFonts.lato(color: Colors.white))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    Container(
                      //width: SizeConfig.blockSizeHorizontal * 30,
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.05),
                                offset: Offset(0.0, 6.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            LineIcons.balanceScale,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text('Lawyer', style: GoogleFonts.lato())
                        ],
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.05),
                                offset: Offset(0.0, 6.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            LineIcons.laptop,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text('IT support', style: GoogleFonts.lato())
                        ],
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.05),
                                offset: Offset(0.0, 6.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            LineIcons.lightningBolt,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text('Electrician', style: GoogleFonts.lato())
                        ],
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.05),
                                offset: Offset(0.0, 6.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            LineIcons.brain,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text('Psychologist', style: GoogleFonts.lato())
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
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
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                    height: SizeConfig.blockSizeVertical * 41,
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
                              Navigator.pushNamed(
                                  context, RouteName.SPECIALIST_DETAILS,
                                  arguments: SpecialistDetailsArguments(
                                      specialists[index].specId));
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
