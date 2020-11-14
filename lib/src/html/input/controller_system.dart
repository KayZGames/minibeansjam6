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
    final c = controllerMapper[entity]..reset();
    if (!c.isMoving) {
      if (up) {
        c
          ..up = true
          ..isMoving = true;
      } else if (down) {
        c
          ..down = true
          ..isMoving = true;
      } else if (left) {
        c
          ..left = true
          ..isMoving = true;
      } else if (right) {
        c
          ..right = true
          ..isMoving = true;
      }
    }
  }
}
