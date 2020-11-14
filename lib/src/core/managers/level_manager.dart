import 'package:dartemis/dartemis.dart';
import 'package:minibeansjam6/src/components/components.dart';

part 'level_manager.g.dart';

@Generate(Manager)
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

enum LevelObject { empty, nebula, border, star, world, atlas, end, bean }
