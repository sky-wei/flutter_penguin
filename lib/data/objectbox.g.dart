// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../data/entity/cmd_doc_entity.dart';
import '../data/entity/favorite_entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(3, 5916602684697381780),
      name: 'CmdDocEntity',
      lastPropertyId: const IdUid(4, 5002646147394138331),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8064277000671341481),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 6775798673295205565),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6129389975064532496),
            name: 'categoryId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5002646147394138331),
            name: 'data',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 1402759445973889211),
      name: 'FavoriteEntity',
      lastPropertyId: const IdUid(3, 4316170221460361919),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6726090628269770216),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 7721306451866264447),
            name: 'key',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4316170221460361919),
            name: 'type',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(4, 1402759445973889211),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [1784836972462674427, 8292288305236522292],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        3649562436524666651,
        3499981130355103639,
        5177399443308704310,
        3633223916338070959,
        2509643988517992050,
        5794431701180616516,
        4409612404047341116
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    CmdDocEntity: EntityDefinition<CmdDocEntity>(
        model: _entities[0],
        toOneRelations: (CmdDocEntity object) => [],
        toManyRelations: (CmdDocEntity object) => {},
        getId: (CmdDocEntity object) => object.id,
        setId: (CmdDocEntity object, int id) {
          object.id = id;
        },
        objectToFB: (CmdDocEntity object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final dataOffset = fbb.writeString(object.data);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addInt64(2, object.categoryId);
          fbb.addOffset(3, dataOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final categoryIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final dataParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final object =
              CmdDocEntity(idParam, nameParam, categoryIdParam, dataParam);

          return object;
        }),
    FavoriteEntity: EntityDefinition<FavoriteEntity>(
        model: _entities[1],
        toOneRelations: (FavoriteEntity object) => [],
        toManyRelations: (FavoriteEntity object) => {},
        getId: (FavoriteEntity object) => object.id,
        setId: (FavoriteEntity object, int id) {
          object.id = id;
        },
        objectToFB: (FavoriteEntity object, fb.Builder fbb) {
          final keyOffset = fbb.writeString(object.key);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, keyOffset);
          fbb.addInt64(2, object.type);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final keyParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final typeParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final object = FavoriteEntity(idParam, keyParam, typeParam);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [CmdDocEntity] entity fields to define ObjectBox queries.
class CmdDocEntity_ {
  /// see [CmdDocEntity.id]
  static final id =
      QueryIntegerProperty<CmdDocEntity>(_entities[0].properties[0]);

  /// see [CmdDocEntity.name]
  static final name =
      QueryStringProperty<CmdDocEntity>(_entities[0].properties[1]);

  /// see [CmdDocEntity.categoryId]
  static final categoryId =
      QueryIntegerProperty<CmdDocEntity>(_entities[0].properties[2]);

  /// see [CmdDocEntity.data]
  static final data =
      QueryStringProperty<CmdDocEntity>(_entities[0].properties[3]);
}

/// [FavoriteEntity] entity fields to define ObjectBox queries.
class FavoriteEntity_ {
  /// see [FavoriteEntity.id]
  static final id =
      QueryIntegerProperty<FavoriteEntity>(_entities[1].properties[0]);

  /// see [FavoriteEntity.key]
  static final key =
      QueryStringProperty<FavoriteEntity>(_entities[1].properties[1]);

  /// see [FavoriteEntity.type]
  static final type =
      QueryIntegerProperty<FavoriteEntity>(_entities[1].properties[2]);
}
