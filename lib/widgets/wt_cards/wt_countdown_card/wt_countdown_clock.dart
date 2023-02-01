import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:watchtower/services/now_service.dart';
import 'package:watchtower/widgets/wt_cards/wt_countdown_card/wt_countdown.dart';

class WtCountdownClock extends StatefulWidget {
  final WtCountdown countdownTil;
  final bool isBig;

  const WtCountdownClock(
      {required this.countdownTil, this.isBig = false, super.key});

  @override
  State<WtCountdownClock> createState() => _WtCountdownClockState();
}

class _WtCountdownClockState extends State<WtCountdownClock> {
  final NowService nowService = GetIt.I.get<NowService>();
  late Timer _timer;
  Duration _timeRemaining = Duration.zero;

  _WtCountdownClockState() {
    _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => setState(() {
              _timeRemaining = _calcTimeRemaining(
                  nowService.getNow(), widget.countdownTil.date);
            }));
  }

  Duration _calcTimeRemaining(DateTime now, DateTime target) {
    if (target.isBefore(now)) {
      return const Duration(days: 0);
    }

    return target.difference(now);
  }

  Map<String, int> _formatDuration(Duration d) {
    return {
      "days": d.inDays,
      "hours": d.inHours.remainder(24),
      "minutes": d.inMinutes.remainder(60),
      "seconds": d.inSeconds.remainder(60)
    };
  }

  _abbreviateUnit(String unit) {
    switch (unit) {
      case "days":
        return "days";
      case "hours":
        return "hr";
      case "minutes":
        return "min";
      default:
        return "sec";
    }
    ;
  }

  @override
  void dispose() {
    super.dispose();

    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    final formattedDuration = _formatDuration(_timeRemaining);
    final description = widget.countdownTil.description;
    final colonStyle = widget.isBig
        ? Theme.of(context).textTheme.displaySmall!
        : Theme.of(context).textTheme.headlineSmall;

    final thingy = Padding(
        padding: const EdgeInsets.all(8),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(widget.countdownTil.description,
              style: widget.isBig
                  ? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  : const TextStyle(fontSize: 14)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                  child: WtCountdownClockUnit(
                      description: description,
                      count: formattedDuration["days"]!,
                      units: widget.isBig ? "days" : _abbreviateUnit("days"),
                      isBig: widget.isBig)),
              Text(":", style: colonStyle),
              Expanded(
                  child: WtCountdownClockUnit(
                      description: description,
                      count: formattedDuration["hours"]!,
                      units: widget.isBig ? "hours" : _abbreviateUnit("hours"),
                      isBig: widget.isBig)),
              Text(":", style: colonStyle),
              Expanded(
                  child: WtCountdownClockUnit(
                      description: description,
                      count: formattedDuration["minutes"]!,
                      units: widget.isBig ? "minutes" : "min",
                      isBig: widget.isBig)),
              Text(":", style: colonStyle),
              Expanded(
                  child: WtCountdownClockUnit(
                      description: description,
                      count: formattedDuration["seconds"]!,
                      units: widget.isBig ? "seconds" : "sec",
                      isBig: widget.isBig)),
            ],
          )
        ]));

    return thingy;
  }
}

class WtCountdownClockUnit extends StatelessWidget {
  final int count;
  final String units;
  final String description;
  final bool isBig;

  const WtCountdownClockUnit(
      {required this.description,
      required this.count,
      required this.units,
      this.isBig = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle unitTextStyle = isBig
        ? Theme.of(context).textTheme.bodyMedium!
        : TextStyle(fontSize: 11, color: Theme.of(context).hintColor);

    final TextStyle countTextStyle = isBig
        ? Theme.of(context).textTheme.displayMedium!
        : Theme.of(context).textTheme.headlineSmall!;

    return Container(
        padding: const EdgeInsets.all(4),
        width: 28,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(count.toString().padLeft(2), style: countTextStyle),
            Text(units, style: unitTextStyle)
          ],
        ));
  }
}
