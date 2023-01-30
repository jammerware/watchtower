import 'package:watchtower/models/wt_card_data.dart';

class WtCardUpdateContext<T extends WtCardData> {
  final DateTime now;
  final T cardData;

  WtCardUpdateContext(this.now, this.cardData);
}
