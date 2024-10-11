import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sensors_plus/sensors_plus.dart';

class QaScreenShakeDetector extends StatefulWidget {
  final double? threshold;
  final int? shakesCount;
  final int? shakesTimeInSeconds;
  final VoidCallback onShake;
  final Widget child;

  const QaScreenShakeDetector({
    super.key,
    this.threshold,
    this.shakesCount,
    this.shakesTimeInSeconds,
    required this.onShake,
    required this.child,
  });

  @override
  State<QaScreenShakeDetector> createState() => _QaScreenShakeDetectorState();
}

const double defaultThreshold = 13.0;
const int defaultShakesCount = 3;
const int defaultShakesCountInSeconds = 1;

class _QaScreenShakeDetectorState extends State<QaScreenShakeDetector> {
  late StreamSubscription _listener;
  final DateTime _startTime = DateTime.timestamp();

  @override
  void initState() {
    super.initState();
    _listener = userAccelerometerEventStream(
            samplingPeriod: SensorInterval.gameInterval)
        .map(
          (e) {
            final t = DateTime.timestamp().difference(_startTime);
            return XEvent(
              timestamp: t.inMilliseconds / 1000,
              x: e.x,
            );
          },
        )
        .where(
          (e) {
            return e.x.abs() > (widget.threshold ?? defaultThreshold);
          },
        )
        .bufferCount(2, 1)
        .where((e) => e[0].x * e[1].x < 0)
        .map((buf) => buf[1].timestamp)
        .bufferCount(widget.shakesCount ?? defaultShakesCount, 1)
        .where((buf) => buf[2] - buf[0] < 1)
        .throttleTime(
          Duration(
            seconds: widget.shakesTimeInSeconds ?? defaultShakesCountInSeconds,
          ),
        )
        .listen(
          (event) async {
            HapticFeedback.vibrate();
            widget.onShake();
          },
          cancelOnError: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  Future<void> dispose() async {
    await _listener.cancel();
    super.dispose();
  }
}

class XEvent {
  final double timestamp;
  final double x;

  XEvent({required this.timestamp, required this.x});

  @override
  String toString() {
    return '$timestamp $x';
  }
}
