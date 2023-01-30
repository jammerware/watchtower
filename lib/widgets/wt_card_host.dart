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

    return Wrap(spacing: 8, runSpacing: 4, children: appState.getCards());
  }
}
