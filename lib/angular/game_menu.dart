import 'package:angular/angular.dart';
import 'package:gamejam_template/angular/game_service.dart';

@Component(
  selector: 'game-menu',
  templateUrl: 'game_menu.html',
  styleUrls: ['game_menu.css'],
  directives: [
    coreDirectives,
  ],
)
class GameMenu {
  GameService gameService;
  GameMenu(this.gameService);
  bool get gameCanStart => gameService.gameCanStart;
  bool get error => gameService.error;
  String get errorMessage => gameService.errorMessage.toString();
  String get stackTrace => gameService.stackTrace.toString();

  void startGame() {
    gameService.startGame();
  }
}

