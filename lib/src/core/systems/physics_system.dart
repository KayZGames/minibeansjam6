import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../../components/components.dart';
import '../config.dart';
import '../managers/level_manager.dart';

part 'physics_system.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Position,
    CanFall,
  ],
  manager: [
    LevelManager,
  ],
)
class CanFallPhysicsSystem extends _$CanFallPhysicsSystem {
  @override
  void processEntity(int entity) {
    final canFall = canFallMapper[entity];
    final position = positionMapper[entity];
    if (canFall.falling) {
      final nextY = position.y + movementSpeed * world.delta;
      if (nextY.floor() == position.y.floor()) {
        position.y = nextY;
      } else {
        if (levelManager.canFall(position.x.floor(), nextY.floor(),
            isFalling: true)) {
          levelManager.startMovement(position.x.floor(), nextY.floor(), 0, 1);
          position.y = nextY;
        } else {
          position.y = nextY.floorToDouble();
          canFall.falling = false;
        }
      }
    } else {
      if (levelManager.canFall(position.x.floor(), position.y.floor(),
          isFalling: false)) {
        levelManager.startMovement(
            position.x.floor(), position.y.floor(), 0, 1);
        position.y += movementSpeed * world.delta;
        canFall.falling = true;
      }
    }
  }
}

@Generate(
  EntityProcessingSystem,
  allOf: [
    Position,
    CanRoll,
  ],
  manager: [
    LevelManager,
  ],
)
class CanRollPhysicsSystem extends _$CanRollPhysicsSystem {
  @override
  void processEntity(int entity) {
    final canRoll = canRollMapper[entity];
    final position = positionMapper[entity];
    if (canRoll.rollingLeft) {
      final nextX = position.x - movementSpeed * world.delta;
      if (nextX.ceil() == position.x.ceil()) {
        position.x = nextX;
      } else {
        position.x = nextX.ceilToDouble();
        canRoll.rollingLeft = false;
      }
    } else if (canRoll.rollingRight) {
      final nextX = position.x + movementSpeed * world.delta;
      if (nextX.floor() == position.x.floor()) {
        position.x = nextX;
      } else {
        position.x = nextX.floorToDouble();
        canRoll.rollingRight = false;
      }
    } else {
      canRoll.rollingLeft = _startRolling(position, -1);
      if (!canRoll.rollingLeft) {
        canRoll.rollingRight = _startRolling(position, 1);
      }
    }
  }

  bool _startRolling(Position position, int moveX) {
    if (levelManager.canRoll(position.x.floor(), position.y.floor(), moveX)) {
      levelManager.startMovement(
          position.x.floor(), position.y.floor(), moveX, 0);
      position.x += moveX * movementSpeed * world.delta;
      return true;
    }
    return false;
  }
}
