import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:watchtower/services/now_service.dart';
import 'package:watchtower/services/wt_card_clock.dart';
import 'package:watchtower/widgets/wt_cards/wt_countdown_card/wt_countdown.dart';
import 'package:watchtower/widgets/wt_cards/wt_countdown_card/wt_countdown_card.dart';
import 'package:watchtower/widgets/wt_cards/wt_markdown_card.dart';

import 'models/wt_card.dart';
import 'widgets/my_home_page.dart';

void buildIocContainer() {
  GetIt.I.registerSingleton<WtCardClock>(WtCardClock());
  GetIt.I.registerSingleton<NowService>(const NowService());
}

void main() {
  buildIocContainer();
  runApp(const WatchtowerApp());
}

class WatchtowerApp extends StatelessWidget {
  const WatchtowerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WatchtowerAppState(),
        child: MaterialApp(
          title: 'Watchtower',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.orange,
          ),
          home: const MyHomePage(title: 'Watchtower'),
        ));
  }
}

class WatchtowerAppState extends ChangeNotifier {
  final List<WtCard> _cards = [
    WtMarkdownCard(
      "My secret thoughts",
      WtMarkdownCardData("_These_ are my **secret thoughts**."),
      WtCardClockInterval.oneMinute,
      key: const Key("659eafd1-af0f-41ec-b869-d511f921f43e"),
    ),
    WtCountdownCard(
        "Countdown to everything",
        WtCountdownCardData(
          primaryCountdown: WtCountdown(
              description: "Destiny: Lightfall",
              date: DateTime(2023, DateTime.february, 28)),
          countdowns: [
            WtCountdown(
                date: DateTime(2023, DateTime.february, 7),
                description: "Phyrexia: All Will Be One"),
            WtCountdown(
                date: DateTime(2023, DateTime.april, 4),
                description: "Hogwarts Legacy (PS4/XB1)")
          ],
        ))
  ];

  List<WtCard> getCards() {
    return _cards;
  }
}
