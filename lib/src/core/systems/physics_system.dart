import 'dart:math';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../../components/components.dart';
import '../config.dart';
import '../managers/audio_manager.dart';
import '../managers/level_manager.dart';

part 'physics_system.g.dart';

@Generate(
  EntitySystem,
  allOf: [
    Position,
  ],
  manager: [
    LevelManager,
  ],
)
abstract class PhysicsSystem extends _$PhysicsSystem {
  PhysicsSystem(Aspect aspect) : super(aspect);
  @override
  void processEntities(Iterable<int> entities) {
    entities.toList()
      ..sort((entity1, entity2) {
        final position1 = positionMapper[entity1];
        final position2 = positionMapper[entity2];
        final result = position2.y.compareTo(position1.y);
        if (result == 0) {
          return position1.x.compareTo(position2.x);
        }
        return result;
      })
      ..forEach(processEntity);
  }

  void processEntity(int entity);

  @override
  bool checkProcessing() => levelManager.levelLoaded;
}

@Generate(
  PhysicsSystem,
  allOf: [
    CanFall,
  ],
  mapper: [
    CanBeKilledByFallingObject,
    Controller,
  ],
  manager: [
    AudioManager,
  ],
)
class CanFallPhysicsSystem extends _$CanFallPhysicsSystem {
  @override
  void processEntity(int entity) {
    final canFall = canFallMapper[entity];
    final position = positionMapper[entity];
    if (canFall.falling) {
      if (canFall.hasGhost) {
        levelManager.removeGhost(position.x.floor(), position.y.floor());
        canFall.hasGhost = false;
      }
      final nextY = position.y + movementSpeed * world.delta;
      if (nextY.floor() == position.y.floor()) {
        position.y = nextY;
      } else {
        if (levelManager.canFall(entity, position.x.floor(), nextY.floor(),
            isFalling: true)) {
          final previousEntity = levelManager.startMovement(
              position.x.floor(), nextY.floor(), 0, 1);
          position.y = nextY;
          if (previousEntity != null &&
              canBeKilledByFallingObjectMapper.has(previousEntity)) {
            if (controllerMapper.has(previousEntity)) {
              world.createEntity([Controller()]);
            }
            world.deleteEntity(previousEntity);
          }
        } else {
          position.y = nextY.floorToDouble();
          canFall.falling = false;
          audioManager.playAudio(canFall.fallSound);
        }
      }
    } else {
      if (levelManager.canFall(entity, position.x.floor(), position.y.floor(),
          isFalling: false)) {
        final previousEntity = levelManager.startMovement(
            position.x.floor(), position.y.floor(), 0, 1,
            ghostAtOriginalLocation: true);
        position.y += movementSpeed * world.delta;
        canFall
          ..falling = true
          ..hasGhost = true;
        if (previousEntity != null &&
            canBeKilledByFallingObjectMapper.has(previousEntity)) {
          if (controllerMapper.has(previousEntity)) {
            world.createEntity([Controller()]);
          }
          world.deleteEntity(previousEntity);
        }
      }
    }
  }
}

@Generate(
  PhysicsSystem,
  allOf: [
    CanRoll,
    Orientation,
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
      canRoll.rollingLeft = _startRolling(entity, position, -1);
      if (!canRoll.rollingLeft) {
        canRoll.rollingRight = _startRolling(entity, position, 1);
      }
    }
    orientationMapper[entity].angle = 2 * pi * (position.x % 1);
  }

  bool _startRolling(int entity, Position position, int moveX) {
    if (levelManager.canRoll(
        entity, position.x.floor(), position.y.floor(), moveX)) {
      levelManager.startMovement(
          position.x.floor(), position.y.floor(), moveX, 0);
      position.x += moveX * movementSpeed * world.delta;
      return true;
    }
    return false;
  }
}

@Generate(
  EntityProcessingSystem,
  allOf: [
    Position,
    CanBePushed,
  ],
)
class PushSystem extends _$PushSystem {
  @override
  void processEntity(int entity, Position position, CanBePushed canBePushed) {
    if (canBePushed.pushed) {
      final nextX = position.x + canBePushed.x * movementSpeed * world.delta;
      if (canBePushed.x > 0) {
        if (nextX.floor() == position.x.floor()) {
          position.x = nextX;
        } else {
          position.x = nextX.floorToDouble();
          canBePushed.pushed = false;
        }
      } else if (canBePushed.x < 0) {
        if (nextX.ceil() == position.x.ceil()) {
          position.x = nextX;
        } else {
          position.x = nextX.ceilToDouble();
          canBePushed.pushed = false;
        }
      }
    }
  }
}
