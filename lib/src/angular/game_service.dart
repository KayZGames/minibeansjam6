import 'dart:async';

import '../core/managers/game_state_manager.dart';
import '../game.dart';

class GameService {
  Game _game;
  bool error = false;
  Object errorMessage;
  StackTrace stackTrace;

  final GameStateManager gameStateManager;

  GameService(this.gameStateManager);

  bool get menuVisible => gameStateManager.state == GameState.menu || error;

  bool get gameCanStart => _game != null;

  void initGame() {
    runZonedGuarded(() {
      _game = Game(gameStateManager)
        ..start()
        ..pause();
    }, (errorMessage, stackTrace) {
      error = true;
      this.errorMessage = errorMessage;
      this.stackTrace = stackTrace;
      print(errorMessage);
      print(stackTrace);
    });
  }

  void startGame() {
    if (gameCanStart) {
      _game.resume();
      gameStateManager.state = GameState.playing;
    }
  }
}
