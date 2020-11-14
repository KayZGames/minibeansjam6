import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:minibeansjam6/src/assets.dart';

import 'components/components.dart';
import 'core/controller_to_action_system.dart';
import 'core/managers/game_state_manager.dart';
import 'html/input/controller_system.dart';
import 'html/rendering/sprite_rendering_system.dart';

class Game extends GameBase {
  final GameStateManager gameStateManager;
  Game(this.gameStateManager)
      : super('minibeansjam6', 'canvas#game', bodyDefsName: null);

  @override
  void createEntities() {
    world.addManager(gameStateManager);

    final tagManager = TagManager();
    world.addManager(tagManager);

    final startLevelAsset = levels[Levels.level000$txt];
    final startLevel = startLevelAsset.text;
    final startLevelData = startLevel.split(';');
    // final beansRequired = int.parse(startLevelData[0]);
    final levelLayout = startLevelData[1];
    final levelRows = levelLayout.split('\n');
    var y = .0;
    for (final levelRow in levelRows) {
      var x = .0;
      final levelColumns = levelRow.split('');
      for (final levelColumn in levelColumns) {
        String type;
        switch (levelColumn) {
          case 'F':
            x++;
            continue;
          case '#':
            type = 'border';
            break;
          case '*':
            type = 'star';
            break;
          case 'W':
            type = 'world';
            break;
          case 'A':
            type = 'atlas';
            break;
          case 'B':
            type = 'bean';
            break;
          case 'E':
            type = 'end';
            break;
          case ' ':
            type = 'nebula';
            break;
          default:
            throw Exception(
                'unkonw tile $levelColumn@$x:$y in ${startLevelAsset.assetId}');
        }
        if (type == 'atlas') {
          final player = addEntity([
            Controller(),
            Camera(),
            Position(x, y),
            Renderable(spriteSheet, type),
          ]);
          tagManager.register(player, cameraTag);
        } else {
          addEntity([
            Position(x, y),
            Renderable(spriteSheet, type),
          ]);
        }
        x++;
      }
      y++;
    }
  }

  @override
  Map<int, List<EntitySystem>> getSystems() => {
        GameBase.rendering: [
          ControllerSystem(),
          ControllerToActionSystem(),
          CanvasCleaningSystem(canvas, fillStyle: 'green'),
          SpriteRenderingSystem(ctx, spriteSheet),
          FpsRenderingSystem(ctx, 'white'),
        ],
      };
}
