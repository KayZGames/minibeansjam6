import 'package:dartemis/dartemis.dart';

class Controller extends Component {
  bool up, down, left, right;
  PlayerState state;

  Controller({
    this.up = false,
    this.down = false,
    this.left = false,
    this.right = false,
    this.state = PlayerState.stay,
  });

  void reset() {
    if (state == PlayerState.stay) {
      up = false;
      down = false;
      left = false;
      right = false;
    }
  }
}

class Nebula extends Component {}

enum PlayerState { stay, move, push, eat }
