// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RestauranteData extends DataClass implements Insertable<RestauranteData> {
  final int id;
  final String title;
  final String poster;
  RestauranteData(
      {required this.id, required this.title, required this.poster});
  factory RestauranteData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RestauranteData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      poster: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}poster'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['poster'] = Variable<String>(poster);
    return map;
  }

  RestauranteCompanion toCompanion(bool nullToAbsent) {
    return RestauranteCompanion(
      id: Value(id),
      title: Value(title),
      poster: Value(poster),
    );
  }

  factory RestauranteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestauranteData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      poster: serializer.fromJson<String>(json['poster']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'poster': serializer.toJson<String>(poster),
    };
  }

  RestauranteData copyWith({int? id, String? title, String? poster}) =>
      RestauranteData(
        id: id ?? this.id,
        title: title ?? this.title,
        poster: poster ?? this.poster,
      );
  @override
  String toString() {
    return (StringBuffer('RestauranteData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('poster: $poster')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, poster);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestauranteData &&
          other.id == this.id &&
          other.title == this.title &&
          other.poster == this.poster);
}

class RestauranteCompanion extends UpdateCompanion<RestauranteData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> poster;
  const RestauranteCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.poster = const Value.absent(),
  });
  RestauranteCompanion.insert({
    required int id,
    required String title,
    required String poster,
  })  : id = Value(id),
        title = Value(title),
        poster = Value(poster);
  static Insertable<RestauranteData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? poster,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (poster != null) 'poster': poster,
    });
  }

  RestauranteCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<String>? poster}) {
    return RestauranteCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      poster: poster ?? this.poster,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (poster.present) {
      map['poster'] = Variable<String>(poster.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestauranteCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('poster: $poster')
          ..write(')'))
        .toString();
  }
}

class $RestauranteTable extends Restaurante
    with TableInfo<$RestauranteTable, RestauranteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestauranteTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _posterMeta = const VerificationMeta('poster');
  @override
  late final GeneratedColumn<String?> poster = GeneratedColumn<String?>(
      'poster', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, poster];
  @override
  String get aliasedName => _alias ?? 'restaurante';
  @override
  String get actualTableName => 'restaurante';
  @override
  VerificationContext validateIntegrity(Insertable<RestauranteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('poster')) {
      context.handle(_posterMeta,
          poster.isAcceptableOrUnknown(data['poster']!, _posterMeta));
    } else if (isInserting) {
      context.missing(_posterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  RestauranteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return RestauranteData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RestauranteTable createAlias(String alias) {
    return $RestauranteTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $RestauranteTable restaurante = $RestauranteTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [restaurante];
}
