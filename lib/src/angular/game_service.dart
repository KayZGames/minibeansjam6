import 'dart:async';

import '../core/managers/game_state_manager.dart';
import '../game.dart';

class GameService {
  late Game _game;
  bool gameCanStart = false;
  bool error = false;
  Object? errorMessage;
  StackTrace? stackTrace;

  final GameStateManager gameStateManager;

  GameService(this.gameStateManager);

  bool get menuVisible => gameStateManager.state == GameState.menu || error;



  void initGame() {
    runZonedGuarded(() {
      _game = Game(gameStateManager)
        ..start()
        ..pause();
      gameCanStart = true;
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
