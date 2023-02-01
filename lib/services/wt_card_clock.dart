import "dart:async" show Timer;
import "package:event/event.dart";
import "package:get_it/get_it.dart";

class WtCardClockEventArgs extends EventArgs {
  final List<Duration> _durationsTicked;

  List<Duration> get durationsTicked {
    return _durationsTicked;
  }

  WtCardClockEventArgs(this._durationsTicked);

  bool hasDuration(Duration d) {
    return _durationsTicked
        .any((element) => element.inMilliseconds == d.inMilliseconds);
  }
}

enum WtCardClockInterval {
  thirtySeconds(Duration(seconds: 30)),
  oneMinute(Duration(minutes: 1)),
  twoMinutes(Duration(minutes: 2)),
  fiveMinutes(Duration(minutes: 5)),
  tenMinutes(Duration(minutes: 10)),
  twentyMinutes(Duration(minutes: 20));

  const WtCardClockInterval(this.duration);
  final Duration duration;
}

class WtCardClock extends Object with Disposable {
  late Timer _timer;

  static Event tick = Event();
  static final updateIntervals = [
    const Duration(minutes: 1),
    const Duration(minutes: 2),
    const Duration(minutes: 5),
    const Duration(minutes: 10),
    const Duration(minutes: 20),
  ];

  WtCardClock() {
    _timer = Timer.periodic(
        const Duration(seconds: 30), (Timer timer) => _broadcastEvent(timer));
  }

  void _broadcastEvent(Timer timer) {
    var durations = List.filled(1, const Duration(seconds: 30), growable: true);

    for (var duration in WtCardClock.updateIntervals) {
      _maybeAddTickDuration(durations, timer.tick, duration);
    }

    tick.broadcast(WtCardClockEventArgs(durations));
  }

  List<Duration> _maybeAddTickDuration(
      List<Duration> durations, int tick, Duration duration) {
    if (tick % Duration.secondsPerMinute == 0) {
      durations.add(duration);
    }

    return durations;
  }

  @override
  void onDispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }
}
