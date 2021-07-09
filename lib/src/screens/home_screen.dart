import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/home_cubit.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/screens/blog_details_screen.dart';
import 'package:expat_assistant/src/screens/channel_screen.dart';
import 'package:expat_assistant/src/states/home_state.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/news_card.dart';
import 'package:expat_assistant/src/widgets/thumbnails_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen();

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  final ScrollController newsScrollController = ScrollController();
  int currentPage = 0;
  List<ListBlog> prioritizedBlogs = [];
  List<ListBlog> news = [];
  void setupScrollController(BuildContext context) {
    newsScrollController.addListener(() {
      if (newsScrollController.position.pixels ==
          newsScrollController.position.maxScrollExtent) {
        BlocProvider.of<HomeCubit>(context).getLatestNews(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          HomeCubit(BlogRepository())..getLatestNews(currentPage),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(245, 244, 244, 30),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black38,
                height: 0.25,
              ),
              preferredSize: Size.fromHeight(0.25)),
          backgroundColor: AppColors.MAIN_COLOR,
          //toolbarHeight: SizeConfig.blockSizeVertical * 10,
          elevation: 0.5,
          foregroundColor: Colors.black54,
          automaticallyImplyLeading: false,
          leading: Container(
            child: Image(
              width: SizeConfig.blockSizeHorizontal * 11,
              height: SizeConfig.blockSizeVertical * 11,
              image: AssetImage('assets/images/app_icon.png'),
            ),
          ),
          title: Text(
            'Home',
            style: GoogleFonts.lato(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteName.NOTIFICATION);
              },
              child: Icon(
                LineIcons.bellAlt,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 3,
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          height: SizeConfig.blockSizeVertical * 90,
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 1,
              right: SizeConfig.blockSizeHorizontal * 1),
          child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
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
            } else {
              bool isLoadingNews = false;
              if (state.status.isLoadingBlogs) {
                news = state.oldBlogs;
                isLoadingNews = true;
              } else if (state.status.isLoadBlogsSuccess) {
                news = state.blogs;
                currentPage = state.pageOfLatestNews;
              }
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    currentPage = 0;
                    isLoadingNews = false;
                    news.clear();
                  });
                  BlocProvider.of<HomeCubit>(context)
                      .getLatestNews(currentPage);
                },
                child: ListView(
                  scrollDirection: Axis.vertical,
                  controller: newsScrollController,
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Container(
                      child: Text(
                        'Welcome Bao!',
                        style: GoogleFonts.lato(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    ThumbnailsList(),
                    Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Services',
                            style: GoogleFonts.lato(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 99, 99, 30)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Container(
                            //width: SizeConfig.blockSizeHorizontal * 30,
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2),
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
                                  LineIcons.hamburger,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('Nearby Restaurants',
                                    style: GoogleFonts.lato())
                              ],
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2),
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
                                  LineIcons.phoneVolume,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('Incoming Appointments',
                                    style: GoogleFonts.lato())
                              ],
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2),
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
                                  LineIcons.calendarCheck,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('Incoming Events',
                                    style: GoogleFonts.lato())
                              ],
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2),
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
                                  LineIcons.book,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Text('Latest Vietnamese Lessons',
                                    style: GoogleFonts.lato())
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Lasted News',
                            style: GoogleFonts.lato(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 99, 99, 30)),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.BLOGS);
                            },
                            child: Text('See more',
                                style: GoogleFonts.lato(
                                    color: Color.fromRGBO(30, 193, 194, 30))),
                          )
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
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
                                  context, RouteName.BLOG_DETAILS, arguments: BlogDetailsArguments(news[index].blogId)),
                            ),
                          );
                        } else {
                          Timer(Duration(milliseconds: 30), () {
                            newsScrollController.jumpTo(
                                newsScrollController.position.maxScrollExtent);
                          });
                          return Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Center(child: CupertinoActivityIndicator()),
                          );
                        }
                      },
                      itemCount: news.length + (isLoadingNews ? 1 : 0),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  @override
  void updateKeepAlive() {
    // TODO: implement updateKeepAlive
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
