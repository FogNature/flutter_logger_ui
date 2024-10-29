import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger_dio/flutter_awesome_logger_dio.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Qa screen example',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Send http request'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                DioClientWrapperSingleton().dio.get(
                      'https://jsonplaceholder.typicode.com/posts',
                    );
              },
              child: Text('Send http dio http request'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                throw Exception(
                  'My exception',
                );
              },
              child: Text('Throw error'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                FlutterLogSingleton().log(
                  'My custom log',
                  logType: LogType.custom,
                );
              },
              child: Text('Add custom log'),
            ),
          ),
        ],
      ),
    );
  }
}
