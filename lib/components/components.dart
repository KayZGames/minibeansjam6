import 'package:dartemis/dartemis.dart';

class Controller extends Component {
  bool up, down, left, right;
  bool upleft, upright, downleft, downright;

  Controller(
      {this.up = false,
      this.down = false,
      this.left = false,
      this.right = false,
      this.upleft = false,
      this.upright = false,
      this.downleft = false,
      this.downright = false});

  void reset() {
    up = false;
    down = false;
    left = false;
    right = false;
    upleft = false;
    upright = false;
    downleft = false;
    downright = false;
  }
}
