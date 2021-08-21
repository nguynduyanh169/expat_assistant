import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/channels_list_cubit.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/channel_repository.dart';
import 'package:expat_assistant/src/screens/channel_screen.dart';
import 'package:expat_assistant/src/states/channels_list_state.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChannelList extends StatefulWidget {
  @override
  _ChannelListState createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList>
    with AutomaticKeepAliveClientMixin {
  int currentPage = 0;
  final ScrollController scrollController = ScrollController();
  List<Channel> channels = [];

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<ChannelListCubit>(context)
            .getChannelsPaging(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          ChannelListCubit(ChannelRepository())..getChannelsPaging(currentPage),
      child: BlocBuilder<ChannelListCubit, ChannelListState>(
        builder: (context, state) {
          setupScrollController(context);
          bool isLoadingChannels = false;
          if (state.status.isLoadingChannels) {
            channels = state.oldChannels;
            isLoadingChannels = true;
          } else if (state.status.isLoadChannelsSuccess) {
            channels = state.channels;
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
                    'Channels',
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 99, 99, 30)),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 15,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        if (index < channels.length) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.CHANNEL,
                                  arguments:
                                      ChannelDetailsArguments(channels[index]));
                            },
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: <Widget>[
                                    ExtendedImage.network(
                                      channels[index].image,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 30,
                                      height: SizeConfig.blockSizeVertical * 15,                                     
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                            Colors.grey.withOpacity(0),
                                            Colors.black,
                                          ],
                                              stops: [
                                            0.0,
                                            2.0
                                          ])),
                                      padding: EdgeInsets.all(
                                          SizeConfig.blockSizeHorizontal * 2),
                                      alignment: Alignment.bottomLeft,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 30,
                                      height: SizeConfig.blockSizeVertical * 15,
                                      child: Text(
                                        channels[index].channelName.trim(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
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
                      itemCount: channels.length + (isLoadingChannels ? 1 : 0)),
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
