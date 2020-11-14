import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers_shared.dart';

import '../../components/components.dart';
import '../config.dart';
import '../managers/level_manager.dart';

part 'controller_to_action_system.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Controller,
    Position,
  ],
  manager: [
    LevelManager,
  ],
)
class ControllerToActionSystem extends _$ControllerToActionSystem {
  @override
  void processEntity(int entity) {
    final controller = controllerMapper[entity];
    final position = positionMapper[entity];
    var moveX = 0;
    var moveY = 0;

    if (controller.up) {
      moveY = -1;
    } else if (controller.down) {
      moveY = 1;
    } else if (controller.left) {
      moveX = -1;
    } else if (controller.right) {
      moveX = 1;
    }
    if (controller.state == PlayerState.stay && (moveX != 0 || moveY != 0)) {
      final nextState = levelManager.playerStateForMove(
          position.x.floor(), position.y.floor(), moveX, moveY);
      controller.state = nextState;
      if (controller.state == PlayerState.eat) {
        levelManager.eat(position.x.floor(), position.y.floor(), moveX, moveY);
      }
      if (controller.state != PlayerState.stay) {
        levelManager.startMovement(
            position.x.floor(), position.y.floor(), moveX, moveY);
      }
    }
    if (controller.state != PlayerState.stay) {
      final nextX = position.x + moveX * movementSpeed * world.delta;
      final nextY = position.y + moveY * movementSpeed * world.delta;
      if (moveY < 0 && position.y.ceil() != nextY.ceil()) {
        levelManager.removeGhost(position.x.floor(), position.y.ceil());
        position.y = nextY.ceilToDouble();
        controller.state = PlayerState.stay;
      } else if (moveY > 0 && position.y.floor() != nextY.floor()) {
        levelManager.removeGhost(position.x.floor(), position.y.floor());
        position.y = nextY.floorToDouble();
        controller.state = PlayerState.stay;
      } else if (moveX < 0 && position.x.ceil() != nextX.ceil()) {
        levelManager.removeGhost(position.x.ceil(), position.y.floor());
        position.x = nextX.ceilToDouble();
        controller.state = PlayerState.stay;
      } else if (moveX > 0 && position.x.floor() != nextX.floor()) {
        levelManager.removeGhost(position.x.floor(), position.y.floor());
        position.x = nextX.floorToDouble();
        controller.state = PlayerState.stay;
      } else {
        position
          ..x = nextX
          ..y = nextY;
      }
    }
  }
}
