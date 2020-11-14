import 'package:dartemis/dartemis.dart';

class Controller extends Component {
  bool up, down, left, right;
  bool isMoving;

  Controller({
    this.up = false,
    this.down = false,
    this.left = false,
    this.right = false,
    this.isMoving = false,
  });

  void reset() {
    if (!isMoving) {
      up = false;
      down = false;
      left = false;
      right = false;
    }
  }
}
