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
      controller
        ..space = space
        ..left = left
        ..right = right
        ..up = up
        ..down = down;
    }
  }

  bool get space => isPressed(KeyCode.SPACE);
}
