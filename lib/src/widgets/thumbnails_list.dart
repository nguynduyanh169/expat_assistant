import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/thumbnails_home_cubits.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/states/thumbnails_home_state.dart';
import 'package:expat_assistant/src/widgets/thumbnail_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ThumbnailsList extends StatefulWidget {
  @override
  _ThumbnailsListState createState() => _ThumbnailsListState();
}

class _ThumbnailsListState extends State<ThumbnailsList>
    with AutomaticKeepAliveClientMixin {
  final ScrollController scrollController = ScrollController();

  List<ListBlog> blogs = [];

  int currentPage = 0;

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<ThumbnailsHomeCubit>(context)
            .getPrioritizedBlogs(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => ThumbnailsHomeCubit(BlogRepository())
        ..getPrioritizedBlogs(currentPage),
      child: BlocBuilder<ThumbnailsHomeCubit, ThumbnailsState>(
          builder: (context, state) {
        setupScrollController(context);
        bool isLoading = false;
        if (state.status.isLoadingPrioritized) {
          blogs = state.oldPrioritizedBlogs;
          isLoading = true;
        } else if (state.status.isLoadPrioritizedSuccess) {
          blogs = state.prioritizedBlogs;
          currentPage = state.page;
        }
        return Container(
          width: SizeConfig.blockSizeHorizontal * 90,
          height: SizeConfig.blockSizeVertical * 20,
          child: ListView.separated(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: blogs.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < blogs.length) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.BLOG_DETAILS);
                  },
                  child: ThumbnailCard(
                    news: blogs[index],
                  ),
                );
              } else {
                Timer(Duration(milliseconds: 30), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(child: CupertinoActivityIndicator()),
                );
              }
            },
            separatorBuilder: (context, index) => SizedBox(
              width: SizeConfig.blockSizeHorizontal * 2,
            ),
          ),
        );
      }),
    );
  }

  @override
  // ignore: todo
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
