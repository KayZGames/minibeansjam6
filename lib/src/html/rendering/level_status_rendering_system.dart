import 'dart:html';
import 'dart:math';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../../core/managers/level_manager.dart';

part 'level_status_rendering_system.g.dart';

@Generate(
  VoidEntitySystem,
  manager: [
    LevelManager,
    CameraManager,
  ],
)
class LevelStatusRenderingSystem extends _$LevelStatusRenderingSystem {
  CanvasRenderingContext2D ctx;
  LevelStatusRenderingSystem(this.ctx);
  @override
  void processSystem() {
    final remaining = levelManager.level.beansRemaining;
    final required = levelManager.level.beansRequired;
    final collected = levelManager.level.beansCollected;
    final leftToCollect = max(0, required - collected);

    ctx.font = '30px Verdana';

    final remainingText =
        '$remaining bean${remaining != 1 ? 's' : ''} in level';
    final leftToCollectText =
        '''$leftToCollect bean${leftToCollect != 1 ? 's' : ''} needed for next level''';

    final leftToCollectWidth = ctx.measureText(leftToCollectText).width!;

    ctx
      ..fillStyle = 'grey'
      ..fillRect(0, 0, cameraManager.clientWidth, 50)
      ..fillStyle = 'white'
      ..fillText(remainingText, 50, 10)
      ..fillText(leftToCollectText,
          cameraManager.clientWidth - leftToCollectWidth - 50, 10);
  }
}
