import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../../assets.dart';
import '../../components/components.dart';
import '../config.dart';
import 'audio_manager.dart';

part 'level_manager.g.dart';

@Generate(
  Manager,
  mapper: [
    CanBeRolledOn,
    CanRoll,
    CanFall,
    CanBePushed,
    Bean,
    Renderable,
  ],
  manager: [
    TagManager,
    AudioManager,
  ],
)
class LevelManager extends _$LevelManager {
  int _levelNumber = 0;
  Level _level;
  final Map<int, LevelField> _entities = {};

  bool get levelLoaded => _level != null;
  int get levelNumber => _levelNumber;

  int get levelWidth => _level?.currentGrid?.length ?? 0;
  int get levelHeight => _level?.currentGrid[0].length ?? 0;

  Level get level => _level;
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
      case LevelObject.end:
        if (_level.beansRequired <= _level.beansCollected) {
          return PlayerState.finishLevel;
        }
        return PlayerState.stay;
      case LevelObject.empty:
      case LevelObject.atlas:
      case LevelObject.ghost:
        return PlayerState.move;
      case LevelObject.nebula:
      case LevelObject.bean:
        if (canFallMapper.has(field.entity)) {
          if (canFallMapper[field.entity].falling) {
            return PlayerState.stay;
          }
        }
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
    if (field.entity != null && beanMapper.has(field.entity)) {
      _level.beansCollected++;
      _level.beansRemaining--;
      if (_level.beansCollected == _level.beansRequired) {
        final end = tagManager.getEntity(endTag);
        renderableMapper[end].name = 'end_open';
        audioManager.playAudio(Sfx.lastBean$ogg);
      } else {
        audioManager.playAudio(Sfx.eatBean$ogg);
      }
    }
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

  void nextLevel() {
    _levelNumber++;
    _level = null;
    world.deleteAllEntities();
  }

  void push(int x, int y, int moveX) {
    final entity = _level.currentGrid[x][y].entity;
    assert(entity != null, 'null entity at $x:$y');
    if (canBePushedMapper.has(entity)) {
      canBePushedMapper[entity]
        ..pushed = true
        ..x = moveX;
      startMovement(x, y, moveX, 0);
    }
  }

  void restartLevel() {
    _level = null;
    world.deleteAllEntities();
  }
}

class Level {
  final int beansRequired;
  final List<List<LevelField>> currentGrid;
  int beansCollected = 0;
  int beansRemaining = 0;
  Level(this.beansRequired, this.currentGrid);
}

class LevelField {
  final int x, y;
  LevelObject object;
  int entity;
  LevelField(this.x, this.y, {this.object = LevelObject.empty, this.entity});
}

enum LevelObject { empty, nebula, border, star, world, atlas, end, bean, ghost }
