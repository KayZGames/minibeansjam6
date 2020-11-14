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

class CanFall extends Component {
  bool falling = false;
}

class CanRoll extends Component {
  bool rollingLeft = false;
  bool rollingRight = false;
  bool get rolling => rollingLeft || rollingRight;
}

class CanBeRolledOn extends Component {}

class CanBePushed extends Component {
  bool pushed = false;
}

class CanBeConsumed extends Component {
  bool consumed = false;
}

class Bean extends Component {}

class CanBeKilledByFallingObject extends Component {}

enum PlayerState { stay, move, push, eat, finishLevel }
