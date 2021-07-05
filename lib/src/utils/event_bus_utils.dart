import 'dart:async';

import 'package:event_bus/event_bus.dart';

class EventBusUtils {
  static EventBus instance;

  static EventBus getInstance() {
    if (null == instance) {
      instance = EventBus();
    }
    return instance;
  }
}

class JoinedInEvent {
  bool joinedIn;
  int eventId;

  JoinedInEvent(this.eventId, this.joinedIn);
}
