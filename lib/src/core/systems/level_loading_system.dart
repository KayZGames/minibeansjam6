import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../../assets.dart';
import '../../components/components.dart';
import '../managers/level_manager.dart';

part 'level_loading_system.g.dart';

@Generate(
  VoidEntitySystem,
  manager: [
    TagManager,
    LevelManager,
  ],
)
class LevelLoadingSystem extends _$LevelLoadingSystem {
  SpriteSheet spriteSheet;
  LevelLoadingSystem(this.spriteSheet);
  @override
  void processSystem() {
    final levelAsset = levels[Levels.level000$txt];
    final levelDefinition = levelAsset.text;
    final levelData = levelDefinition.split(';');
    // final beansRequired = int.parse(levelData[0]);
    final width = int.parse(levelData[0]);
    final height = int.parse(levelData[1]);
    final level = Level(List.generate(
        width, (x) => List.generate(height, (y) => LevelField(x, y))));
    final levelLayout = levelData[3];
    final levelRows = levelLayout.split('\n').skip(1);
    var y = 0;
    for (final levelRow in levelRows) {
      var x = 0;
      final levelColumns = levelRow.split('');
      for (final levelColumn in levelColumns) {
        String type;
        final field = level.currentGrid[x][y];
        switch (levelColumn) {
          case 'F':
            x++;
            continue;
          case '#':
            type = 'border';
            field.object = LevelObject.border;
            break;
          case '*':
            type = 'star';
            field.object = LevelObject.star;
            break;
          case 'W':
            type = 'world';
            field.object = LevelObject.world;
            break;
          case 'A':
            type = 'atlas';
            field.object = LevelObject.atlas;
            break;
          case 'B':
            type = 'bean';
            field.object = LevelObject.bean;
            break;
          case 'E':
            type = 'end';
            field.object = LevelObject.end;
            break;
          case ' ':
            type = 'nebula';
            field.object = LevelObject.nebula;
            break;
          default:
            throw Exception(
                'unkonw tile $levelColumn@$x:$y in ${levelAsset.assetId}');
        }
        if (type == 'atlas') {
          final player = world.createEntity([
            Controller(),
            Camera(),
            Position(x.toDouble(), y.toDouble()),
            Renderable(spriteSheet, type),
          ]);
          tagManager.register(player, cameraTag);
          field.entity = player;
        } else {
          final entity = world.createEntity([
            Position(x.toDouble(), y.toDouble()),
            Renderable(spriteSheet, type),
          ]);
          field.entity = entity;
        }
        x++;
      }
      y++;
    }
    levelManager.level = level;
  }

  @override
  bool checkProcessing() => !levelManager.levelLoaded;
}
