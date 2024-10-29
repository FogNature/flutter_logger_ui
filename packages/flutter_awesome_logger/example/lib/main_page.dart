import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.client,
    required this.dio,
  });

  final HttpClient client;
  final Dio dio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Qa screen example',
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Send http request'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Send http dio http request'),
          ),
          ElevatedButton(
            onPressed: () {
              throw Exception(
                'My exception',
              );
            },
            child: Text('Throw error'),
          ),
          ElevatedButton(
            onPressed: () {
              FlutterLogSingleton().log(
                'My custom log',
                logType: LogType.custom,
              );
            },
            child: Text('Add custom log'),
          ),
          // Todo implement manual bottom sheet opening in app.
          ElevatedButton(
            onPressed: () {},
            child: Text('Add custom log'),
          ),
        ],
      ),
    );
  }
}
