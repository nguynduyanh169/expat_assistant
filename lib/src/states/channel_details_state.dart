import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/blog.dart';

enum ChannelDetailsStatus {
  init,
  loadingChannel,
  loadChannelSuccess,
  loadChannelFailed
}

extension Explanation on ChannelDetailsStatus {
  bool get isInit => this == ChannelDetailsStatus.init;
  bool get isLoadingChannel => this == ChannelDetailsStatus.loadingChannel;

  bool get isLoadChannelSuccess =>
      this == ChannelDetailsStatus.loadChannelSuccess;

  bool get isLoadChannelFailed =>
      this == ChannelDetailsStatus.loadChannelFailed;
}

class ChannelDetailsState extends Equatable {
  final List<ListBlog> blogs;
  final List<ListBlog> oldBlogs;
  final ChannelDetailsStatus status;
  final int page;
  final Channel channel;
  final bool isFirstFetch;

  const ChannelDetailsState(
      {this.blogs,
      this.oldBlogs,
      this.channel,
      this.status,
      this.page,
      this.isFirstFetch});

  @override
  // TODO: implement props
  List<Object> get props =>
      [blogs, oldBlogs, channel, status, page, isFirstFetch];

  ChannelDetailsState copyWith(
      {List<ListBlog> blogs,
      List<ListBlog> oldBlogs,
      ChannelDetailsStatus status,
      int page,
      bool isFirstFetch,
      Channel channel}) {
    return ChannelDetailsState(
        blogs: blogs ?? this.blogs,
        oldBlogs: oldBlogs ?? this.oldBlogs,
        status: status ?? this.status,
        channel: channel ?? this.channel,
        page: page ?? this.page,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch);
  }
}
