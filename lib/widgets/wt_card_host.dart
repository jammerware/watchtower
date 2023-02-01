import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchtower/main.dart';

class WtCardHost extends StatefulWidget {
  final String title;
  const WtCardHost({super.key, required this.title});

  @override
  State<WtCardHost> createState() => _WtCardHostState();
}

class _WtCardHostState extends State<WtCardHost> {
  @override
  Widget build(BuildContext buildContext) {
    final appState = buildContext.watch<WatchtowerAppState>();

    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.spaceBetween,
      spacing: 12,
      runSpacing: 12,
      children: <Widget>[
        ...appState
            .getCards()
            .map((card) => Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: Theme.of(buildContext).primaryColorLight)),
                width: MediaQuery.of(buildContext).size.width / 3,
                child: card))
            .toList()
      ],
    );
  }
}
