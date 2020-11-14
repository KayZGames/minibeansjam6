import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers_shared.dart';
import '../components/components.dart';

part 'controller_to_action_system.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Controller,
    Position,
  ],
)
class ControllerToActionSystem extends _$ControllerToActionSystem {
  final _velocity = 10.0;

  @override
  void processEntity(int entity) {
    final controller = controllerMapper[entity];
    final position = positionMapper[entity];
    if (controller.up) {
      final nextY = position.y - _velocity * world.delta;
      if (position.y.ceil() != nextY.ceil()) {
        position.y = nextY.ceilToDouble();
        controller.isMoving = false;
      } else {
        position.y = nextY;
      }
    } else if (controller.down) {
      final nextY = position.y + _velocity * world.delta;
      if (position.y.floor() != nextY.floor()) {
        position.y = nextY.floorToDouble();
        controller.isMoving = false;
      } else {
        position.y = nextY;
      }
    } else if (controller.left) {
      final nextX = position.x - _velocity * world.delta;
      if (position.x.ceil() != nextX.ceil()) {
        position.x = nextX.ceilToDouble();
        controller.isMoving = false;
      } else {
        position.x = nextX;
      }
    } else if (controller.right) {
      final nextX = position.x + _velocity * world.delta;
      if (position.x.floor() != nextX.floor()) {
        position.x = nextX.floorToDouble();
        controller.isMoving = false;
      } else {
        position.x = nextX;
      }
    }
  }
}
