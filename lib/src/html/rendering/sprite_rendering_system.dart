import 'dart:html';

import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../../components/components.dart';

part 'sprite_rendering_system.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Position,
    Renderable,
  ],
  manager: [
    TagManager,
    CameraManager,
  ],
)
abstract class SpriteRenderingSystem extends _$SpriteRenderingSystem {
  Position _cameraPosition;
  CanvasRenderingContext2D ctx;
  SpriteSheet sheet;
  SpriteRenderingSystem(this.ctx, this.sheet);

  @override
  void begin() {
    final camera = tagManager.getEntity(cameraTag);
    _cameraPosition = positionMapper[camera];
  }

  @override
  void processEntity(int entity) {
    final position = positionMapper[entity];
    final renderable = renderableMapper[entity];
    final name = renderable.name;
    assert(sheet.sprites.containsKey(name),
        'sprite $name does not exist in ${sheet.sprites.keys.join(', ')}');
    final sprite = sheet.sprites[name];

    ctx.drawImageScaledFromSource(
        sheet.image,
        sprite.src.left,
        sprite.src.top,
        sprite.src.width,
        sprite.src.height,
        sprite.dst.left +
            position.x * 64 -
            _cameraPosition.x * 64 +
            cameraManager.clientWidth ~/ 2,
        sprite.dst.top +
            position.y * 64 -
            _cameraPosition.y * 64 +
            cameraManager.clientHeight ~/ 2,
        sprite.dst.width,
        sprite.dst.height);
  }
}

@Generate(
  SpriteRenderingSystem,
  allOf: [
    Nebula,
  ],
)
class NebulaRenderingSystem extends _$NebulaRenderingSystem {
  NebulaRenderingSystem(CanvasRenderingContext2D ctx, SpriteSheet sheet)
      : super(ctx, sheet);
}
