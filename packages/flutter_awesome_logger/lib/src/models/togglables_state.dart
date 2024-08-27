import 'package:flutter_awesome_logger/src/models/togglaeble.dart';

class ToggleableState {
  final List<Toggleable> switches;
  final List<String> selectedAliases;

  ToggleableState({
    required this.switches,
    required this.selectedAliases,
  });

  ToggleableState copyWith({
    List<Toggleable>? switches,
    List<String>? selectedAliases,
  }) =>
      ToggleableState(
        switches: switches ?? this.switches,
        selectedAliases: selectedAliases ?? this.selectedAliases,
      );

  @override
  bool operator ==(Object other) =>
      other is ToggleableState &&
      switches == other.switches &&
      selectedAliases == other.selectedAliases;

  @override
  int get hashCode => Object.hash(
        switches,
        selectedAliases,
      );

  bool selectedAlias(String alias) => selectedAliases.contains(alias);
}
