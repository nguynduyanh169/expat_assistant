import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/states/notifications_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:expat_assistant/src/utils/notification_utils.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  HiveUtils _hiveUtils = HiveUtils();
  NotificationsCubit()
      : super(const NotificationsState(status: NotificationsStatus.init));

  Future<void> getNotifications() async {
    emit(state.copyWith(
      status: NotificationsStatus.loading,
    ));
    try {
      List<Notifications> notifications = _hiveUtils.getNotifications();
      if (notifications == null) {
        emit(state.copyWith(
            status: NotificationsStatus.loadError,
            message: 'An error occurs while fetching notifications'));
      } else {
        NotificationUtils.clearNotification();
        emit(state.copyWith(
            status: NotificationsStatus.loaded, notiList: notifications.reversed.toList()));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: NotificationsStatus.loadError, message: e.toString()));
    }
  }
}
