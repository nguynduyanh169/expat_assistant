import 'dart:async';

import 'package:expandable_text/expandable_text.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/channel_details_cubit.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/states/channel_details_state.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChannelScreen extends StatefulWidget {
  _ChannelState createState() => _ChannelState();
}

class _ChannelState extends State<ChannelScreen> {
  int currentPage = 0;
  List<ListBlog> blogs = [];
  Channel channel = Channel();
  final ScrollController scrollController = ScrollController();
  void setupScrollController(BuildContext context, int channelId) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<ChannelDetailsCubit>(context)
            .getBlogsChannel(currentPage, channelId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args =
        ModalRoute.of(context).settings.arguments as ChannelDetailsArguments;
    channel = args.channel;
    return BlocProvider(
        create: (context) => ChannelDetailsCubit(BlogRepository())
          ..getBlogsChannel(currentPage, args.channel.channelId),
        child: BlocBuilder<ChannelDetailsCubit, ChannelDetailsState>(
            builder: (context, state) {
          setupScrollController(context, args.channel.channelId);
          if (state.isFirstFetch && state.status.isLoadingChannel) {
            return Scaffold(
              body: Column(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 30,
                  ),
                  LoadingView(message: 'Loading...'),
                ],
              ),
            );
          }
          bool isLoading = false;
          if (state.status.isLoadingChannel) {
            blogs = state.oldBlogs;
            isLoading = true;
          } else if (state.status.isLoadChannelSuccess) {
            blogs = state.blogs;
            currentPage = state.page;
          }
          return Scaffold(
            backgroundColor: Color.fromRGBO(245, 244, 244, 2),
            appBar: AppBar(
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.black38,
                    height: 0.25,
                  ),
                  preferredSize: Size.fromHeight(0.25)),
              elevation: 0.5,
              backgroundColor: AppColors.MAIN_COLOR,
              automaticallyImplyLeading: true,
              iconTheme: IconThemeData(color: Colors.white),
              centerTitle: true,
              title: Text(
                channel.channelName,
                style: GoogleFonts.lato(fontSize: 22, color: Colors.white),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName(RouteName.HOME_PAGE));
                    },
                    icon: Icon(CupertinoIcons.home)),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 4,
                )
              ],
            ),
            body: Container(
              height: SizeConfig.blockSizeVertical * 100,
              child: ListView(
                controller: scrollController,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        child: Image(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: SizeConfig.blockSizeVertical * 25,
                          fit: BoxFit.cover,
                          image: channel.image != null
                              ? NetworkImage(channel.image)
                              : AssetImage('assets/images/demo_channel.png'),
                        ),
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 100,
                        height: SizeConfig.blockSizeVertical * 25,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                              Colors.grey.withOpacity(0),
                              Colors.black,
                            ],
                                stops: [
                              0.0,
                              2.0
                            ])),
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 1,
                            right: SizeConfig.blockSizeHorizontal * 1,
                            bottom: SizeConfig.blockSizeVertical * 2),
                        child: Text(
                          channel.channelName,
                          style: GoogleFonts.lato(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Text(
                      'About This Channel',
                      style: GoogleFonts.lato(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 99, 99, 30)),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2),
                    child: ExpandableText(
                      channel.description != null
                          ? channel.description
                          : 'Error',
                      expandText: 'read more',
                      collapseText: 'read less',
                      linkStyle: GoogleFonts.lato(),
                      maxLines: 4,
                      linkColor: Colors.blue,
                      style: GoogleFonts.lato(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Text(
                      'Recent News',
                      style: GoogleFonts.lato(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 99, 99, 30)),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                            openNews: () => Navigator.pushNamed(
                                context, RouteName.BLOG_DETAILS),
                          ),
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
                    itemCount: blogs.length + (isLoading ? 1 : 0),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}

class ChannelDetailsArguments {
  final Channel channel;

  const ChannelDetailsArguments(this.channel);
}
