import 'package:dartemis/dartemis.dart';

import '../../assets.dart';
import '../../components/components.dart';
import '../managers/game_state_manager.dart';
import '../managers/level_manager.dart';

part 'next_level_system.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Controller,
  ],
  manager: [
    LevelManager,
    GameStateManager,
  ],
)
class NextLevelSystem extends _$NextLevelSystem {
  @override
  void processEntity(int entity, Controller controller) {
    if (controller.state == PlayerState.finishLevel) {
      if (levelManager.levelNumber < Levels.values.length - 1) {
        levelManager.nextLevel();
      } else {
        gameStateManager.state = GameState.finished;
      }
    } else if (controller.restart) {
      levelManager.restartLevel();
    }
  }
}
