import 'dart:html';

import 'package:gamedev_helpers/gamedev_helpers.dart';

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
class SpriteRenderingSystem extends _$SpriteRenderingSystem {
  double _cameraX, _cameraY;
  CanvasRenderingContext2D ctx;
  SpriteSheet sheet;
  SpriteRenderingSystem(this.ctx, this.sheet);

  @override
  void begin() {
    final camera = tagManager.getEntity(cameraTag);
    if (camera != null) {
      final cameraPosition = positionMapper[camera];
      _cameraX = cameraPosition.x;
      _cameraY = cameraPosition.y;
    }
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
            _cameraX * 64 +
            cameraManager.clientWidth ~/ 2,
        sprite.dst.top +
            position.y * 64 -
            _cameraY * 64 +
            cameraManager.clientHeight ~/ 2,
        sprite.dst.width,
        sprite.dst.height);
  }
}
