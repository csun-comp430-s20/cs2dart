import '../expression.dart';

class MultExp implements Exp {

  MultExp(this._left, this._right);

  final Exp _left;
  final Exp _right;

  Exp get left {
    return _left;
  }

  Exp get right {
    return _right;
  }
}
