import 'package:flutter/material.dart';

class JsonFieldTile extends StatefulWidget {
  const JsonFieldTile({
    super.key,
    required this.lvlOffset,
    required this.name,
    required this.value,
  });

  final int lvlOffset;
  final String name;
  final Object? value;

  @override
  State<JsonFieldTile> createState() => _JsonFieldTileState();
}

class _JsonFieldTileState extends State<JsonFieldTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: widget.lvlOffset * 8,
            ),
            Text(
              '${widget.name}:',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            if (expanded)
              GestureDetector(
                onTap: () {
                  setState(() {
                    expanded = false;
                  });
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
            if (widget.value is! Iterable && widget.value is! Map)
              Text(
                widget.value.toString(),
              ),
            if (!expanded && (widget.value is Iterable || widget.value is Map))
              GestureDetector(
                onTap: () {
                  setState(() {
                    expanded = true;
                  });
                },
                child: const Icon(Icons.arrow_forward_ios_outlined),
              ),
          ],
        ),
        if (widget.value is Iterable)
          expanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (widget.value as Iterable)
                      .map(
                        (e) => JsonFieldTile(
                          lvlOffset: widget.lvlOffset + 1,
                          name: '',
                          value: e as Object?,
                        ),
                      )
                      .toList(),
                )
              : const SizedBox()
        else if (widget.value is Map)
          expanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (widget.value as Map)
                      .entries
                      .map(
                        (entry) => JsonFieldTile(
                          lvlOffset: widget.lvlOffset + 1,
                          name: entry.key.toString(),
                          value: entry.value as Object?,
                        ),
                      )
                      .toList(),
                )
              : const SizedBox(),
      ],
    );
  }
}
