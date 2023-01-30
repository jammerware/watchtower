import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' show markdownToHtml;
import 'package:watchtower/models/wt_card.dart';

import '../../models/wt_card_data.dart';

class WtMarkdownCard extends WtCard<WtMarkdownCardData> {
  const WtMarkdownCard(super.name, super.initialData, super.updateEvery,
      {super.key});

  @override
  void update() {}

  @override
  State<WtMarkdownCard> createState() => _WtMarkdownCardState();
}

class _WtMarkdownCardState extends State<WtMarkdownCard> {
  @override
  Widget build(BuildContext buildContext) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Html(
          data: markdownToHtml(widget.initialData.markdown),
          tagsList: Html.tags,
        ));
  }
}

class WtMarkdownCardData extends WtCardData {
  final String markdown;

  WtMarkdownCardData(this.markdown);
}
