import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:example/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger_dio/flutter_awesome_logger_dio.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initClients();
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return QaScreenWidget(
      enabled: true,
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: MainPage(),
      ),
    );
  }
}

Future<void> _initClients() async {
  await DioClientWrapperSingleton().init(Dio());
  await HttpWrapperSingleton().init(HttpClient());

  DioClientWrapperSingleton().dio;
  HttpWrapperSingleton().httpClient;
}
