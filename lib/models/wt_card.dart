import 'package:flutter/material.dart';
import 'package:watchtower/models/wt_card_data.dart';
import 'package:watchtower/services/wt_card_clock.dart';

abstract class WtCard<T extends WtCardData> extends StatefulWidget {
  final String name;
  final T initialData;
  final WtCardClockInterval? updateEvery;

  const WtCard(this.name, this.initialData, this.updateEvery, {super.key});
  const WtCard.noUpdateEvery(this.name, this.initialData, {super.key})
      : updateEvery = null;

  void update();
}
