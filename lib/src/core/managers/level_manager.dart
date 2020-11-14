import 'package:dartemis/dartemis.dart';

import '../../components/components.dart';

part 'level_manager.g.dart';

@Generate(
  Manager,
  mapper: [
    CanBeRolledOn,
    CanRoll,
    CanFall,
  ],
)
class LevelManager extends _$LevelManager {
  Level _level;
  final Map<int, LevelField> _entities = {};

  bool get levelLoaded => _level != null;

  // ignore: avoid_setters_without_getters
  set level(Level level) {
    _level = level;
    for (var x = 0; x < level.currentGrid.length; x++) {
      for (var y = 0; y < level.currentGrid[x].length; y++) {
        final field = level.currentGrid[x][y];
        _entities[field.entity] = field;
      }
    }
  }

  @override
  void deleted(int entity) {
    final field = _entities.remove(entity);
    if (field != null && field.entity == entity) {
      field
        ..object = LevelObject.empty
        ..entity = null;
    }
  }

  PlayerState playerStateForMove(int x, int y, int moveX, int moveY) {
    final field = _level.currentGrid[x + moveX][y + moveY];
    switch (field.object) {
      case LevelObject.empty:
      case LevelObject.atlas:
      case LevelObject.end:
      case LevelObject.ghost:
        return PlayerState.move;
      case LevelObject.nebula:
      case LevelObject.bean:
        return PlayerState.eat;
      case LevelObject.border:
      case LevelObject.star:
        return PlayerState.stay;
      case LevelObject.world:
        if (moveX != 0) {
          if (isBlockedForWorld(x + moveX, y + moveY, moveX, moveY)) {
            return PlayerState.stay;
          }
          return PlayerState.push;
        }
        return PlayerState.stay;
    }
    throw Exception('field@${field.x}:${field.y} is null');
  }

  bool isBlockedForWorld(int x, int y, int deltaX, int deltaY) {
    final field = _level.currentGrid[x + deltaX][y + deltaY];
    switch (field.object) {
      case LevelObject.empty:
      case LevelObject.atlas:
      case LevelObject.ghost:
        return false;
      case LevelObject.nebula:
      case LevelObject.border:
      case LevelObject.end:
      case LevelObject.world:
      case LevelObject.star:
      case LevelObject.bean:
        return true;
    }
    throw Exception('field@${field.x}:${field.y} is null');
  }

  void eat(int x, int y, int moveX, int moveY) {
    final field = _level.currentGrid[x + moveX][y + moveY];
    world.deleteEntity(field.entity);
  }

  bool canFall(int entity, int x, int y, {bool isFalling}) {
    if (!isFalling) {
      if (entity != null) {
        final canRoll = canRollMapper.getSafe(entity);
        if (canRoll != null && canRoll.rolling) {
          return false;
        }
      }
    }
    final field = _level.currentGrid[x][y + 1];
    switch (field.object) {
      case LevelObject.empty:
        return true;
      case LevelObject.atlas:
      case LevelObject.ghost:
        if (isFalling) {
          return true;
        }
        return false;
      case LevelObject.nebula:
      case LevelObject.border:
      case LevelObject.end:
      case LevelObject.world:
      case LevelObject.star:
      case LevelObject.bean:
        return false;
    }
    throw Exception('field@${field.x}:${field.y} is null');
  }

  bool canRoll(int entity, int x, int y, int rollX) {
    if (entity != null) {
      final canFall = canFallMapper.getSafe(entity);
      if (canFall != null && canFall.falling) {
        return false;
      }
    }
    final fieldBelow = _level.currentGrid[x][y + 1];
    if (fieldBelow.entity != null &&
        canBeRolledOnMapper.has(fieldBelow.entity)) {
      final fieldOnSide = _level.currentGrid[x + rollX][y];
      final fieldBelowSide = _level.currentGrid[x + rollX][y + 1];
      if (fieldOnSide.object == LevelObject.empty &&
          fieldBelowSide.object == LevelObject.empty) {
        print(fieldBelow.object);
        return true;
      }
    }
    return false;
  }

  int startMovement(int x, int y, int moveX, int moveY,
      {bool ghostAtOriginalLocation = false}) {
    final currentField = _level.currentGrid[x][y];
    final nextField = _level.currentGrid[x + moveX][y + moveY];
    final oldEntity = nextField.entity;
    nextField
      ..object = currentField.object
      ..entity = currentField.entity;

    _entities[currentField.entity] = nextField;

    currentField
      ..object = ghostAtOriginalLocation ? LevelObject.ghost : LevelObject.empty
      ..entity = null;

    return oldEntity;
  }

  void removeGhost(int x, int y) {
    final field = _level.currentGrid[x][y];
    if (field.object == LevelObject.ghost) {
      field.object = LevelObject.empty;
    }
  }
}

class Level {
  final List<List<LevelField>> currentGrid;
  Level(this.currentGrid);
}

class LevelField {
  final int x, y;
  LevelObject object;
  int entity;
  LevelField(this.x, this.y, {this.object = LevelObject.empty, this.entity});
}

enum LevelObject { empty, nebula, border, star, world, atlas, end, bean, ghost }
