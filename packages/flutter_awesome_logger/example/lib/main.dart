import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:example/main_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger_dio/flutter_awesome_logger_dio.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterLogSingleton().log(
        details.exception.toString(),
        logType: LogType.error,
        stackTrace: details.stack.toString(),
      );
    };

    PlatformDispatcher.instance.onError = (e, st) {
      FlutterLogSingleton().log(
        e.toString(),
        logType: LogType.error,
        stackTrace: st.toString(),
      );
      return true;
    };

    runApp(const MyApp());
  }, (error, stack) async {
    FlutterLogSingleton().log(
      error.toString(),
      logType: LogType.error,
      stackTrace: stack.toString(),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late HttpClient httpClient;
  late Dio dio;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initClients(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return QaScreenWidget(
            enabled: true,
            child: MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                useMaterial3: true,
              ),
              home: MainPage(
                client: httpClient,
                dio: dio,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Future<void> _initClients() async {
    await DioClientWrapperSingleton().init(Dio());
    await HttpWrapperSingleton().init(HttpClient());

    dio = DioClientWrapperSingleton().dio;
    httpClient = HttpWrapperSingleton().httpClient;
  }
}
