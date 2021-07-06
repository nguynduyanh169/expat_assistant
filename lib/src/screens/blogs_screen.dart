import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/blogs_cubit.dart';
import 'package:expat_assistant/src/cubits/search_blogs_cubit.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/screens/channel_screen.dart';
import 'package:expat_assistant/src/states/blogs_state.dart';
import 'package:expat_assistant/src/widgets/channel_list.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/news_card.dart';
import 'package:expat_assistant/src/widgets/search_blogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogsScreen extends StatefulWidget {
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  int currentPage = 0;
  final ScrollController newsScrollController = ScrollController();
  List<ListBlog> news = [];

  void setupScrollController(BuildContext context) {
    newsScrollController.addListener(() {
      if (newsScrollController.position.pixels ==
          newsScrollController.position.maxScrollExtent) {
        BlocProvider.of<BlogsCubit>(context).getBlogsPaging(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          BlogsCubit(BlogRepository())..getBlogsPaging(currentPage),
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
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'News',
            style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
          ),
          actions: [
            BlocProvider(
                create: (context) => SearchBlogCubit(BlogRepository()),
                child: Builder(
                  builder: (context) => IconButton(
                      onPressed: () {
                        showSearch<ListBlog>(
                            context: context,
                            delegate: SearchBlogs(
                                searchBlogCubit:
                                    BlocProvider.of<SearchBlogCubit>(context)));
                      },
                      icon: Icon(
                        CupertinoIcons.search,
                        color: Colors.black,
                      )),
                )),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 5,
            ),
          ],
        ),
        body: BlocBuilder<BlogsCubit, BlogsState>(builder: (context, state) {
          setupScrollController(context);
          if (state.isFirstFetch && state.status.isLoadingBlogs) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 30,
                ),
                LoadingView(message: 'Loading...')
              ],
            );
          }
          bool isLoadingNews = false;
          if (state.status.isLoadingBlogs) {
            news = state.oldBlogs;
            isLoadingNews = true;
          } else if (state.status.isLoadBlogsSuccess) {
            news = state.blogs;
            currentPage = state.page;
          }
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 15,
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 1,
                      top: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 1,
                      bottom: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    child: ChannelList()),
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 1,
                      top: SizeConfig.blockSizeHorizontal * 3,
                      right: SizeConfig.blockSizeHorizontal * 1),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print('Category');
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
                                CupertinoIcons.square_list,
                                color: Color.fromRGBO(30, 193, 194, 30),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              Text(
                                'Category',
                                style: GoogleFonts.lato(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 1,
                      right: SizeConfig.blockSizeHorizontal * 1),
                  height: SizeConfig.blockSizeVertical * 64.3,
                  child: ListView.separated(
                    controller: newsScrollController,
                    separatorBuilder: (context, index) => SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    itemCount: news.length + (isLoadingNews ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < news.length) {
                        return Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1,
                              right: SizeConfig.blockSizeHorizontal * 1),
                          child: ChannelCard(
                            blog: news[index],
                            openChannel: () => Navigator.pushNamed(
                                context, RouteName.CHANNEL,
                                arguments: ChannelDetailsArguments(
                                    news[index].channel.channelId)),
                            openNews: () => Navigator.pushNamed(
                                context, RouteName.BLOG_DETAILS),
                          ),
                        );
                      } else {
                        Timer(Duration(milliseconds: 30), () {
                          newsScrollController.jumpTo(
                              newsScrollController.position.maxScrollExtent);
                        });
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: CupertinoActivityIndicator()),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
