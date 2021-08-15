import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationUtils {
  static final ValueNotifier<int> notificationCounterValueNotifer =
      ValueNotifier(0);
  static Future<void> notificationHandler() async {
    OneSignal.shared.setAppId("0962ef23-5b94-41af-8b39-17c26c2546a3");
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
      HiveUtils _hive = HiveUtils();
      _hive.addNotifications(
          title: event.notification.title,
          subtitle: event.notification.rawPayload["alert"],
          sentDate: DateTime.fromMillisecondsSinceEpoch(
              event.notification.rawPayload["google.sent_time"]));
      notificationCounterValueNotifer.value++;
      notificationCounterValueNotifer.notifyListeners();
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});

    OneSignal.shared
        .setPermissionObserver((OSPermissionStateChanges changes) {});
  }

  static void pushNotification(String title, String content) async {
    String playerId = "";
    OneSignal.shared.getDeviceState().then((deviceState) {
      // print("OneSignal: device state: ${deviceState.jsonRepresentation()}");
      playerId = deviceState.userId;
      OneSignal.shared.postNotification(OSCreateNotification(
          playerIds: [playerId], content: content, heading: title));
    });
  }

  static void pushScheduleNotificaton(
      String title, String content, DateTime schedule) async {
    String playerId = "";
    OneSignal.shared.getDeviceState().then((deviceState) {
      playerId = deviceState.userId;
      OneSignal.shared.postNotification(OSCreateNotification(
          playerIds: [playerId],
          content: content,
          heading: title,
          sendAfter: schedule));
    });
  }

  static void clearNotification() async {
    OneSignal.shared.clearOneSignalNotifications().then((value) {
      notificationCounterValueNotifer.value = 0;
      notificationCounterValueNotifer.notifyListeners();
    });
  }
}
