import 'package:flutter/material.dart';
import 'package:watchtower/models/wt_card.dart';
import 'package:watchtower/widgets/wt_cards/wt_countdown_card/wt_countdown.dart';
import 'package:watchtower/widgets/wt_cards/wt_countdown_card/wt_countdown_clock.dart';
import 'package:watchtower/models/wt_card_data.dart';

class WtCountdownCard extends WtCard<WtCountdownCardData> {
  const WtCountdownCard(name, initialData, {super.key})
      : super.noUpdateEvery(name, initialData);

  @override
  void update() {}

  @override
  State<WtCountdownCard> createState() => _WtCountdownCardState();
}

class _WtCountdownCardState extends State<WtCountdownCard> {
  @override
  Widget build(BuildContext buildContext) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.initialData.primaryCountdown != null)
                WtCountdownClock(
                    countdownTil: widget.initialData.primaryCountdown!,
                    isBig: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  ...widget.initialData.countdowns
                      .map((countdown) => Expanded(
                          child: WtCountdownClock(countdownTil: countdown)))
                      .toList()
                ],
              )
            ]));
  }
}

class WtCountdownCardData extends WtCardData {
  final WtCountdown? primaryCountdown;
  final List<WtCountdown> countdowns;

  WtCountdownCardData({required this.countdowns, this.primaryCountdown});
}
