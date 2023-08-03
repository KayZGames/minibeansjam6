import 'dart:html';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../../core/managers/game_state_manager.dart';
import '../../core/systems/game_time_system.dart';

part 'finish_game_system.g.dart';

@Generate(
  VoidEntitySystem,
  systems: [
    GameTimeSystem,
  ],
  manager: [
    GameStateManager,
    CameraManager,
  ],
)
class FinishGameSystem extends _$FinishGameSystem {
  CanvasRenderingContext2D ctx;
  FinishGameSystem(this.ctx);
  @override
  void processSystem() {
    final centerWidth = cameraManager.clientWidth ~/ 2;
    final centerHeight = cameraManager.clientHeight ~/ 2;
    ctx.font = '40px Verdana';

    const winnerText = 'WINNER, WINNER, BEANS FOR DINNER';
    final winnerTextWidth = ctx.measureText(winnerText).width!;
    ctx
      ..fillStyle = '#101010F0'
      ..fillRect(centerWidth - winnerTextWidth / 2 - 10, centerHeight - 60,
          winnerTextWidth + 20, 120)
      ..fillStyle = 'white'
      ..fillText(
          winnerText, centerWidth - winnerTextWidth / 2, centerHeight - 50)
      ..font = '20px Verdana';

    const completionText = 'You completed the game in';
    final completiongTextWidth = ctx.measureText(completionText).width!;
    ctx.fillText(
        completionText, centerWidth - completiongTextWidth / 2, centerHeight);

    final time = gameTimeSystem.playTime;
    final minutes = time ~/ 60;
    final seconds = ((time % 60) ~/ 1).toString().padLeft(2, '0');
    final ms = (((time % 1) * 1000) ~/ 1).toString().padLeft(3, '0');
    final timeText = '$minutes:$seconds:$ms';
    final timeTextWidth = ctx.measureText(timeText).width!;
    ctx.fillText(timeText, centerWidth - timeTextWidth / 2, centerHeight + 30);
  }

  @override
  bool checkProcessing() => gameStateManager.state == GameState.finished;
}
