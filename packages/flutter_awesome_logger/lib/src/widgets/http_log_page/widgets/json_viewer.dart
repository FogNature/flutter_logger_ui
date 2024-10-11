import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/widgets/json_tree_node.dart';

class JsonViewer extends StatefulWidget {
  const JsonViewer({
    super.key,
    required this.title,
    required this.json,
  });

  final String title;
  final String? json;

  @override
  State<JsonViewer> createState() => _JsonViewerState();
}

class _JsonViewerState extends State<JsonViewer> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    if ((widget.json?.isEmpty ?? true) ||
        widget.json == '{}' ||
        widget.json == 'null') {
      return const SizedBox();
    }

    final json = _parseJson();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.transparent,
                child: Icon(
                  expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ),
            ),
          ],
        ),
        if (expanded && json is Map) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                    ClipboardData(
                      text: widget.json!,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: const Icon(
                    size: 20,
                    Icons.copy,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: JsonTreeNode(
              name: '',
              level: 0,
              json: json,
              initial: true,
            ),
          ),
        ],
        if (expanded && json is! Map) Text(widget.json!),
      ],
    );
  }

  dynamic _parseJson() {
    try {
      return jsonDecode(widget.json!) as Map<String, dynamic>;
    } catch (e) {
      return '';
    }
  }
}
