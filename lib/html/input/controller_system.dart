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
    if (up) {
      if (left) {
        c.upleft = true;
      } else if (right) {
        c.upright = true;
      } else {
        c.up = true;
      }
    } else if (down) {
      if (left) {
        c.downleft = true;
      } else if (right) {
        c.downright = true;
      } else {
        c.down = true;
      }
    } else if (left) {
      c.left = true;
    } else if (right) {
      c.right = true;
    }
  }
}
