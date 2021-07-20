import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/filter_specialist_cubit.dart';
import 'package:expat_assistant/src/cubits/search_specialist_cubit.dart';
import 'package:expat_assistant/src/models/major.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/repositories/specialist_repository.dart';
import 'package:expat_assistant/src/screens/specialist_details_screen.dart';
import 'package:expat_assistant/src/states/filter_specialist_state.dart';
import 'package:expat_assistant/src/widgets/alert_dialog_vocabulary.dart';
import 'package:expat_assistant/src/widgets/search_specialist.dart';
import 'package:expat_assistant/src/widgets/specialist_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class SpecialistFilterScreen extends StatefulWidget {
  @override
  _SpecialistFilterScreenState createState() => _SpecialistFilterScreenState();
}

class _SpecialistFilterScreenState extends State<SpecialistFilterScreen> {
  int currentPage = 0;
  List<SpecialistDetails> specialists = [];
  Content selectedMajor;
  bool isFilteredByMajor = false;
  bool isFilteredByDate = false;

  final ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (isFilteredByMajor == true) {
          BlocProvider.of<FilterSpecialistsCubit>(context)
              .getSpecialistsByMajor(currentPage, selectedMajor.majorId);
        } else if (isFilteredByDate == true) {
          BlocProvider.of<FilterSpecialistsCubit>(context)
              .getSpecialistsByCreateDate(currentPage);
        } else {
          BlocProvider.of<FilterSpecialistsCubit>(context)
              .getSpecialists(currentPage);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => FilterSpecialistsCubit(SpecialistRepository())
        ..getSpecialists(currentPage),
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
          automaticallyImplyLeading: true,
          title: Text(
            'Find your specialist',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            BlocProvider(
              create: (context) =>
                  SearchSpecialistCubit(SpecialistRepository()),
              child: Builder(
                builder: (context) => InkWell(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: SearchSpecialist(
                            searchSpecialistCubit:
                                BlocProvider.of<SearchSpecialistCubit>(
                                    context)));
                  },
                  child: Icon(CupertinoIcons.search),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
          centerTitle: true,
        ),
        body: BlocBuilder<FilterSpecialistsCubit, FilterSpecialistState>(
          builder: (context, state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
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
                            selectedMajor = await showMajors(context: context);
                            if (selectedMajor != null) {
                              setState(() {
                                specialists.clear();
                                isFilteredByMajor = true;
                                isFilteredByDate = false;
                                currentPage = 0;
                              });
                              BlocProvider.of<FilterSpecialistsCubit>(context)
                                  .getSpecialistsByMajor(
                                      currentPage, selectedMajor.majorId);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: isFilteredByMajor
                                  ? AppColors.MAIN_COLOR
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.square_list,
                                  size: 16,
                                  color: isFilteredByMajor
                                      ? Colors.white
                                      : AppColors.MAIN_COLOR,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text(
                                  isFilteredByMajor
                                      ? selectedMajor.name
                                      : 'Major',
                                  style: GoogleFonts.lato(
                                      color: isFilteredByMajor
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
                          onTap: () {
                            setState(() {
                              specialists.clear();
                              isFilteredByMajor = false;
                              isFilteredByDate = true;
                              currentPage = 0;
                            });
                            BlocProvider.of<FilterSpecialistsCubit>(context)
                                .getSpecialistsByCreateDate(currentPage);
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: isFilteredByDate
                                  ? AppColors.MAIN_COLOR
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  LineIcons.userGraduate,
                                  size: 16,
                                  color: isFilteredByDate
                                      ? Colors.white
                                      : AppColors.MAIN_COLOR,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('New Specialists',
                                    style: GoogleFonts.lato(
                                        color: isFilteredByDate
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
                              specialists.clear();
                              isFilteredByMajor = false;
                              isFilteredByDate = false;
                              currentPage = 0;
                            });
                            BlocProvider.of<FilterSpecialistsCubit>(context)
                                .getSpecialists(currentPage);
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
                  ),
                  BlocBuilder<FilterSpecialistsCubit, FilterSpecialistState>(
                    builder: (context, state) {
                      setupScrollController(context);
                      bool isLoading = false;
                      if (state.status.isLoadingSpecialists) {
                        specialists = state.oldSpecialists;
                        isLoading = true;
                      } else if (state.status.isLoadSpecialistsSuccess) {
                        specialists = state.specialists;
                        currentPage = state.page;
                      } else if (state.status.isFilteringByMajor) {
                        specialists = state.oldSpecialistsMajor;
                        isLoading = true;
                      } else if (state.status.isFilterByMajorSuccess) {
                        specialists = state.specialistsMajor;
                        currentPage = state.page;
                      }else if (state.status.isFilteringByDate) {
                        specialists = state.oldSpecialistsDate;
                        isLoading = true;
                      } else if (state.status.isFilterByDateSuccess) {
                        specialists = state.specialistsDate;
                        currentPage = state.page;
                      }
                      return Container(
                          padding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal * 2),
                          child: LimitedBox(
                            maxHeight: SizeConfig.blockSizeVertical * 76.3,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: scrollController,
                              itemCount:
                                  specialists.length + (isLoading ? 1 : 0),
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
                                              specialists[index]
                                                  .specialist
                                                  .specId));
                                    },
                                  );
                                } else {
                                  Timer(Duration(milliseconds: 30), () {
                                    scrollController.jumpTo(scrollController
                                        .position.maxScrollExtent);
                                  });
                                  return Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Center(
                                        child: CupertinoActivityIndicator()),
                                  );
                                }
                              },
                            ),
                          ));
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
