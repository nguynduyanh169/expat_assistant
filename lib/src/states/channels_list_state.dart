import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/blog.dart';

enum ChannelListStatus {
  init,
  loadingChannels,
  loadChannelsSuccess,
  loadChannelsFailed,
}

extension Explanation on ChannelListStatus {
  bool get isInit => this == ChannelListStatus.init;
  bool get isLoadingChannels => this == ChannelListStatus.loadingChannels;

  bool get isLoadChannelsSuccess =>
      this == ChannelListStatus.loadChannelsSuccess;

  bool get isLoadChannelsFailed => this == ChannelListStatus.loadChannelsFailed;
}

class ChannelListState extends Equatable {
  final ChannelListStatus status;
  final List<Channel> oldChannels;
  final List<Channel> channels;
  final int page;
  final bool isFirstFetch;

  const ChannelListState(
      {this.channels,
      this.oldChannels,
      this.status,
      this.isFirstFetch,
      this.page});
  @override
  // TODO: implement props
  List<Object> get props => [channels, oldChannels, status, isFirstFetch, page];

  ChannelListState copyWith(
      {ChannelListStatus status,
      List<Channel> oldChannels,
      List<Channel> channels,
      int page,
      bool isFirstFetch}) {
    return ChannelListState(
        status: status ?? this.status,
        oldChannels: oldChannels ?? this.oldChannels,
        channels: channels ?? this.channels,
        page: page ?? this.page,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch);
  }
}
