import 'dart:html';

import 'package:gamedev_helpers/gamedev_helpers.dart';
import '../../components/components.dart';

part 'controller_system.g.dart';

@Generate(
  GenericInputHandlingSystem,
  allOf: [
    Controller,
  ],
)
class ControllerSystem extends _$ControllerSystem {
  ControllerSystem() : super(<Element>[]);

  @override
  void processEntity(int entity) {
    final controller = controllerMapper[entity]..reset();
    if (controller.state == PlayerState.stay) {
      if (up) {
        controller.up = true;
      } else if (down) {
        controller.down = true;
      } else if (left) {
        controller.left = true;
      } else if (right) {
        controller.right = true;
      }
    }
  }
}
