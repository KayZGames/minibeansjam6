import 'package:dartemis/dartemis.dart';

import '../../components/components.dart';
import '../managers/level_manager.dart';

part 'next_level_system.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Controller,
  ],
  manager: [
    LevelManager,
  ],
)
class NextLevelSystem extends _$NextLevelSystem {
  @override
  void processEntity(int entity) {
    final controller = controllerMapper[entity];
    if (controller.state == PlayerState.finishLevel) {
      levelManager.nextLevel();
    } else if (controller.restart) {
      levelManager.restartLevel();
    }
  }
}
