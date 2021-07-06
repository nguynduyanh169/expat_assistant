import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/channel_repository.dart';
import 'package:expat_assistant/src/states/channels_list_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class ChannelListCubit extends Cubit<ChannelListState> {
  ChannelRepository _channelRepository;
  final HiveUtils _hiveUtils = HiveUtils();


  ChannelListCubit(this._channelRepository)
      : super(const ChannelListState(status: ChannelListStatus.init));

  Future<void> getChannelsPaging(int page) async{
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isLoadingChannels) return null;
      final currentState = state;
      List<Channel> oldChannels = [];
      List<Channel> channels = [];
      if (currentState.status.isLoadChannelsSuccess) {
        oldChannels = state.channels;
      }
      emit(state.copyWith(
        status: ChannelListStatus.loadingChannels,
        oldChannels: oldChannels,
        isFirstFetch: page == 0,
      ));
      var result = await _channelRepository.getChannelsPaging(token: token, page: page);
      if (result == 204) {
        emit(state.copyWith(
            page: page, status: ChannelListStatus.loadChannelsSuccess, channels: oldChannels));
      } else {
        page++;
        final thisChannels = state.oldChannels;
        channels.addAll(thisChannels);
        channels.addAll(result);
        emit(state.copyWith(
            page: page, status: ChannelListStatus.loadChannelsSuccess, channels: channels));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: ChannelListStatus.loadChannelsFailed));
    }
  }
}
