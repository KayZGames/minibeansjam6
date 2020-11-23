import 'dart:html';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../../components/components.dart';
import '../../core/managers/game_state_manager.dart';

part 'controller_system.g.dart';

@Generate(
  GenericInputHandlingSystem,
  allOf: [
    Controller,
  ],
  manager: [
    GameStateManager,
  ],
)
class ControllerSystem extends _$ControllerSystem {
  ControllerSystem() : super(<Element>[]);

  @override
  void processEntity(int entity) {
    final controller = controllerMapper[entity]..reset();
    if (controller.state == PlayerState.stay) {
      controller
        ..restart = restart
        ..space = space
        ..left = left
        ..right = right
        ..up = up
        ..down = down;
    }
  }

  bool get space => isPressed(KeyCode.SPACE);
  bool get restart => isPressed(KeyCode.R);

  @override
  bool checkProcessing() => gameStateManager.state == GameState.playing;
}
