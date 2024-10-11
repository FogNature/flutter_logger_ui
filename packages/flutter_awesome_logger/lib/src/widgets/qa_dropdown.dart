import 'package:flutter/material.dart';

class QaDropdown<T> extends StatelessWidget {
  const QaDropdown({
    super.key,
    required this.values,
    required this.titles,
    required this.selectedValue,
    required this.onSelected,
  });

  final List<T> values;
  final List<String> titles;
  final T selectedValue;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(BorderSide()),
        borderRadius: BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isDense: true,
          value: selectedValue,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          items: List.generate(
            values.length,
            (index) => DropdownMenuItem(
              value: values[index],
              child: Text(
                titles[index],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          onChanged: (value) {
            if (value != null) {
              onSelected(value);
            }
          },
        ),
      ),
    );
  }
}
