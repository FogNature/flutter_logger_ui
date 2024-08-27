import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/src/models/logger_settings.dart';
import 'package:flutter_awesome_logger/src/models/togglables_state.dart';
import 'package:flutter_awesome_logger/src/models/togglaeble.dart';
import 'package:flutter_awesome_logger/src/widgets/switches_change_notifier.dart';

typedef SettingsBuilder = Widget Function(
  BuildContext context,
  ToggleableState toggles,
);

class FlutterAwesomeLogger extends StatefulWidget {
  const FlutterAwesomeLogger({
    super.key,
    required this.settings,
    required this.toggles,
    required this.builder,
  });

  final LoggerSettings? settings;
  final SettingsBuilder builder;
  final ToggleableState? toggles;

  @override
  State<FlutterAwesomeLogger> createState() => _FlutterAwesomeLoggerState();
}

class _FlutterAwesomeLoggerState extends State<FlutterAwesomeLogger> {
  late SwitchesChangeNotifier switchesNotifier;

  @override
  void initState() {
    switchesNotifier = SwitchesChangeNotifier(
      widget.toggles ?? _defaultToggles,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.toggles != null) {
      switchesNotifier = SwitchesChangeNotifier(widget.toggles!);
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FlutterAwesomeLogger oldWidget) {
    if (widget.toggles != null) {
      switchesNotifier = SwitchesChangeNotifier(widget.toggles!);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: switchesNotifier,
      builder: (context, _) => widget.builder(
        context,
        switchesNotifier.state,
      ),
    );
  }

  /*
  /// This is required widget for navigator
  Localizations(
      locale: const Locale('en'),
      delegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      child: Navigator(
        onPopPage: (_, __) => false,
        pages: [
          const MaterialPage(
            /// Logger bottom sheet
            child: SizedBox(),
          ),
          MaterialPage(
            child: PopScope(
              canPop: false,
              // Maybe should close app instead of popping.
              onPopInvoked: (_) => false,
              child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                ),
                localizationsDelegates: const [
                  DefaultMaterialLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                ],
                home: const MyHomePage(
                  title: 'Flutter Demo Home Page',
                ),
              ),
            ),
          ),
        ],
      ),
    )
   */
}

final _defaultToggles = ToggleableState(
  switches: [
    Toggleable(
      title: 'Show material grid',
      description: 'Allows to see elements position',
      alias: 'grid',
    ),
    Toggleable(
      title: 'Show performance overlay',
      description: 'Allows to see app performance',
      alias: 'performance_overlay',
    ),
    Toggleable(
      title: 'Show repaints',
      description: 'Show repaints of the widgets',
      alias: 'repaints',
    ),
    Toggleable(
      title: 'Show element sizes',
      description: 'Show sizes of elements',
      alias: 'element_sizes',
    ),
  ],
  selectedAliases: [],
);
