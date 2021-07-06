import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/states/channel_details_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class ChannelDetailsCubit extends Cubit<ChannelDetailsState> {
  BlogRepository _blogRepository;
  final HiveUtils _hiveUtils = HiveUtils();
  ChannelDetailsCubit(this._blogRepository)
      : super(const ChannelDetailsState(status: ChannelDetailsStatus.init));

  Future<void> getBlogsChannel(int page, int channelId) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isLoadingChannel) return null;
      final currentState = state;
      List<ListBlog> oldBlogs = [];
      List<ListBlog> blogs = [];
      Channel channel = Channel();
      if (currentState.status.isLoadChannelSuccess) {
        oldBlogs = state.blogs;
      }
      emit(state.copyWith(
        status: ChannelDetailsStatus.loadingChannel,
        oldBlogs: oldBlogs,
        isFirstFetch: page == 0,
      ));
      var result = await _blogRepository.getBlogsByChannel(
          token: token, page: page, channelId: channelId);
      if (result == 204) {
        if (oldBlogs.isNotEmpty) {
          channel = oldBlogs[0].channel;
        }
        emit(state.copyWith(
            page: page,
            status: ChannelDetailsStatus.loadChannelSuccess,
            blogs: oldBlogs,
            channel: channel));
      } else {
        page++;
        final thisBlogs = state.oldBlogs;
        blogs.addAll(thisBlogs);
        blogs.addAll(result);
        if (blogs.isNotEmpty) {
          print('ok');
          channel = blogs[0].channel;
        }
        emit(state.copyWith(
            page: page,
            status: ChannelDetailsStatus.loadChannelSuccess,
            blogs: blogs,
            channel: channel));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          page: page, status: ChannelDetailsStatus.loadChannelFailed));
    }
  }
}
