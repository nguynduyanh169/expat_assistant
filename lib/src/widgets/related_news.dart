import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/related_news_cubit.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/screens/blog_details_screen.dart';
import 'package:expat_assistant/src/states/related_news_state.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class RelatedNewsItem extends StatelessWidget {
  ListBlog news;

  RelatedNewsItem({@required this.news});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        child: Column(
          // alignment: Alignment.bottomRight,
          children: <Widget>[
            ExtendedImage.network(
              news.coverLink,
              cache: true,
              width: SizeConfig.blockSizeHorizontal * 40,
              height: SizeConfig.blockSizeVertical * 18,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 1,
                  left: SizeConfig.blockSizeHorizontal * 1.5,
                  right: SizeConfig.blockSizeHorizontal * 1.5,
                  bottom: SizeConfig.blockSizeHorizontal * 2),
              alignment: Alignment.topCenter,
              width: SizeConfig.blockSizeHorizontal * 40,
              height: SizeConfig.blockSizeVertical * 10,
              child: Text(
                news.blogTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RelatedNews extends StatefulWidget {
  ListBlog existBlog;
  RelatedNews({this.existBlog});
  @override
  _RelatedNewsState createState() => _RelatedNewsState();
}

class _RelatedNewsState extends State<RelatedNews>
    with AutomaticKeepAliveClientMixin {
  final ScrollController scrollController = ScrollController();

  int currentPage = 0;

  List<ListBlog> relatedBlogs;

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<RelatedNewsCubit>(context).getRelatedNews(currentPage,
            widget.existBlog.category.categoryId, widget.existBlog);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => RelatedNewsCubit(BlogRepository())
        ..getRelatedNews(currentPage, widget.existBlog.category.categoryId,
            widget.existBlog),
      child: BlocBuilder<RelatedNewsCubit, RelatedNewsState>(
        builder: (context, state) {
          setupScrollController(context);
          bool isLoading = false;
          if (state.status.isLoading) {
            relatedBlogs = state.oldBlogs;
            isLoading = true;
          } else if (state.status.isLoaded) {
            relatedBlogs = state.blogs;
            currentPage = state.page;
          }
          return Container(
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 1,
              top: SizeConfig.blockSizeHorizontal * 2,
              right: SizeConfig.blockSizeHorizontal * 1,
              bottom: SizeConfig.blockSizeHorizontal * 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
                  child: Text(
                    'Related News',
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 99, 99, 30)),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 30,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        if (index < relatedBlogs.length) {
                          return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.BLOG_DETAILS,
                                    arguments: BlogDetailsArguments(
                                        relatedBlogs[index].blogId));
                              },
                              child: RelatedNewsItem(
                                news: relatedBlogs[index],
                              ));
                        } else {
                          Timer(Duration(milliseconds: 30), () {
                            scrollController.jumpTo(
                                scrollController.position.maxScrollExtent);
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
                      itemCount: relatedBlogs.length + (isLoading ? 1 : 0)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
