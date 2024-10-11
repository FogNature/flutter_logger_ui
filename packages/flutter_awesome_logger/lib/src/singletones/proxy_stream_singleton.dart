import 'dart:async';

class ProxyStreamSingleton {
  late StreamController<String?> proxyStream;

  factory ProxyStreamSingleton() {
    return _instance;
  }

  static final ProxyStreamSingleton _instance =
      ProxyStreamSingleton._internal();

  ProxyStreamSingleton._internal() {
    proxyStream = StreamController<String?>.broadcast();
  }
}
