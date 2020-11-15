import 'package:gamedev_helpers/gamedev_helpers.dart';

import 'core/managers/game_state_manager.dart';
import 'core/managers/level_manager.dart';
import 'core/systems/controller_to_action_system.dart';
import 'core/systems/game_time_system.dart';
import 'core/systems/level_loading_system.dart';
import 'core/systems/next_level_system.dart';
import 'core/systems/physics_system.dart';
import 'html/input/controller_system.dart';
import 'html/rendering/finish_game_system.dart';
import 'html/rendering/sprite_rendering_system.dart';

class Game extends GameBase {
  final GameStateManager gameStateManager;
  Game(this.gameStateManager)
      : super('minibeansjam6', 'canvas#game', bodyDefsName: null);

  @override
  void createEntities() {
    final tagManager = TagManager();
    world
      ..addManager(tagManager)
      ..addManager(gameStateManager)
      ..addManager(LevelManager());
  }

  @override
  Map<int, List<EntitySystem>> getSystems() => {
        GameBase.rendering: [
          LevelLoadingSystem(spriteSheet),
          ControllerSystem(),
          ControllerToActionSystem(),
          PushSystem(),
          CanFallPhysicsSystem(),
          CanRollPhysicsSystem(),
          CanvasCleaningSystem(canvas, fillStyle: 'green'),
          BorderRenderingSystem(ctx, spriteSheet),
          NebulaRenderingSystem(ctx, spriteSheet),
          SpriteRenderingSystem(ctx, spriteSheet),
          GameTimeSystem(),
          FpsRenderingSystem(ctx, 'white'),
          NextLevelSystem(),
          FinishGameSystem(ctx),
        ],
      };
}
