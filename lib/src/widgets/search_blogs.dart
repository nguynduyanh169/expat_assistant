import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/search_blogs_cubit.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/screens/channel_screen.dart';
import 'package:expat_assistant/src/states/search_blogs_state.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'news_card.dart';

class SearchBlogs extends SearchDelegate<ListBlog> {
  final SearchBlogCubit searchBlogCubit;
  int currentPage = 0;
  String keywords = '';
  List<ListBlog> blogs = [];
  final ScrollController scrollController = ScrollController();

  SearchBlogs({this.searchBlogCubit});

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        searchBlogCubit
            .searchBlogs(keywords, currentPage);
      }
    });
  }

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
      primaryColor: Colors.white,
      textTheme:
          TextTheme(title: GoogleFonts.lato(fontSize: 20, color: Colors.black)),
      primaryIconTheme: IconThemeData(
        size: 50,
        color: Colors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixStyle: GoogleFonts.lato(fontSize: 20, color: Colors.black54),
        border: InputBorder.none,
        hintStyle: GoogleFonts.lato(fontSize: 20, color: Colors.black54),
      ),
    );
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
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Enter blog title......';

  @override
  Widget buildResults(BuildContext context) {
    SizeConfig().init(context);
    if (query.isNotEmpty) {
      keywords = query;
      searchBlogCubit.searchBlogs(keywords, currentPage);
    }
    return BlocBuilder<SearchBlogCubit, SearchBlogState>(
        bloc: searchBlogCubit,
        builder: (context, state) {
          setupScrollController(context);
          if (state.isFirstFetch && state.status.isSearching) {
            return Center(
              child: LoadingView(message: 'Loading...'),
            );
          } else {
            bool isLoadingNews = false;
            if (state.status.isSearching) {
              blogs = state.oldBlogs;
              isLoadingNews = true;
            } else if (state.status.isSearchSuccess) {
              print(state.blogs);
              blogs = state.blogs;
              currentPage = state.page;
            }
            return Container(
                height: SizeConfig.blockSizeVertical * 81.8,
                child: ListView.separated(
                  controller: scrollController,
                  separatorBuilder: (context, index) => SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  itemBuilder: (context, index) {
                    if (index < blogs.length) {
                      return Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1,
                              right: SizeConfig.blockSizeHorizontal * 1),
                          child: ChannelCard(
                            blog: blogs[index],
                            openChannel: () => Navigator.pushNamed(
                                context, RouteName.CHANNEL,
                                arguments: ChannelDetailsArguments(
                                    blogs[index].channel.channelId)),
                            openNews: () => Navigator.pushNamed(
                                context, RouteName.BLOG_DETAILS),
                          ),
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
                  itemCount: blogs.length + (isLoadingNews ? 1 : 0),
                ));
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }
}
