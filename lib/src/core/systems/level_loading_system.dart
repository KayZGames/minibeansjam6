import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../../assets.dart';
import '../../components/components.dart';
import '../config.dart';
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
    final levelAsset = levels[Levels.values[levelManager.levelNumber]];
    final levelDefinition = levelAsset.text;
    final levelData = levelDefinition.split(';');
    final beansRequired = int.parse(levelData[2]);
    final width = int.parse(levelData[0]);
    final height = int.parse(levelData[1]);
    final level = Level(
        beansRequired,
        List.generate(
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
                'unknown tile $levelColumn@$x:$y in ${levelAsset.assetId}');
        }
        final components = [
          Position(x.toDouble(), y.toDouble()),
          Renderable(spriteSheet, type),
          Orientation(0),
        ];
        switch (field.object) {
          case LevelObject.atlas:
            components.addAll([
              Controller(),
              Camera(),
              CanBeKilledByFallingObject(),
            ]);
            break;
          case LevelObject.bean:
            components.addAll([
              CanFall(Sfx.worldDrop$ogg),
              CanRoll(),
              CanBeConsumed(),
              CanBeRolledOn(),
              Bean(),
            ]);
            break;
          case LevelObject.world:
            components.addAll([
              CanFall(Sfx.worldDrop$ogg),
              CanRoll(),
              CanBePushed(),
              CanBeRolledOn(),
            ]);
            break;
          case LevelObject.nebula:
            components.addAll([
              CanBeConsumed(),
              Nebula(),
            ]);
            break;
          case LevelObject.star:
            components.addAll([
              CanBeRolledOn(),
            ]);
            break;
          case LevelObject.border:
            components.addAll([
              Border(),
            ]);
            break;
          case LevelObject.empty:
          case LevelObject.end:
          case LevelObject.ghost:
            break;
        }
        final entity = world.createEntity(components);
        field.entity = entity;
        if (field.object == LevelObject.atlas) {
          tagManager.register(entity, cameraTag);
        }
        if (field.object == LevelObject.end) {
          tagManager.register(entity, endTag);
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
