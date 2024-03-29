import 'package:ngdart/angular.dart';

import 'src/angular/game_menu.dart';
import 'src/angular/game_service.dart';
import 'src/core/managers/game_state_manager.dart';

@Component(
  selector: 'game-container',
  templateUrl: 'game_container.html',
  styleUrls: ['game_container.css'],
  providers: [
    ClassProvider(GameService),
    ClassProvider(GameStateManager),
  ],
  directives: [
    GameMenu,
    coreDirectives,
  ],
)
class GameContainer implements OnInit {
  GameService gameService;
  GameContainer(this.gameService);
  bool get menuVisible => gameService.menuVisible;

  @override
  void ngOnInit() {
    gameService.initGame();
  }
}
