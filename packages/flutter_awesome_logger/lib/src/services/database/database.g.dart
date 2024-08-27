// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LoggerDataClassTable extends LoggerDataClass
    with TableInfo<$LoggerDataClassTable, LogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoggerDataClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _logLeverMeta =
      const VerificationMeta('logLever');
  @override
  late final GeneratedColumn<int> logLever = GeneratedColumn<int>(
      'log_lever', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _infoMeta = const VerificationMeta('info');
  @override
  late final GeneratedColumn<String> info = GeneratedColumn<String>(
      'info', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, logLever, createdAt, tag, info];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs';
  @override
  VerificationContext validateIntegrity(Insertable<LogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('log_lever')) {
      context.handle(_logLeverMeta,
          logLever.isAcceptableOrUnknown(data['log_lever']!, _logLeverMeta));
    } else if (isInserting) {
      context.missing(_logLeverMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (data.containsKey('info')) {
      context.handle(
          _infoMeta, info.isAcceptableOrUnknown(data['info']!, _infoMeta));
    } else if (isInserting) {
      context.missing(_infoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      logLever: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}log_lever'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
      info: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}info'])!,
    );
  }

  @override
  $LoggerDataClassTable createAlias(String alias) {
    return $LoggerDataClassTable(attachedDatabase, alias);
  }
}

class LogData extends DataClass implements Insertable<LogData> {
  final int id;
  final int logLever;
  final DateTime createdAt;
  final String tag;
  final String info;
  const LogData(
      {required this.id,
      required this.logLever,
      required this.createdAt,
      required this.tag,
      required this.info});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['log_lever'] = Variable<int>(logLever);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['tag'] = Variable<String>(tag);
    map['info'] = Variable<String>(info);
    return map;
  }

  LoggerDataClassCompanion toCompanion(bool nullToAbsent) {
    return LoggerDataClassCompanion(
      id: Value(id),
      logLever: Value(logLever),
      createdAt: Value(createdAt),
      tag: Value(tag),
      info: Value(info),
    );
  }

  factory LogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogData(
      id: serializer.fromJson<int>(json['id']),
      logLever: serializer.fromJson<int>(json['logLever']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      tag: serializer.fromJson<String>(json['tag']),
      info: serializer.fromJson<String>(json['info']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'logLever': serializer.toJson<int>(logLever),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'tag': serializer.toJson<String>(tag),
      'info': serializer.toJson<String>(info),
    };
  }

  LogData copyWith(
          {int? id,
          int? logLever,
          DateTime? createdAt,
          String? tag,
          String? info}) =>
      LogData(
        id: id ?? this.id,
        logLever: logLever ?? this.logLever,
        createdAt: createdAt ?? this.createdAt,
        tag: tag ?? this.tag,
        info: info ?? this.info,
      );
  LogData copyWithCompanion(LoggerDataClassCompanion data) {
    return LogData(
      id: data.id.present ? data.id.value : this.id,
      logLever: data.logLever.present ? data.logLever.value : this.logLever,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      tag: data.tag.present ? data.tag.value : this.tag,
      info: data.info.present ? data.info.value : this.info,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogData(')
          ..write('id: $id, ')
          ..write('logLever: $logLever, ')
          ..write('createdAt: $createdAt, ')
          ..write('tag: $tag, ')
          ..write('info: $info')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, logLever, createdAt, tag, info);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogData &&
          other.id == this.id &&
          other.logLever == this.logLever &&
          other.createdAt == this.createdAt &&
          other.tag == this.tag &&
          other.info == this.info);
}

class LoggerDataClassCompanion extends UpdateCompanion<LogData> {
  final Value<int> id;
  final Value<int> logLever;
  final Value<DateTime> createdAt;
  final Value<String> tag;
  final Value<String> info;
  const LoggerDataClassCompanion({
    this.id = const Value.absent(),
    this.logLever = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.tag = const Value.absent(),
    this.info = const Value.absent(),
  });
  LoggerDataClassCompanion.insert({
    this.id = const Value.absent(),
    required int logLever,
    required DateTime createdAt,
    required String tag,
    required String info,
  })  : logLever = Value(logLever),
        createdAt = Value(createdAt),
        tag = Value(tag),
        info = Value(info);
  static Insertable<LogData> custom({
    Expression<int>? id,
    Expression<int>? logLever,
    Expression<DateTime>? createdAt,
    Expression<String>? tag,
    Expression<String>? info,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (logLever != null) 'log_lever': logLever,
      if (createdAt != null) 'created_at': createdAt,
      if (tag != null) 'tag': tag,
      if (info != null) 'info': info,
    });
  }

  LoggerDataClassCompanion copyWith(
      {Value<int>? id,
      Value<int>? logLever,
      Value<DateTime>? createdAt,
      Value<String>? tag,
      Value<String>? info}) {
    return LoggerDataClassCompanion(
      id: id ?? this.id,
      logLever: logLever ?? this.logLever,
      createdAt: createdAt ?? this.createdAt,
      tag: tag ?? this.tag,
      info: info ?? this.info,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (logLever.present) {
      map['log_lever'] = Variable<int>(logLever.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (info.present) {
      map['info'] = Variable<String>(info.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoggerDataClassCompanion(')
          ..write('id: $id, ')
          ..write('logLever: $logLever, ')
          ..write('createdAt: $createdAt, ')
          ..write('tag: $tag, ')
          ..write('info: $info')
          ..write(')'))
        .toString();
  }
}

class $HttpLoggerDataClassTable extends HttpLoggerDataClass
    with TableInfo<$HttpLoggerDataClassTable, HttpLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HttpLoggerDataClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _headersMeta =
      const VerificationMeta('headers');
  @override
  late final GeneratedColumn<String> headers = GeneratedColumn<String>(
      'headers', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
      'query', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _responseMeta =
      const VerificationMeta('response');
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
      'response', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        method,
        path,
        status,
        body,
        headers,
        query,
        response,
        error,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'httpLogs';
  @override
  VerificationContext validateIntegrity(Insertable<HttpLogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    }
    if (data.containsKey('headers')) {
      context.handle(_headersMeta,
          headers.isAcceptableOrUnknown(data['headers']!, _headersMeta));
    } else if (isInserting) {
      context.missing(_headersMeta);
    }
    if (data.containsKey('query')) {
      context.handle(
          _queryMeta, query.isAcceptableOrUnknown(data['query']!, _queryMeta));
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('response')) {
      context.handle(_responseMeta,
          response.isAcceptableOrUnknown(data['response']!, _responseMeta));
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HttpLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HttpLogData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status']),
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body']),
      headers: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}headers'])!,
      query: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query'])!,
      response: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response']),
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HttpLoggerDataClassTable createAlias(String alias) {
    return $HttpLoggerDataClassTable(attachedDatabase, alias);
  }
}

class HttpLogData extends DataClass implements Insertable<HttpLogData> {
  final int id;
  final String method;
  final String path;
  final int? status;
  final String? body;
  final String headers;
  final String query;
  final String? response;
  final String? error;
  final DateTime createdAt;
  const HttpLogData(
      {required this.id,
      required this.method,
      required this.path,
      this.status,
      this.body,
      required this.headers,
      required this.query,
      this.response,
      this.error,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['method'] = Variable<String>(method);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<int>(status);
    }
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    map['headers'] = Variable<String>(headers);
    map['query'] = Variable<String>(query);
    if (!nullToAbsent || response != null) {
      map['response'] = Variable<String>(response);
    }
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HttpLoggerDataClassCompanion toCompanion(bool nullToAbsent) {
    return HttpLoggerDataClassCompanion(
      id: Value(id),
      method: Value(method),
      path: Value(path),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      headers: Value(headers),
      query: Value(query),
      response: response == null && nullToAbsent
          ? const Value.absent()
          : Value(response),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
      createdAt: Value(createdAt),
    );
  }

  factory HttpLogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HttpLogData(
      id: serializer.fromJson<int>(json['id']),
      method: serializer.fromJson<String>(json['method']),
      path: serializer.fromJson<String>(json['path']),
      status: serializer.fromJson<int?>(json['status']),
      body: serializer.fromJson<String?>(json['body']),
      headers: serializer.fromJson<String>(json['headers']),
      query: serializer.fromJson<String>(json['query']),
      response: serializer.fromJson<String?>(json['response']),
      error: serializer.fromJson<String?>(json['error']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'method': serializer.toJson<String>(method),
      'path': serializer.toJson<String>(path),
      'status': serializer.toJson<int?>(status),
      'body': serializer.toJson<String?>(body),
      'headers': serializer.toJson<String>(headers),
      'query': serializer.toJson<String>(query),
      'response': serializer.toJson<String?>(response),
      'error': serializer.toJson<String?>(error),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HttpLogData copyWith(
          {int? id,
          String? method,
          String? path,
          Value<int?> status = const Value.absent(),
          Value<String?> body = const Value.absent(),
          String? headers,
          String? query,
          Value<String?> response = const Value.absent(),
          Value<String?> error = const Value.absent(),
          DateTime? createdAt}) =>
      HttpLogData(
        id: id ?? this.id,
        method: method ?? this.method,
        path: path ?? this.path,
        status: status.present ? status.value : this.status,
        body: body.present ? body.value : this.body,
        headers: headers ?? this.headers,
        query: query ?? this.query,
        response: response.present ? response.value : this.response,
        error: error.present ? error.value : this.error,
        createdAt: createdAt ?? this.createdAt,
      );
  HttpLogData copyWithCompanion(HttpLoggerDataClassCompanion data) {
    return HttpLogData(
      id: data.id.present ? data.id.value : this.id,
      method: data.method.present ? data.method.value : this.method,
      path: data.path.present ? data.path.value : this.path,
      status: data.status.present ? data.status.value : this.status,
      body: data.body.present ? data.body.value : this.body,
      headers: data.headers.present ? data.headers.value : this.headers,
      query: data.query.present ? data.query.value : this.query,
      response: data.response.present ? data.response.value : this.response,
      error: data.error.present ? data.error.value : this.error,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HttpLogData(')
          ..write('id: $id, ')
          ..write('method: $method, ')
          ..write('path: $path, ')
          ..write('status: $status, ')
          ..write('body: $body, ')
          ..write('headers: $headers, ')
          ..write('query: $query, ')
          ..write('response: $response, ')
          ..write('error: $error, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, method, path, status, body, headers,
      query, response, error, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HttpLogData &&
          other.id == this.id &&
          other.method == this.method &&
          other.path == this.path &&
          other.status == this.status &&
          other.body == this.body &&
          other.headers == this.headers &&
          other.query == this.query &&
          other.response == this.response &&
          other.error == this.error &&
          other.createdAt == this.createdAt);
}

class HttpLoggerDataClassCompanion extends UpdateCompanion<HttpLogData> {
  final Value<int> id;
  final Value<String> method;
  final Value<String> path;
  final Value<int?> status;
  final Value<String?> body;
  final Value<String> headers;
  final Value<String> query;
  final Value<String?> response;
  final Value<String?> error;
  final Value<DateTime> createdAt;
  const HttpLoggerDataClassCompanion({
    this.id = const Value.absent(),
    this.method = const Value.absent(),
    this.path = const Value.absent(),
    this.status = const Value.absent(),
    this.body = const Value.absent(),
    this.headers = const Value.absent(),
    this.query = const Value.absent(),
    this.response = const Value.absent(),
    this.error = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HttpLoggerDataClassCompanion.insert({
    this.id = const Value.absent(),
    required String method,
    required String path,
    this.status = const Value.absent(),
    this.body = const Value.absent(),
    required String headers,
    required String query,
    this.response = const Value.absent(),
    this.error = const Value.absent(),
    required DateTime createdAt,
  })  : method = Value(method),
        path = Value(path),
        headers = Value(headers),
        query = Value(query),
        createdAt = Value(createdAt);
  static Insertable<HttpLogData> custom({
    Expression<int>? id,
    Expression<String>? method,
    Expression<String>? path,
    Expression<int>? status,
    Expression<String>? body,
    Expression<String>? headers,
    Expression<String>? query,
    Expression<String>? response,
    Expression<String>? error,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (method != null) 'method': method,
      if (path != null) 'path': path,
      if (status != null) 'status': status,
      if (body != null) 'body': body,
      if (headers != null) 'headers': headers,
      if (query != null) 'query': query,
      if (response != null) 'response': response,
      if (error != null) 'error': error,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HttpLoggerDataClassCompanion copyWith(
      {Value<int>? id,
      Value<String>? method,
      Value<String>? path,
      Value<int?>? status,
      Value<String?>? body,
      Value<String>? headers,
      Value<String>? query,
      Value<String?>? response,
      Value<String?>? error,
      Value<DateTime>? createdAt}) {
    return HttpLoggerDataClassCompanion(
      id: id ?? this.id,
      method: method ?? this.method,
      path: path ?? this.path,
      status: status ?? this.status,
      body: body ?? this.body,
      headers: headers ?? this.headers,
      query: query ?? this.query,
      response: response ?? this.response,
      error: error ?? this.error,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (headers.present) {
      map['headers'] = Variable<String>(headers.value);
    }
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HttpLoggerDataClassCompanion(')
          ..write('id: $id, ')
          ..write('method: $method, ')
          ..write('path: $path, ')
          ..write('status: $status, ')
          ..write('body: $body, ')
          ..write('headers: $headers, ')
          ..write('query: $query, ')
          ..write('response: $response, ')
          ..write('error: $error, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$PackageDatabase extends GeneratedDatabase {
  _$PackageDatabase(QueryExecutor e) : super(e);
  $PackageDatabaseManager get managers => $PackageDatabaseManager(this);
  late final $LoggerDataClassTable loggerDataClass =
      $LoggerDataClassTable(this);
  late final $HttpLoggerDataClassTable httpLoggerDataClass =
      $HttpLoggerDataClassTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [loggerDataClass, httpLoggerDataClass];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$LoggerDataClassTableCreateCompanionBuilder = LoggerDataClassCompanion
    Function({
  Value<int> id,
  required int logLever,
  required DateTime createdAt,
  required String tag,
  required String info,
});
typedef $$LoggerDataClassTableUpdateCompanionBuilder = LoggerDataClassCompanion
    Function({
  Value<int> id,
  Value<int> logLever,
  Value<DateTime> createdAt,
  Value<String> tag,
  Value<String> info,
});

class $$LoggerDataClassTableTableManager extends RootTableManager<
    _$PackageDatabase,
    $LoggerDataClassTable,
    LogData,
    $$LoggerDataClassTableFilterComposer,
    $$LoggerDataClassTableOrderingComposer,
    $$LoggerDataClassTableCreateCompanionBuilder,
    $$LoggerDataClassTableUpdateCompanionBuilder> {
  $$LoggerDataClassTableTableManager(
      _$PackageDatabase db, $LoggerDataClassTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LoggerDataClassTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LoggerDataClassTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> logLever = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> tag = const Value.absent(),
            Value<String> info = const Value.absent(),
          }) =>
              LoggerDataClassCompanion(
            id: id,
            logLever: logLever,
            createdAt: createdAt,
            tag: tag,
            info: info,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int logLever,
            required DateTime createdAt,
            required String tag,
            required String info,
          }) =>
              LoggerDataClassCompanion.insert(
            id: id,
            logLever: logLever,
            createdAt: createdAt,
            tag: tag,
            info: info,
          ),
        ));
}

class $$LoggerDataClassTableFilterComposer
    extends FilterComposer<_$PackageDatabase, $LoggerDataClassTable> {
  $$LoggerDataClassTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get logLever => $state.composableBuilder(
      column: $state.table.logLever,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tag => $state.composableBuilder(
      column: $state.table.tag,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get info => $state.composableBuilder(
      column: $state.table.info,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LoggerDataClassTableOrderingComposer
    extends OrderingComposer<_$PackageDatabase, $LoggerDataClassTable> {
  $$LoggerDataClassTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get logLever => $state.composableBuilder(
      column: $state.table.logLever,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tag => $state.composableBuilder(
      column: $state.table.tag,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get info => $state.composableBuilder(
      column: $state.table.info,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$HttpLoggerDataClassTableCreateCompanionBuilder
    = HttpLoggerDataClassCompanion Function({
  Value<int> id,
  required String method,
  required String path,
  Value<int?> status,
  Value<String?> body,
  required String headers,
  required String query,
  Value<String?> response,
  Value<String?> error,
  required DateTime createdAt,
});
typedef $$HttpLoggerDataClassTableUpdateCompanionBuilder
    = HttpLoggerDataClassCompanion Function({
  Value<int> id,
  Value<String> method,
  Value<String> path,
  Value<int?> status,
  Value<String?> body,
  Value<String> headers,
  Value<String> query,
  Value<String?> response,
  Value<String?> error,
  Value<DateTime> createdAt,
});

class $$HttpLoggerDataClassTableTableManager extends RootTableManager<
    _$PackageDatabase,
    $HttpLoggerDataClassTable,
    HttpLogData,
    $$HttpLoggerDataClassTableFilterComposer,
    $$HttpLoggerDataClassTableOrderingComposer,
    $$HttpLoggerDataClassTableCreateCompanionBuilder,
    $$HttpLoggerDataClassTableUpdateCompanionBuilder> {
  $$HttpLoggerDataClassTableTableManager(
      _$PackageDatabase db, $HttpLoggerDataClassTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$HttpLoggerDataClassTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$HttpLoggerDataClassTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int?> status = const Value.absent(),
            Value<String?> body = const Value.absent(),
            Value<String> headers = const Value.absent(),
            Value<String> query = const Value.absent(),
            Value<String?> response = const Value.absent(),
            Value<String?> error = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HttpLoggerDataClassCompanion(
            id: id,
            method: method,
            path: path,
            status: status,
            body: body,
            headers: headers,
            query: query,
            response: response,
            error: error,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String method,
            required String path,
            Value<int?> status = const Value.absent(),
            Value<String?> body = const Value.absent(),
            required String headers,
            required String query,
            Value<String?> response = const Value.absent(),
            Value<String?> error = const Value.absent(),
            required DateTime createdAt,
          }) =>
              HttpLoggerDataClassCompanion.insert(
            id: id,
            method: method,
            path: path,
            status: status,
            body: body,
            headers: headers,
            query: query,
            response: response,
            error: error,
            createdAt: createdAt,
          ),
        ));
}

class $$HttpLoggerDataClassTableFilterComposer
    extends FilterComposer<_$PackageDatabase, $HttpLoggerDataClassTable> {
  $$HttpLoggerDataClassTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get method => $state.composableBuilder(
      column: $state.table.method,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get path => $state.composableBuilder(
      column: $state.table.path,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get body => $state.composableBuilder(
      column: $state.table.body,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get headers => $state.composableBuilder(
      column: $state.table.headers,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get query => $state.composableBuilder(
      column: $state.table.query,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get response => $state.composableBuilder(
      column: $state.table.response,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get error => $state.composableBuilder(
      column: $state.table.error,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$HttpLoggerDataClassTableOrderingComposer
    extends OrderingComposer<_$PackageDatabase, $HttpLoggerDataClassTable> {
  $$HttpLoggerDataClassTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get method => $state.composableBuilder(
      column: $state.table.method,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get path => $state.composableBuilder(
      column: $state.table.path,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get body => $state.composableBuilder(
      column: $state.table.body,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get headers => $state.composableBuilder(
      column: $state.table.headers,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get query => $state.composableBuilder(
      column: $state.table.query,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get response => $state.composableBuilder(
      column: $state.table.response,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get error => $state.composableBuilder(
      column: $state.table.error,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $PackageDatabaseManager {
  final _$PackageDatabase _db;
  $PackageDatabaseManager(this._db);
  $$LoggerDataClassTableTableManager get loggerDataClass =>
      $$LoggerDataClassTableTableManager(_db, _db.loggerDataClass);
  $$HttpLoggerDataClassTableTableManager get httpLoggerDataClass =>
      $$HttpLoggerDataClassTableTableManager(_db, _db.httpLoggerDataClass);
}
