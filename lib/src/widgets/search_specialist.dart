import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/search_specialist_cubit.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/screens/specialist_details_screen.dart';
import 'package:expat_assistant/src/states/search_specialist_state.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/specialist_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchSpecialist extends SearchDelegate<ListSpec> {
  final SearchSpecialistCubit searchSpecialistCubit;
  int currentPage = 0;
  String keywords = '';
  List<SpecialistDetails> specialists = [];
  final ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        searchSpecialistCubit.searchSpecialists(keywords, currentPage);
      }
    });
  }

  SearchSpecialist({this.searchSpecialistCubit});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0.5,
      ),
      primaryColor: AppColors.MAIN_COLOR,
      textTheme:
          TextTheme(title: GoogleFonts.lato(fontSize: 20, color: Colors.white)),
      primaryIconTheme: IconThemeData(
        size: 50,
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixStyle: GoogleFonts.lato(fontSize: 20, color: Colors.white54),
        border: InputBorder.none,
        hintStyle: GoogleFonts.lato(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          query = '';
          currentPage = 0;
          specialists.clear();
          keywords = '';
        },
        icon: BackButtonIcon());
  }

  @override
  String get searchFieldLabel => 'Enter Specialist Name......';

  @override
  Widget buildResults(BuildContext context) {
    SizeConfig().init(context);
    if (query.isNotEmpty) {
      keywords = query;
      searchSpecialistCubit.searchSpecialists(keywords, currentPage);
    }
    return BlocBuilder<SearchSpecialistCubit, SearchSpecialistState>(
      bloc: searchSpecialistCubit,
      builder: (context, state) {
        setupScrollController(context);
        if (state.isFirstFetch && state.status.isSearching) {
          return Center(
            child: LoadingView(
              message: 'Searching...',
            ),
          );
        } else {
          bool isLoading = false;
          if (state.status.isSearching) {
            specialists = state.oldSpecialists;
            isLoading = true;
          } else if (state.status.isSearchSuccess) {
            specialists = state.specialists;
            currentPage = state.page;
          }
          return Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
            height: SizeConfig.blockSizeVertical * 90,
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
                      Navigator.pushNamed(context, RouteName.SPECIALIST_DETAILS,
                          arguments: SpecialistDetailsArguments(
                              specialists[index].specialist.specId));
                    },
                  );
                } else {
                  Timer(Duration(milliseconds: 30), () {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(child: CupertinoActivityIndicator()),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
