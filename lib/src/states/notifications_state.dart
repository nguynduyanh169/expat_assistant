import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/hive_object.dart';

class NotificationsState extends Equatable {
  final List<Notifications> notiList;
  final NotificationsStatus status;
  final String message;

  const NotificationsState({this.message, this.notiList, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [notiList, status, message];

  NotificationsState copyWith(
      {List<Notifications> notiList,
      NotificationsStatus status,
      String message}) {
    return NotificationsState(
        message: message ?? this.message,
        status: status ?? this.status,
        notiList: notiList ?? this.notiList);
  }
}

enum NotificationsStatus {
  init,
  loading,
  loaded,
  loadError,
}

extension Explanation on NotificationsStatus {
  bool get isInit => this == NotificationsStatus.init;

  bool get isLoading => this == NotificationsStatus.loading;

  bool get isLoaded => this == NotificationsStatus.loaded;

  bool get isLoadError => this == NotificationsStatus.loadError;
}
