import 'package:dartemis/dartemis.dart';

import '../managers/game_state_manager.dart';

part 'game_time_system.g.dart';

@Generate(
  VoidEntitySystem,
  manager: [
    GameStateManager,
  ],
)
class GameTimeSystem extends _$GameTimeSystem {
  double playTime = 0;
  @override
  void processSystem() {
    playTime += world.delta;
  }

  @override
  bool checkProcessing() => gameStateManager.state == GameState.playing;
}
