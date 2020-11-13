import 'package:dartemis/dartemis.dart';

class GameStateManager extends Manager {
  GameState state = GameState.menu;
}

enum GameState { menu, playing }
