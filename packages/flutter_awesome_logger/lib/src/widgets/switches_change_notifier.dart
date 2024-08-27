import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/src/models/togglables_state.dart';

class SwitchesChangeNotifier extends ChangeNotifier {
  ToggleableState state;

  SwitchesChangeNotifier(
    this.state,
  );

  toggleAlias(String alias) {
    if (state.selectedAlias(alias)) {
      state = state.copyWith(
        selectedAliases:
            state.selectedAliases.where((element) => element != alias).toList(),
      );
    } else {
      state = state.copyWith(
        selectedAliases: [...state.selectedAliases, alias],
      );
    }
  }
}
