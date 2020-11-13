import 'dart:html';

import 'package:gamedev_helpers/gamedev_helpers.dart';

part 'position_rendering_system.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Position,
  ],
  manager: [
    CameraManager,
  ],
)
class PositionRenderingSystem extends _$PositionRenderingSystem {
  CanvasRenderingContext2D ctx;
  PositionRenderingSystem(this.ctx);

  @override
  void processEntity(int entity) {
    final position = positionMapper[entity];

    ctx
      ..fillStyle = 'white'
      ..fillRect(
          position.x * cameraManager.width,
          -position.y * cameraManager.height,
          0.01 * cameraManager.width,
          0.01 * cameraManager.height);
  }
}
