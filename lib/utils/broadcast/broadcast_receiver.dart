import 'dart:async';

class BroadcastReciever {
  static StreamController<String> broadcastController =
      StreamController<String>.broadcast();
}