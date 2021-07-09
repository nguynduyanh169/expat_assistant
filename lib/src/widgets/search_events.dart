import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/search_event_cubit.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/screens/event_details_screen.dart';
import 'package:expat_assistant/src/states/search_event_state.dart';
import 'package:expat_assistant/src/utils/event_bus_utils.dart';
import 'package:expat_assistant/src/widgets/event_card.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchEvents extends SearchDelegate<EventShow> {
  final SearchEventCubit eventSearchCubit;

  SearchEvents({@required this.eventSearchCubit});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.white,),
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
        prefixStyle: GoogleFonts.lato(fontSize: 20, color: Colors.white),
        border: InputBorder.none,
        hintStyle: GoogleFonts.lato(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  PreferredSizeWidget buildBottom(BuildContext context) {
    return PreferredSize(
        child: Container(
          color: Colors.black38,
          height: 0.25,
        ),
        preferredSize: Size.fromHeight(0.25));
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: BackButtonIcon());
  }

  @override
  String get searchFieldLabel => 'Enter event title......';

  @override
  Widget buildResults(BuildContext context) {
    SizeConfig().init(context);
    if (query.isNotEmpty) {
      eventSearchCubit.searchEvents(query);
    }
    return BlocBuilder<SearchEventCubit, SearchEventState>(
      builder: (context, state) {
        if (state.status.isSearching) {
          return Center(
            child: LoadingView(
              message: 'Finding...',
            ),
          );
        }
        if (state.status.isSearchError) {
          return Container(
            child: Text('error'),
          );
        } else {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    child: Text(
                      'Found ${state.searchEventList.length} results',
                      style: GoogleFonts.lato(fontSize: 18),
                    )),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 81.8,
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2,
                        right: SizeConfig.blockSizeHorizontal * 2,
                        top: SizeConfig.blockSizeVertical * 2),
                    separatorBuilder: (context, index) => SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    itemCount: state.searchEventList.length,
                    itemBuilder: (context, index) {
                      return EventCard(
                        content: state.searchEventList[index],
                        eventAction: () {
                          EventBusUtils.getInstance()
                              .on<JoinedInEvent>()
                              .listen((event) {
                            state.searchEventList[index].isJoined =
                                  event.joinedIn;
                          });
                          EventBusUtils.getInstance().fire(JoinedInEvent(state.searchEventList[index].content.eventId, state.searchEventList[index].isJoined));
                          Navigator.pushNamed(context, RouteName.EVENT_DETAILS,
                              arguments: EventDetailsScreenArguments(state
                                  .searchEventList[index].content.eventId));
                        },
                      );
                    },
                  ),
                ),
              ],
            );
        }
      },
      bloc: eventSearchCubit,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
