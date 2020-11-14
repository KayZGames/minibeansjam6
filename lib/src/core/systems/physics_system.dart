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
