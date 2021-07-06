import 'package:expat_assistant/src/providers/channel_provider.dart';
import 'package:flutter/cupertino.dart';

class ChannelRepository {
  final ChannelProvider _channelProvider = ChannelProvider();

  Future<dynamic> getChannelsPaging(
      {@required String token, @required int page}) {
    return _channelProvider.getChannelsPaging(token: token, page: page);
  }
}
