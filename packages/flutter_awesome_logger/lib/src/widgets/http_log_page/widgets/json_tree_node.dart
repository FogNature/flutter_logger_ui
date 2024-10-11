import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum JsonType { list, map, value }

class JsonTreeNode extends StatefulWidget {
  const JsonTreeNode({
    super.key,
    required this.json,
    required this.name,
    required this.level,
    this.initial = false,
  });

  final Object? json;
  final String? name;
  final int level;
  final bool initial;

  @override
  State<JsonTreeNode> createState() => _JsonTreeNodeState();
}

class _JsonTreeNodeState extends State<JsonTreeNode> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.initial)
          Row(
            children: [
              SizedBox(
                width: widget.level * 4,
              ),
              if (widget.name?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '${widget.name}:',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              if (!expanded && (widget.json is Iterable || widget.json is Map))
                GestureDetector(
                  onTap: () {
                    setState(() {
                      expanded = true;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
              if (expanded)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      expanded = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.arrow_drop_up,
                    ),
                  ),
                ),
              if ((widget.json is! Iterable && widget.json is! Map) ||
                  !expanded)
                Text(
                  widget.json == null ? ' null' : ' ${widget.json.toString()}',
                ),
            ],
          ),
        if (widget.json is Iterable)
          expanded || widget.initial
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (widget.json as Iterable)
                      .mapIndexed(
                        (index, e) => JsonTreeNode(
                          level: widget.initial ? 0 : widget.level + 1,
                          name: '[$index]',
                          json: e as Object?,
                        ),
                      )
                      .toList(),
                )
              : const SizedBox()
        else if (widget.json is Map)
          expanded || widget.initial
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (widget.json as Map)
                      .entries
                      .map(
                        (entry) => JsonTreeNode(
                          level: widget.initial ? 0 : widget.level + 1,
                          name: entry.key.toString(),
                          json: entry.value as Object?,
                        ),
                      )
                      .toList(),
                )
              : const SizedBox(),
      ],
    );
  }
}
